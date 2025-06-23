import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/movies/movie.dart';
import '../../../../domain/usecases/movies/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

part 'watchlist_movie_bloc.freezed.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies}) : super(Initial()) {
    // Fetch Data Watchlist
    on<FetchInitialWatchlistMovies>(_onFetchWatchlistMovies);
  }

  Future<void> _onFetchWatchlistMovies(
    FetchInitialWatchlistMovies event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    // Emit state Loading untuk memberitahu UI bahwa proses dimulai
    emit(const WatchlistMovieState.loading());

    // Eksekusi use case
    final result = await getWatchlistMovies.execute();

    // Proses hasil dari use case menggunakan fold
    result.fold(
      // Jika gagal (Failure)
      (failure) {
        emit(WatchlistMovieState.error(failure.message));
      },
      // Jika berhasil (Success)
      (moviesData) {
        emit(WatchlistMovieState.loaded(watchlistMovie: moviesData));
      },
    );
  }
}
