import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../module/movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';
part 'movie_list_bloc.freezed.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  final GetUpComingMovies getUpComingMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
    required this.getUpComingMovies,
  }) : super(const MovieListState.initialMovieList()) {
    // Handler untuk setiap event
    // Fetch semua kategori untuk pertama kali
    on<FetchInitialMovies>(_onFetchInitialMovies);

    // For Refresh
    on<RefreshMovies>(_onRefreshMovies);

    // Gunakan `droppable()` untuk mencegah request ganda saat user scroll cepat
    on<FetchMoreNowPlayingMovies>(
      _onFetchMoreNowPlaying,
      transformer: droppable(),
    );
    on<FetchMorePopularMovies>(_onFetchMorePopular, transformer: droppable());
    on<FetchMoreTopRatedMovies>(_onFetchMoreTopRated, transformer: droppable());
    on<FetchMoreUpcomingMovies>(_onFetchMoreUpcoming, transformer: droppable());
  }

  // Helper function untuk logika scroll
  void onScroll(ScrollController controller, VoidCallback action) {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 200) {
      action();
    }
  }

  // Menggantikan `loadMovies()` di Notifier
  Future<void> _onFetchInitialMovies(
    FetchInitialMovies event,
    Emitter<MovieListState> emit,
  ) async {
    emit(const MovieListState.loadingMovieList());

    // Fetch semua kategori secara paralel
    final results = await Future.wait([
      getNowPlayingMovies.execute(1),
      getPopularMovies.execute(1),
      getTopRatedMovies.execute(1),
      getUpComingMovies.execute(1),
    ]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(MovieListState.errorMovieList(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      MovieListState.loadedMovieList(
        nowPlaying: results[0].getOrElse(() => []),
        popular: results[1].getOrElse(() => []),
        topRated: results[2].getOrElse(() => []),
        upcoming: results[3].getOrElse(() => []),
        nowPlayingPage: 2,
        popularPage: 2,
        topRatedPage: 2,
        upcomingPage: 2,
        hasMoreNowPlaying: results[0].getOrElse(() => []).isNotEmpty,
        hasMorePopular: results[1].getOrElse(() => []).isNotEmpty,
        hasMoreTopRated: results[2].getOrElse(() => []).isNotEmpty,
        hasMoreUpcoming: results[3].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  // Menggantikan `onRefresh()` di Notifier
  Future<void> _onRefreshMovies(
    RefreshMovies event,
    Emitter<MovieListState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialMovies());
  }

  // Menggantikan `loadMoreMovieNowPlaying()`
  Future<void> _onFetchMoreNowPlaying(
    FetchMoreNowPlayingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    if (state is LoadedMovieList) {
      final currentState = state as LoadedMovieList;
      if (!currentState.hasMoreNowPlaying) return;

      final result = await getNowPlayingMovies.execute(
        currentState.nowPlayingPage,
      );
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newMovies) {
          emit(
            currentState.copyWith(
              nowPlaying: List.of(currentState.nowPlaying)..addAll(newMovies),
              nowPlayingPage: currentState.nowPlayingPage + 1,
              hasMoreNowPlaying: newMovies.isNotEmpty,
            ),
          );
        },
      );
    }
  }

  // Implementasi untuk kategori lainnya...
  Future<void> _onFetchMorePopular(
    FetchMorePopularMovies event,
    Emitter<MovieListState> emit,
  ) async {
    if (state is LoadedMovieList) {
      final currentState = state as LoadedMovieList;
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

  Future<void> _onFetchMoreTopRated(
    FetchMoreTopRatedMovies event,
    Emitter<MovieListState> emit,
  ) async {
    if (state is LoadedMovieList) {
      final currentState = state as LoadedMovieList;
      if (!currentState.hasMoreTopRated) return;

      final result = await getTopRatedMovies.execute(currentState.topRatedPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newMovies) => emit(
          currentState.copyWith(
            topRated: List.of(currentState.topRated)..addAll(newMovies),
            topRatedPage: currentState.topRatedPage + 1,
            hasMoreTopRated: newMovies.isNotEmpty,
          ),
        ),
      );
    }
  }

  Future<void> _onFetchMoreUpcoming(
    FetchMoreUpcomingMovies event,
    Emitter<MovieListState> emit,
  ) async {
    if (state is LoadedMovieList) {
      final currentState = state as LoadedMovieList;
      if (!currentState.hasMoreUpcoming) return;

      final result = await getUpComingMovies.execute(currentState.upcomingPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newMovies) => emit(
          currentState.copyWith(
            upcoming: List.of(currentState.upcoming)..addAll(newMovies),
            upcomingPage: currentState.upcomingPage + 1,
            hasMoreUpcoming: newMovies.isNotEmpty,
          ),
        ),
      );
    }
  }
}
