import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:movies/module/movies.dart';
import 'package:core/module/core.dart';

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
