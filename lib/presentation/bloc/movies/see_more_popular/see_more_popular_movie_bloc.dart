import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_popular_movies.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'see_more_popular_movie_event.dart';

part 'see_more_popular_movie_state.dart';

part 'see_more_popular_movie_bloc.freezed.dart';

class SeeMorePopularMovieBloc
    extends Bloc<SeeMorePopularMovieEvent, SeeMorePopularMovieState> {
  final GetPopularMovies getPopularMovies;

  SeeMorePopularMovieBloc({required this.getPopularMovies}) : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialPopularMovies>(_onFetchInitialPopularMovies);

    // For Refresh
    on<RefreshMovies>(_onRefreshMovies);

    // For FetchMore
    on<FetchMorePopularMovies>(_onFetchMorePopular, transformer: droppable());
  }

  // Helper function untuk logika scroll
  void onScroll(ScrollController controller, VoidCallback action) {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      action();
    }
  }

  Future<void> _onFetchInitialPopularMovies(
    FetchInitialPopularMovies event,
    Emitter<SeeMorePopularMovieState> emit,
  ) async {
    emit(const SeeMorePopularMovieState.loading());

    // Fetch kategori Popular
    final results = await Future.wait([getPopularMovies.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(SeeMorePopularMovieState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMorePopularMovieState.loaded(
        popular: results[0].getOrElse(() => []),
        popularPage: 2,
        hasMorePopular: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshMovies(
    RefreshMovies event,
    Emitter<SeeMorePopularMovieState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialPopularMovies());
  }

  Future<void> _onFetchMorePopular(
    FetchMorePopularMovies event,
    Emitter<SeeMorePopularMovieState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      if (!currentState.hasMorePopular) return;

      final result = await getPopularMovies.execute(currentState.popularPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newMovies) => emit(
          currentState.copyWith(
            popular: List.of(currentState.popular)..addAll(newMovies),
            popularPage: currentState.popularPage + 1,
            hasMorePopular: newMovies.isNotEmpty,
          ),
        ),
      );
    }
  }
}
