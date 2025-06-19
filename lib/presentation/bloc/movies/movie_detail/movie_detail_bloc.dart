import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/save_watchlist.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../common/failure.dart';
import '../../../../common/state_enum.dart';
import '../../../../domain/entities/movies/movie.dart';
import '../../../../domain/entities/movies/movie_detail.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

part 'movie_detail_bloc.freezed.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const MovieDetailState.initial()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
  }

  Future<void> _onFetchMovieDetail(
    FetchMovieDetail event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(const MovieDetailState.loading());

    // Mengambil semua data yang dibutuhkan secara bersamaan
    final results = await Future.wait([
      getMovieDetail.execute(event.id),
      getMovieRecommendations.execute(event.id),
      getWatchListStatus.execute(event.id),
    ]);

    final detailResult = results[0] as Either<Failure, MovieDetail>;
    final recommendationResult = results[1] as Either<Failure, List<Movie>>;
    final watchlistStatusResult = results[2] as Either<Failure, bool>;

    detailResult.fold(
      (failure) {
        emit(MovieDetailState.error(failure.message));
      },
      (movie) {
        final isAdded = watchlistStatusResult.getOrElse(() => false);

        recommendationResult.fold(
          (failure) {
            // Jika rekomendasi gagal, tetap tampilkan detail
            emit(
              MovieDetailState.loaded(
                movieDetail: movie,
                movieRecommendations: [],
                recommendationState: RequestState.Error,
                isAddedToWatchlist: isAdded,
              ),
            );
          },
          (recommendations) {
            emit(
              MovieDetailState.loaded(
                movieDetail: movie,
                movieRecommendations: recommendations,
                recommendationState: RequestState.Loaded,
                isAddedToWatchlist: isAdded,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onAddToWatchlist(
    AddToWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    // Hanya bisa dijalankan jika state saat ini adalah Loaded
    if (state is Loaded) {
      final currentState = state as Loaded;
      final result = await saveWatchlist.execute(event.movieDetail);

      final newStatus = await getWatchListStatus.execute(event.movieDetail.id);

      result.fold(
        (failure) {
          emit(currentState.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(
            currentState.copyWith(
              watchlistMessage: successMessage,
              isAddedToWatchlist: newStatus.getOrElse(() => true),
            ),
          );
        },
      );
    }
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<MovieDetailState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      final result = await removeWatchlist.execute(event.movieDetail);

      final newStatus = await getWatchListStatus.execute(event.movieDetail.id);

      result.fold(
        (failure) {
          emit(currentState.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(
            currentState.copyWith(
              watchlistMessage: successMessage,
              isAddedToWatchlist: newStatus.getOrElse(() => false),
            ),
          );
        },
      );
    }
  }
}
