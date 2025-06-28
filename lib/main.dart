import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton_clean_architecture/injection.dart' as di;
import 'package:tv_series/module/tv_series.dart';
import 'firebase_options.dart';
import 'package:about/module/about.dart';
import 'package:core/module/core.dart';
import 'package:movies/module/movies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await di.init();

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
        BlocProvider(create: (context) => di.locator<PopularTvBloc>()),
        BlocProvider(create: (context) => di.locator<TopRatedTvBloc>()),
        BlocProvider(create: (context) => di.locator<MovieSearchBloc>()),
        BlocProvider(create: (context) => di.locator<TvSearchBloc>()),
        BlocProvider(create: (context) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (context) => di.locator<TvDetailBloc>()),
        BlocProvider(
          create: (context) => di.locator<SeeMorePopularMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SeeMoreTopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<SeeMoreUpcomingMovieBloc>(),
        ),
        BlocProvider(create: (context) => di.locator<SeeMoreOnTheAirTvBloc>()),
        BlocProvider(create: (context) => di.locator<SeeMorePopularTvBloc>()),
        BlocProvider(create: (context) => di.locator<SeeMoreTopRatedTvBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (context) => di.locator<WatchlistTvBloc>()),
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
              case customDrawerRoute:
                return MaterialPageRoute(
                  builder: (_) => CustomDrawer(pageController: _pageController),
                );
              case homeMovieRoute:
                return MaterialPageRoute(builder: (_) => HomeMoviePage());
              case popularMovieRoute:
                return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
              case topRatedMovieRoute:
                return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
              case upComingMovieRoute:
                return MaterialPageRoute(builder: (_) => UpComingMoviesPage());
              case movieDetailRoute:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(id: id),
                  settings: settings,
                );
              case searchMovieRoute:
                return CupertinoPageRoute(builder: (_) => SearchMoviePage());
              case watchlistMovieRoute:
                return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
              case aboutRoute:
                return MaterialPageRoute(builder: (_) => AboutPage());
              case tvSeriesRoute:
                return MaterialPageRoute(builder: (_) => TvSeriesPage());
              case tvSeriesDetailRoute:
                final id = settings.arguments as int;
                return MaterialPageRoute(
                  builder: (_) => TvSeriesDetailPage(id: id),
                );
              case searchTvRoute:
                return CupertinoPageRoute(builder: (_) => SearchTvPage());
              case watchlistTvRoute:
                return MaterialPageRoute(builder: (_) => WatchlistTvPage());
              case onTheAirTvRoute:
                return CupertinoPageRoute(builder: (_) => OnTheAirTvPage());
              case popularTvRoute:
                return MaterialPageRoute(builder: (_) => PopularTvPage());
              case topRatedTvRoute:
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
