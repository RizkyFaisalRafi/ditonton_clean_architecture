import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/constants.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/presentation/pages/about_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/search_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/watchlist_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/up_coming_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/watchlist_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/movie_list_notifier.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgets/error_state_widget.dart';

class HomeMoviePage extends StatelessWidget {
  const HomeMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieListNotifier>(context);

    return Scaffold(
      /// Navigation Drawer
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(color: Colors.grey.shade900),
            ),

            /// Movies Navigation Drawer
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            /// TV Series Navigation Drawer
            ListTile(
              leading: Icon(Icons.tv_rounded),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pushNamed(context, TvSeriesPage.ROUTE_NAME);
              },
            ),

            /// Watchlist Movie Navigation Drawer
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movie'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),

            /// Watchlist Tv Series Navigation Drawer
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Tv Series'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
              },
            ),

            /// About Navigation Drawer
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),

      /// Home Content
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: SmartRefresher(
          controller: provider.refreshC,
          enablePullDown: true,
          onRefresh: provider.onRefresh,
          header: const WaterDropHeader(
            complete: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline_rounded),
                Text('Refresh Complete'),
              ],
            ),
            failed: Text('Refresh Failed'),
            refresh: CircularProgressIndicator(),
            waterDropColor: Colors.orange,
            idleIcon: Icon(
              Icons.refresh_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Now Playing
                Text('Now Playing', style: kHeading6),
                Consumer<MovieListNotifier>(
                  builder: (context, data, child) {
                    final state = data.nowPlayingState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/image_lottie/loading_bar.json',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (state == RequestState.Error) {
                      if (data.message.contains(
                        'Failed to connect to the network',
                      )) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/image_lottie/no_connection.json',
                                  width: 300,
                                  height: 300,
                                ),
                                Text(
                                  'No Internet Connection!',
                                  // AppLocalizations.of(context)!.noInternetConnection,
                                  style: kSubtitle,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Error
                        return ErrorStateWidget2(
                          message: data.message,
                          onRetry: () => provider.onRefresh(),
                        );
                      }
                    } else if (state == RequestState.Loaded) {
                      // Empty Data
                      if (data.nowPlayingMovies.isEmpty) {
                        return const EmptyStateWidget(
                          message: 'No movies available.',
                        );
                      }
                      return MovieList(
                        data.nowPlayingMovies,
                        data.nowPlayingController,
                      );
                    } else {
                      // Initial State
                      return EmptyStateWidget(message: 'Failed');
                    }
                  },
                ),

                /// Popular
                _buildSubHeading(
                  title: 'Popular',
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        PopularMoviesPage.ROUTE_NAME,
                      ),
                ),

                Consumer<MovieListNotifier>(
                  builder: (context, data, child) {
                    final state = data.popularMoviesState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/image_lottie/loading_bar.json',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (state == RequestState.Loaded) {
                      return MovieList(
                        data.popularMovies,
                        data.popularController,
                      );
                    } else {
                      return EmptyStateWidget(
                        message:
                            "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                      );
                    }
                  },
                ),

                /// Top Rated
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        TopRatedMoviesPage.ROUTE_NAME,
                      ),
                ),
                Consumer<MovieListNotifier>(
                  builder: (context, data, child) {
                    final state = data.topRatedMoviesState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/image_lottie/loading_bar.json',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (state == RequestState.Loaded) {
                      return MovieList(
                        data.topRatedMovies,
                        data.topRatedController,
                      );
                    } else {
                      return EmptyStateWidget(message: 'Failed to Load Data');
                    }
                  },
                ),

                /// Up Coming
                _buildSubHeading(
                  title: 'Up Coming',
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        UpComingMoviesPage.ROUTE_NAME,
                      ),
                ),

                Consumer<MovieListNotifier>(
                  builder: (context, data, child) {
                    final state = data.upComingMoviesState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: Lottie.asset(
                          'assets/image_lottie/loading_bar.json',
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      );
                    } else if (state == RequestState.Loaded) {
                      return MovieList(
                        data.upComingMovies,
                        data.upComingController,
                      );
                    } else {
                      return EmptyStateWidget(message: 'Failed to Load Data');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kHeading6),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More $title'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final ScrollController scrollController;

  const MovieList(this.movies, this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          print('Movie ID: ${movie.id}');
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                /// Go to Detail Page Data Provider dari MovieDetailNotifier harusnya
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
