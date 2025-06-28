import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../module/movies.dart';

part 'see_more_popular_movie_event.dart';

part 'see_more_popular_movie_state.dart';

part 'see_more_popular_movie_bloc.freezed.dart';

class SeeMorePopularMovieBloc
    extends Bloc<SeeMorePopularMovieEvent, SeeMorePopularMovieState> {
  final GetPopularMovies getPopularMovies;

  SeeMorePopularMovieBloc({required this.getPopularMovies})
    : super(InitialPopularMSeeMore()) {
    // Fetch untuk pertama kali
    on<FetchInitialPopularMovies>(_onFetchInitialPopularMovies);

    // For Refresh
    on<RefreshPopularMovies>(_onRefreshPopularMovies);

    // For FetchMore
    on<FetchMorePopularSeeMoreMovies>(
      _onFetchMorePopular,
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

  Future<void> _onFetchInitialPopularMovies(
    FetchInitialPopularMovies event,
    Emitter<SeeMorePopularMovieState> emit,
  ) async {
    emit(const SeeMorePopularMovieState.loadingPopularMSeeMore());

    // Fetch kategori Popular
    final results = await Future.wait([getPopularMovies.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(
          SeeMorePopularMovieState.errorPopularMSeeMore(failure.message),
        ),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      SeeMorePopularMovieState.loadedPopularMSeeMore(
        popular: results[0].getOrElse(() => []),
        popularPage: 2,
        hasMorePopular: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshPopularMovies(
    RefreshPopularMovies event,
    Emitter<SeeMorePopularMovieState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialPopularMovies());
  }

  Future<void> _onFetchMorePopular(
    FetchMorePopularSeeMoreMovies event,
    Emitter<SeeMorePopularMovieState> emit,
  ) async {
    if (state is LoadedPopularMSeeMore) {
      final currentState = state as LoadedPopularMSeeMore;
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
