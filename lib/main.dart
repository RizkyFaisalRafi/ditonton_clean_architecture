import 'package:ditonton_clean_architecture/common/constants.dart';
import 'package:ditonton_clean_architecture/common/utils.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_clean_architecture/domain/repositories/movie_repository.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_list/movie_list_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/airing_today/airing_today_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/on_the_air/on_the_air_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/pages/about_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/search_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/on_the_air_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/watchlist_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/up_coming_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/custom_drawer_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/provider/drawer_provider.dart';
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
import 'package:ditonton_clean_architecture/presentation/widgets/custom_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton_clean_architecture/injection.dart' as di;
import 'presentation/provider/tv_series/tv_list_notifier.dart';
import 'presentation/provider/tv_series/watchlist_tv_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<CustomDrawerState> _drawerKey =
      GlobalKey<CustomDrawerState>();
  final PageController _pageController = PageController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<MovieListBloc>()),
        BlocProvider(create: (context) => di.locator<AiringTodayTvBloc>()),
        BlocProvider(create: (context) => di.locator<OnTheAirTvBloc>()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => di.locator<MovieListNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<MovieDetailNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<MovieSearchNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<TopRatedMoviesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<PopularMoviesNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<WatchlistMovieNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<UpComingMoviesNotifier>(),
          ),
          ChangeNotifierProvider(create: (_) => di.locator<TvListNotifier>()),
          ChangeNotifierProvider(create: (_) => di.locator<TvDetailNotifier>()),
          ChangeNotifierProvider<WatchlistTvNotifier>(
            create: (_) => di.locator<WatchlistTvNotifier>(),
          ),
          ChangeNotifierProvider(create: (_) => di.locator<TvSearchNotifier>()),
          ChangeNotifierProvider(create: (_) => di.locator<OnTheAirNotifier>()),
          ChangeNotifierProvider(
            create: (_) => di.locator<PopularTvNotifier>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.locator<TopRatedTvNotifier>(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Expert',
          theme: ThemeData.dark().copyWith(
            colorScheme: kColorScheme,
            primaryColor: kRichBlack,
            scaffoldBackgroundColor: kRichBlack,
            textTheme: kTextTheme,
            drawerTheme: kDrawerTheme,
          ),
          // home: HomeMoviePage(),
          home: Material(
            child: CustomDrawer(
              key: _drawerKey,
              pageController: _pageController,
            ),
          ),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/custom-drawer':
                return MaterialPageRoute(
                  builder: (_) => CustomDrawer(pageController: _pageController),
                );
              case '/home':
                return MaterialPageRoute(builder: (_) => HomeMoviePage());
              case PopularMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
              case TopRatedMoviesPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
              case MovieDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case SearchPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchPage());
              case WatchlistMoviesPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
              case AboutPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => AboutPage());
              case UpComingMoviesPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => UpComingMoviesPage());
              case TvSeriesPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => TvSeriesPage());
              case TvSeriesDetailPage.ROUTE_NAME:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => TvSeriesDetailPage(id: id),
                );
              case SearchTvPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => SearchTvPage());
              case WatchlistTvPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => WatchlistTvPage());
              case OnTheAirTvPage.ROUTE_NAME:
                return CupertinoPageRoute(builder: (_) => OnTheAirTvPage());
              case PopularTvPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => PopularTvPage());
              case TopRatedTvPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => TopRatedTvPage());
              default:
                return MaterialPageRoute(
                  builder: (_) {
                    return Scaffold(
                      body: Center(child: Text('Page not found :(')),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
