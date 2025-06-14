import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/constants.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/search_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/up_coming_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../bloc/movies/movie_list/movie_list_bloc.dart';
import '../../widgets/error_state_widget.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  // Deklarasikan semua ScrollController dan RefreshController
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _nowPlayingScrollController;
  late final ScrollController _popularScrollController;
  late final ScrollController _topRatedScrollController;
  late final ScrollController _upcomingScrollController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller
    _nowPlayingScrollController = ScrollController();
    _popularScrollController = ScrollController();
    _topRatedScrollController = ScrollController();
    _upcomingScrollController = ScrollController();
    final onScrollC = context.read<MovieListBloc>();

    context.read<MovieListBloc>().add(
      const MovieListEvent.fetchInitialMovies(),
    );

    // listener untuk setiap controller untuk memicu event 'fetchMore'
    _nowPlayingScrollController.addListener(
      () => onScrollC.onScroll(_nowPlayingScrollController, () {
        context.read<MovieListBloc>().add(
          const MovieListEvent.fetchMoreNowPlayingMovies(),
        );
      }),
    );
    _popularScrollController.addListener(
      () => onScrollC.onScroll(_popularScrollController, () {
        context.read<MovieListBloc>().add(
          const MovieListEvent.fetchMorePopularMovies(),
        );
      }),
    );
    _topRatedScrollController.addListener(
      () => onScrollC.onScroll(_topRatedScrollController, () {
        context.read<MovieListBloc>().add(
          const MovieListEvent.fetchMoreTopRatedMovies(),
        );
      }),
    );
    _upcomingScrollController.addListener(
      () => onScrollC.onScroll(_upcomingScrollController, () {
        context.read<MovieListBloc>().add(
          const MovieListEvent.fetchMoreUpcomingMovies(),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Logika untuk membuka drawer
            context.findRootAncestorStateOfType<CustomDrawerState>()?.toggle();
          },
        ),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.pushNamed(context, SearchPage.ROUTE_NAME),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocListener<MovieListBloc, MovieListState>(
        listener: (context, state) {
          // Listen for state changes to control the RefreshController
          if (state is Loaded) {
            _refreshController.refreshCompleted();
          }
          if (state is Error) {
            _refreshController.refreshFailed();
          }
        },
        child: SmartRefresher(
          controller: _refreshController,
          onRefresh:
              () => context.read<MovieListBloc>().add(
                const MovieListEvent.refreshMovies(),
              ),
          header: const WaterDropHeader(
          ),
          child: BlocBuilder<MovieListBloc, MovieListState>(
            builder: (context, state) {
              // Gunakan switch expression untuk pattern matching yang modern
              return switch (state) {
                Loaded(
                  nowPlaying: final nowPlaying,
                  popular: final popular,
                  topRated: final topRated,
                  upcoming: final upcoming,
                  hasMoreNowPlaying: final hasMoreNp,
                  hasMorePopular: final hasMoreP,
                  hasMoreTopRated: final hasMoreTr,
                  hasMoreUpcoming: final hasMoreU,
                ) =>
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 12.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Now Playing Section ---
                        Text('Now Playing', style: kHeading6),
                        MovieList(
                          movies: nowPlaying,
                          scrollController: _nowPlayingScrollController,
                          hasMore: hasMoreNp,
                        ),

                        // --- Popular Section ---
                        _buildSubHeading(
                          title: 'Popular',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                PopularMoviesPage.ROUTE_NAME,
                              ),
                        ),
                        MovieList(
                          movies: popular,
                          scrollController: _popularScrollController,
                          hasMore: hasMoreP,
                        ),

                        // --- Top Rated Section ---
                        _buildSubHeading(
                          title: 'Top Rated',
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                TopRatedMoviesPage.ROUTE_NAME,
                              ),
                        ),
                        MovieList(
                          movies: topRated,
                          scrollController: _topRatedScrollController,
                          hasMore: hasMoreTr,
                        ),

                        // --- Upcoming Section ---
                        _buildSubHeading(
                          title: 'Upcoming', // Konsistensi nama
                          onTap:
                              () => Navigator.pushNamed(
                                context,
                                UpComingMoviesPage.ROUTE_NAME,
                              ),
                        ),
                        MovieList(
                          movies: upcoming,
                          scrollController: _upcomingScrollController,
                          hasMore: hasMoreU,
                        ),
                      ],
                    ),
                  ),
                Loading() => Center(
                  child: Lottie.asset(
                    'assets/image_lottie/loading_bar.json',
                    width: 150,
                    height: 150,
                  ),
                ),
                Error(message: final message) => () {
                  // Tampilkan error state yang sesuai
                  if (message.contains('Failed to connect to the network')) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/image_lottie/no_connection.json',
                            width: 300,
                            height: 300,
                          ),
                          Text('No Internet Connection!', style: kSubtitle),
                        ],
                      ),
                    );
                  }
                  return ErrorStateWidget2(
                    message: message,
                    onRetry:
                        () => context.read<MovieListBloc>().add(
                          const MovieListEvent.refreshMovies(),
                        ),
                  );
                }(),
                // Tambahkan case default untuk memastikan switch bersifat exhaustive
                _ => const SizedBox.shrink(),
              };
            },
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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('See More'),
                Icon(Icons.arrow_forward_ios, size: 16.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Jangan lupa dispose semua controller
    log('Dispose Called');
    _refreshController.dispose();
    _nowPlayingScrollController.dispose();
    _popularScrollController.dispose();
    _topRatedScrollController.dispose();
    _upcomingScrollController.dispose();
    super.dispose();
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final ScrollController scrollController;
  final bool hasMore; // Tambahkan flag ini

  const MovieList( // this.movies,
  // this.scrollController,
  {
    super.key,
    required this.movies,
    required this.scrollController,
    this.hasMore = false,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No movies available.')),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        // itemCount: movies.length,
        // Tambah 1 item jika `hasMore` true untuk menampilkan loading indicator
        itemCount: hasMore ? movies.length + 1 : movies.length,
        itemBuilder: (context, index) {
          // Jika index adalah item terakhir DAN masih ada data, tampilkan loading
          if (index >= movies.length) {
            return const Center(child: CircularProgressIndicator());
          }

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
      ),
    );
  }
}
