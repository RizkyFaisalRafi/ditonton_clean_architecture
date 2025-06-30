import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../domain/usecases/get_on_the_air_tv.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/tv_series.dart';

part 'see_more_on_the_air_tv_event.dart';

part 'see_more_on_the_air_tv_state.dart';

part 'see_more_on_the_air_tv_bloc.freezed.dart';

class SeeMoreOnTheAirTvBloc
    extends Bloc<SeeMoreOnTheAirTvEvent, SeeMoreOnTheAirTvState> {
  final GetOnTheAirTv getOnTheAirTv;

  SeeMoreOnTheAirTvBloc({required this.getOnTheAirTv})
    : super(InitialOnTheAirTSeeMore()) {
    // Fetch untuk pertama kali
    on<FetchInitialOnTheAirSeeMoreTv>(_onFetchInitialOnTheAirTv);

    // For Refresh
    on<RefreshOnTheAirTv>(_onRefreshTv);

    // For FetchMore
    on<FetchMoreOnTheAirSeeMoreTv>(
      _onFetchMoreOnTheAirTv,
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

  Future<void> _onFetchInitialOnTheAirTv(
    FetchInitialOnTheAirSeeMoreTv event,
    Emitter<SeeMoreOnTheAirTvState> emit,
  ) async {
    emit(const SeeMoreOnTheAirTvState.loadingOnTheAirTSeeMore());

    // Fetch kategori Popular
    final results = await Future.wait([getOnTheAirTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) =>
            emit(SeeMoreOnTheAirTvState.errorOnTheAirTSeeMore(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMoreOnTheAirTvState.loadedOnTheAirTSeeMore(
        onTheAir: results[0].getOrElse(() => []),
        onTheAirPage: 2,
        hasMoreOnTheAir: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshOnTheAirTv event,
    Emitter<SeeMoreOnTheAirTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialOnTheAirSeeMoreTv());
  }

  Future<void> _onFetchMoreOnTheAirTv(
    FetchMoreOnTheAirSeeMoreTv event,
    Emitter<SeeMoreOnTheAirTvState> emit,
  ) async {
    if (state is LoadedOnTheAirTSeeMore) {
      final currentState = state as LoadedOnTheAirTSeeMore;
      if (!currentState.hasMoreOnTheAir) return;

      final result = await getOnTheAirTv.execute(currentState.onTheAirPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newTv) => emit(
          currentState.copyWith(
            onTheAir: List.of(currentState.onTheAir)..addAll(newTv),
            onTheAirPage: currentState.onTheAirPage + 1,
            hasMoreOnTheAir: newTv.isNotEmpty,
          ),
        ),
      );
    }
  }
}
