import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tv/tv_series.dart';

part 'see_more_top_rated_tv_event.dart';

part 'see_more_top_rated_tv_state.dart';

part 'see_more_top_rated_tv_bloc.freezed.dart';

class SeeMoreTopRatedTvBloc
    extends Bloc<SeeMoreTopRatedTvEvent, SeeMoreTopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  SeeMoreTopRatedTvBloc({required this.getTopRatedTv}) : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialTopRatedTv>(_onFetchInitialTopRatedTv);

    // For Refresh
    on<RefreshTv>(_onRefreshTv);

    // For FetchMore
    on<FetchMoreTopRatedTv>(_onFetchMoreTopRatedTv, transformer: droppable());
  }

  // Helper function untuk logika scroll
  void onScroll(ScrollController controller, VoidCallback action) {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      action();
    }
  }

  Future<void> _onFetchInitialTopRatedTv(
    FetchInitialTopRatedTv event,
    Emitter<SeeMoreTopRatedTvState> emit,
  ) async {
    emit(const SeeMoreTopRatedTvState.loading());

    // Fetch kategori Popular
    final results = await Future.wait([getTopRatedTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(SeeMoreTopRatedTvState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMoreTopRatedTvState.loaded(
        topRatedTv: results[0].getOrElse(() => []),
        topRatedTvPage: 2,
        hasMoreTopRatedTv: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshTv event,
    Emitter<SeeMoreTopRatedTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialTopRatedTv());
  }

  Future<void> _onFetchMoreTopRatedTv(
    FetchMoreTopRatedTv event,
    Emitter<SeeMoreTopRatedTvState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      if (!currentState.hasMoreTopRatedTv) return;

      final result = await getTopRatedTv.execute(currentState.topRatedTvPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newTv) => emit(
          currentState.copyWith(
            topRatedTv: List.of(currentState.topRatedTv)..addAll(newTv),
            topRatedTvPage: currentState.topRatedTvPage + 1,
            hasMoreTopRatedTv: newTv.isNotEmpty,
          ),
        ),
      );
    }
  }
}
