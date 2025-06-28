import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../module/movies.dart';

part 'see_more_top_rated_movie_event.dart';

part 'see_more_top_rated_movie_state.dart';

part 'see_more_top_rated_movie_bloc.freezed.dart';

class SeeMoreTopRatedMovieBloc
    extends Bloc<SeeMoreTopRatedMovieEvent, SeeMoreTopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  SeeMoreTopRatedMovieBloc({required this.getTopRatedMovies})
    : super(InitialTopRatedMSeeMore()) {
    // Fetch untuk pertama kali
    on<FetchInitialTopRatedMovies>(_onFetchInitialTopRatedMovies);

    // For Refresh
    on<RefreshTopRatedMovies>(_onRefreshTopRatedMovies);

    // For FetchMore
    on<FetchMoreTopRatedSeeMoreMovies>(
      _onFetchMoreTopRated,
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

  Future<void> _onFetchInitialTopRatedMovies(
    FetchInitialTopRatedMovies event,
    Emitter<SeeMoreTopRatedMovieState> emit,
  ) async {
    emit(const SeeMoreTopRatedMovieState.loadingTopRatedMSeeMore());

    // Fetch kategori Popular
    final results = await Future.wait([getTopRatedMovies.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(
          SeeMoreTopRatedMovieState.errorTopRatedMSeeMore(failure.message),
        ),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMoreTopRatedMovieState.loadedTopRatedMSeeMore(
        topRated: results[0].getOrElse(() => []),
        topRatedPage: 2,
        hasMoreTopRated: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTopRatedMovies(
    RefreshTopRatedMovies event,
    Emitter<SeeMoreTopRatedMovieState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialTopRatedMovies());
  }

  Future<void> _onFetchMoreTopRated(
    FetchMoreTopRatedSeeMoreMovies event,
    Emitter<SeeMoreTopRatedMovieState> emit,
  ) async {
    if (state is LoadedTopRatedMSeeMore) {
      final currentState = state as LoadedTopRatedMSeeMore;
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
}
