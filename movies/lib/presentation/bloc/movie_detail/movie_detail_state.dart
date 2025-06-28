part of 'movie_detail_bloc.dart';

@freezed
class MovieDetailState with _$MovieDetailState {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  const factory MovieDetailState.initialMovieDetail() = InitialMovieDetail;
  const factory MovieDetailState.loadingMovieDetail() = LoadingMovieDetail;
  const factory MovieDetailState.loadedMovieDetail({
    required MovieDetail movieDetail,
    required List<Movie> movieRecommendations,
    required RequestState recommendationState,
    required bool isAddedToWatchlist,
    String? watchlistMessage,
}) = LoadedMovieDetail;
  const factory MovieDetailState.errorMovieDetail(String message) = ErrorMovieDetail;
}
