import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton_clean_architecture/data/datasources/db/database_helper.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_remote_data_source.dart';
import 'package:ditonton_clean_architecture/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_clean_architecture/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_movie_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_popular_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_up_coming_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton_clean_architecture/domain/usecases/remove_watchlist.dart';
import 'package:ditonton_clean_architecture/domain/usecases/save_watchlist.dart';
import 'package:ditonton_clean_architecture/domain/usecases/search_movies.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_airing_today_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_status_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/presentation/provider/WatchlistTvNotifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/up_coming_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'common/network_info.dart';
import 'data/datasources/movies/movie_remote_data_source.dart';

final locator = GetIt.instance;

void init() {
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
  locator.registerFactory(() => PopularMoviesNotifier(locator()));
  locator.registerFactory(
    () => TopRatedMoviesNotifier(getTopRatedMovies: locator()),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(getWatchlistMovies: locator()),
  );
  locator.registerFactory(
    () => UpComingMoviesNotifier(getUpComingMovies: locator()),
  );
  locator.registerFactory(() => TvListNotifier(getAiringTodayTv: locator()));
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
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvSeriesLocalDatasource>(
    () => TvSeriesLocalDatasourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
