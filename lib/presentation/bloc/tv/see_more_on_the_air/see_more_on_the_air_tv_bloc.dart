import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_on_the_air_tv.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tv/tv_series.dart';

part 'see_more_on_the_air_tv_event.dart';

part 'see_more_on_the_air_tv_state.dart';

part 'see_more_on_the_air_tv_bloc.freezed.dart';

class SeeMoreOnTheAirTvBloc
    extends Bloc<SeeMoreOnTheAirTvEvent, SeeMoreOnTheAirTvState> {
  final GetOnTheAirTv getOnTheAirTv;

  SeeMoreOnTheAirTvBloc({required this.getOnTheAirTv}) : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialOnTheAirTv>(_onFetchInitialOnTheAirTv);

    // For Refresh
    on<RefreshTv>(_onRefreshTv);

    // For FetchMore
    on<FetchMoreOnTheAirTv>(_onFetchMoreOnTheAirTv, transformer: droppable());
  }

  // Helper function untuk logika scroll
  void onScroll(ScrollController controller, VoidCallback action) {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      action();
    }
  }

  Future<void> _onFetchInitialOnTheAirTv(
    FetchInitialOnTheAirTv event,
    Emitter<SeeMoreOnTheAirTvState> emit,
  ) async {
    emit(const SeeMoreOnTheAirTvState.loading());

    // Fetch kategori Popular
    final results = await Future.wait([getOnTheAirTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(SeeMoreOnTheAirTvState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMoreOnTheAirTvState.loaded(
        onTheAir: results[0].getOrElse(() => []),
        onTheAirPage: 2,
        hasMoreOnTheAir: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshTv event,
    Emitter<SeeMoreOnTheAirTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialOnTheAirTv());
  }

  Future<void> _onFetchMoreOnTheAirTv(
    FetchMoreOnTheAirTv event,
    Emitter<SeeMoreOnTheAirTvState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
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
