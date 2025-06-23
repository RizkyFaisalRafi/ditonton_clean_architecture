import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_up_coming_movies.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/movies/movie.dart';

part 'see_more_upcoming_movie_event.dart';

part 'see_more_upcoming_movie_state.dart';

part 'see_more_upcoming_movie_bloc.freezed.dart';

class SeeMoreUpcomingMovieBloc
    extends Bloc<SeeMoreUpcomingMovieEvent, SeeMoreUpcomingMovieState> {
  final GetUpComingMovies getUpComingMovies;

  SeeMoreUpcomingMovieBloc({required this.getUpComingMovies})
    : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialUpComingMovies>(_onFetchInitialUpComingMovies);

    // For Refresh
    on<RefreshMovies>(_onRefreshMovies);

    // For FetchMore
    on<FetchMoreUpComingMovies>(_onFetchMoreUpComing, transformer: droppable());

    // on<SeeMoreUpcomingMovieEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }

  // Helper function untuk logika scroll
  void onScroll(ScrollController controller, VoidCallback action) {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      action();
    }
  }

  Future<void> _onFetchInitialUpComingMovies(
    FetchInitialUpComingMovies event,
    Emitter<SeeMoreUpcomingMovieState> emit,
  ) async {
    emit(const SeeMoreUpcomingMovieState.loading());

    // Fetch kategori Popular
    final results = await Future.wait([getUpComingMovies.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(SeeMoreUpcomingMovieState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMoreUpcomingMovieState.loaded(
        upComing: results[0].getOrElse(() => []),
        upComingPage: 2,
        hasMoreUpComing: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshMovies(
    RefreshMovies event,
    Emitter<SeeMoreUpcomingMovieState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialUpComingMovies());
  }

  Future<void> _onFetchMoreUpComing(
    FetchMoreUpComingMovies event,
    Emitter<SeeMoreUpcomingMovieState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      if (!currentState.hasMoreUpComing) return;

      final result = await getUpComingMovies.execute(currentState.upComingPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newMovies) => emit(
          currentState.copyWith(
            upComing: List.of(currentState.upComing)..addAll(newMovies),
            upComingPage: currentState.upComingPage + 1,
            hasMoreUpComing: newMovies.isNotEmpty,
          ),
        ),
      );
    }
  }
}
