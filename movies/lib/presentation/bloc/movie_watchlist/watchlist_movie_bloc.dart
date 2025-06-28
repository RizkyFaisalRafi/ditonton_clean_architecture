import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../module/movies.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

part 'watchlist_movie_bloc.freezed.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies})
    : super(InitialWatchlistMovie()) {
    // Fetch Data Watchlist
    on<FetchInitialWatchlistMovies>(_onFetchWatchlistMovies);
  }

  Future<void> _onFetchWatchlistMovies(
    FetchInitialWatchlistMovies event,
    Emitter<WatchlistMovieState> emit,
  ) async {
    // Emit state Loading untuk memberitahu UI bahwa proses dimulai
    emit(const WatchlistMovieState.loadingWatchlistMovie());

    // Eksekusi use case
    final result = await getWatchlistMovies.execute();

    // Proses hasil dari use case menggunakan fold
    result.fold(
      // Jika gagal (Failure)
      (failure) {
        emit(WatchlistMovieState.errorWatchlistMovie(failure.message));
      },
      // Jika berhasil (Success)
      (moviesData) {
        emit(
          WatchlistMovieState.loadedWatchlistMovie(watchlistMovie: moviesData),
        );
      },
    );
  }
}
