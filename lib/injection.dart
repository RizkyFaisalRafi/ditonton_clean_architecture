import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton_clean_architecture/data/datasources/db/database_helper.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:ditonton_clean_architecture/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_clean_architecture/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_up_coming_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/search_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_airing_today_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_on_the_air_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_status_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_list/movie_list_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_search/movie_search_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/see_more_popular/see_more_popular_movie_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/see_more_top_rated/see_more_top_rated_movie_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/see_more_upcoming/see_more_upcoming_movie_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/see_more_on_the_air/see_more_on_the_air_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/see_more_popular/see_more_popular_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/see_more_top_rated/see_more_top_rated_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/airing_today/airing_today_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/on_the_air/on_the_air_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/popular/popular_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/top_rated/top_rated_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_watchlist/watchlist_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/movie_list_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/movie_search_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/on_the_air_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/popular_tv_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/top_rated_tv_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_detail_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/up_coming_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'common/network_info.dart';
import 'common/ssl_pinning.dart';
import 'data/datasources/movies/movie_remote_data_source.dart';
import 'presentation/provider/tv_series/tv_list_notifier.dart';
import 'presentation/provider/tv_series/watchlist_tv_notifier.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
      getUpComingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(() => MovieSearchNotifier(searchMovies: locator()));
  locator.registerFactory(
    () => PopularMoviesNotifier(getPopularMovies: locator()),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(getWatchlistMovies: locator()),
  );
  locator.registerFactory(
    () => UpComingMoviesNotifier(getUpComingMovies: locator()),
  );
  locator.registerFactory(
    () => TvListNotifier(
      getAiringTodayTv: locator(),
      getOnTheAirTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(() => WatchlistTvNotifier(getWatchlistTv: locator()));
  locator.registerFactory(() => TvSearchNotifier(searchTvSeries: locator()));
  locator.registerFactory(() => OnTheAirNotifier(getOnTheAirTv: locator()));
  locator.registerFactory(() => PopularTvNotifier(getPopularTv: locator()));
  locator.registerFactory(() => TopRatedTvNotifier(getTopRatedTv: locator()));

  // Bloc
  locator.registerFactory(
    () => MovieListBloc(
      getPopularMovies: locator(),
      getNowPlayingMovies: locator(),
      getTopRatedMovies: locator(),
      getUpComingMovies: locator(),
    ),
  );
  locator.registerFactory(() => AiringTodayTvBloc(getAiringTodayTv: locator()));
  locator.registerFactory(() => OnTheAirTvBloc(getOnTheAirTv: locator()));
  locator.registerFactory(() => PopularTvBloc(getPopularTv: locator()));
  locator.registerFactory(() => TopRatedTvBloc(getTopRatedTv: locator()));
  locator.registerFactory(() => MovieSearchBloc(searchMovies: locator()));
  locator.registerFactory(() => TvSearchBloc(searchTvSeries: locator()));
  locator.registerFactory(
    () => MovieDetailBloc(
      removeWatchlist: locator(),
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      removeWatchlist: locator(),
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SeeMorePopularMovieBloc(getPopularMovies: locator()),
  );
  locator.registerFactory(
    () => SeeMoreTopRatedMovieBloc(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => SeeMoreUpcomingMovieBloc(getUpComingMovies: locator()),
  );
  locator.registerFactory(
    () => SeeMoreOnTheAirTvBloc(getOnTheAirTv: locator()),
  );
  locator.registerFactory(() => SeeMorePopularTvBloc(getPopularTv: locator()));
  locator.registerFactory(
    () => SeeMoreTopRatedTvBloc(getTopRatedTv: locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(getWatchlistMovies: locator()),
  );
  locator.registerFactory(() => WatchlistTvBloc(getWatchlistTv: locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetUpComingMovies(locator()));
  locator.registerLazySingleton(() => GetAiringTodayTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(repository: locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      networkInfo: locator(),
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator<http.Client>()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator<http.Client>()),
  );

  locator.registerLazySingleton<TvSeriesLocalDatasource>(
    () => TvSeriesLocalDatasourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerSingletonAsync<http.Client>(
    () => SslPinning.createLEClient(),
  );
  await locator.allReady();

  locator.registerLazySingleton(() => DataConnectionChecker());
}
