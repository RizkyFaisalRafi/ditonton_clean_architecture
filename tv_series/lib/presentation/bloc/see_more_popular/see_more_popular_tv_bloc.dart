import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../domain/usecases/get_popular_tv.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/tv_series.dart';

part 'see_more_popular_tv_event.dart';

part 'see_more_popular_tv_state.dart';

part 'see_more_popular_tv_bloc.freezed.dart';

class SeeMorePopularTvBloc
    extends Bloc<SeeMorePopularTvEvent, SeeMorePopularTvState> {
  final GetPopularTv getPopularTv;

  SeeMorePopularTvBloc({required this.getPopularTv})
    : super(InitialPopularTSeeMore()) {
    // Fetch untuk pertama kali
    on<FetchInitialPopularSeeMoreTv>(_onFetchInitialPopularTv);

    // For Refresh
    on<RefreshPopularTv>(_onRefreshTv);

    // For FetchMore
    on<FetchMorePopularSeeMoreTv>(
      _onFetchMorePopularTv,
      transformer: droppable(),
    );
  }

  // Helper function untuk logika scroll
  void onScroll(ScrollController controller, VoidCallback action) {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      action();
    }
  }

  Future<void> _onFetchInitialPopularTv(
    FetchInitialPopularSeeMoreTv event,
    Emitter<SeeMorePopularTvState> emit,
  ) async {
    emit(const SeeMorePopularTvState.loadingPopularTSeeMore());

    // Fetch kategori Popular
    final results = await Future.wait([getPopularTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) =>
            emit(SeeMorePopularTvState.errorPopularTSeeMore(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMorePopularTvState.loadedPopularTSeeMore(
        popularTv: results[0].getOrElse(() => []),
        popularTvPage: 2,
        hasMorePopularTv: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshPopularTv event,
    Emitter<SeeMorePopularTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialPopularSeeMoreTv());
  }

  Future<void> _onFetchMorePopularTv(
    FetchMorePopularSeeMoreTv event,
    Emitter<SeeMorePopularTvState> emit,
  ) async {
    if (state is LoadedPopularTSeeMore) {
      final currentState = state as LoadedPopularTSeeMore;
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
