import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/tv/tv_series.dart';

part 'see_more_popular_tv_event.dart';

part 'see_more_popular_tv_state.dart';

part 'see_more_popular_tv_bloc.freezed.dart';

class SeeMorePopularTvBloc
    extends Bloc<SeeMorePopularTvEvent, SeeMorePopularTvState> {
  final GetPopularTv getPopularTv;

  SeeMorePopularTvBloc({required this.getPopularTv}) : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialPopularTv>(_onFetchInitialPopularTv);

    // For Refresh
    on<RefreshTv>(_onRefreshTv);

    // For FetchMore
    on<FetchMorePopularTv>(_onFetchMorePopularTv, transformer: droppable());
  }

  // Helper function untuk logika scroll
  void onScroll(ScrollController controller, VoidCallback action) {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      action();
    }
  }

  Future<void> _onFetchInitialPopularTv(
    FetchInitialPopularTv event,
    Emitter<SeeMorePopularTvState> emit,
  ) async {
    emit(const SeeMorePopularTvState.loading());

    // Fetch kategori Popular
    final results = await Future.wait([getPopularTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(SeeMorePopularTvState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMorePopularTvState.loaded(
        popularTv: results[0].getOrElse(() => []),
        popularTvPage: 2,
        hasMorePopularTv: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshTv event,
    Emitter<SeeMorePopularTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialPopularTv());
  }

  Future<void> _onFetchMorePopularTv(
    FetchMorePopularTv event,
    Emitter<SeeMorePopularTvState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      if (!currentState.hasMorePopularTv) return;

      final result = await getPopularTv.execute(currentState.popularTvPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newTv) => emit(
          currentState.copyWith(
            popularTv: List.of(currentState.popularTv)..addAll(newTv),
            popularTvPage: currentState.popularTvPage + 1,
            hasMorePopularTv: newTv.isNotEmpty,
          ),
        ),
      );
    }
  }
}
