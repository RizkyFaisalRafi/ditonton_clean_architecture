part of 'movie_detail_bloc.dart';

@freezed
class MovieDetailState with _$MovieDetailState {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  const factory MovieDetailState.initial() = Initial;
  const factory MovieDetailState.loading() = Loading;
  const factory MovieDetailState.loaded({
    required MovieDetail movieDetail,
    required List<Movie> movieRecommendations,
    required RequestState recommendationState,
    required bool isAddedToWatchlist,
    String? watchlistMessage,
}) = Loaded;
  const factory MovieDetailState.error(String message) = Error;
}
