import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:core/module/core.dart';
import 'package:movies/module/movies.dart';
import 'package:tv_series/module/tv_series.dart';

class MovieDetailPage extends StatefulWidget {
  final int id;

  const MovieDetailPage({super.key, required this.id});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   Provider.of<MovieDetailNotifier>(
    //     context,
    //     listen: false,
    //   ).fetchMovieDetail(widget.id);
    //   Provider.of<MovieDetailNotifier>(
    //     context,
    //     listen: false,
    //   ).loadWatchlistStatus(widget.id);
    // });

    context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MovieDetailBloc, MovieDetailState>(
        listener: (context, state) {
          if (state is LoadedMovieDetail) {
            final message = state.watchlistMessage;
            if (message != null && message.isNotEmpty) {
              if (message == MovieDetailState.watchlistAddSuccessMessage ||
                  message == MovieDetailState.watchlistRemoveSuccessMessage) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(content: Text(message));
                  },
                );
              }
            }
          }
        },
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            return switch (state) {
              InitialMovieDetail() => const Center(
                child: CircularProgressIndicator(),
              ),
              LoadingMovieDetail() => Center(
                child: Lottie.asset(
                  loadingBarLottiePath,
                  width: 150,
                  height: 150,
                ),
              ),
              LoadedMovieDetail(
                movieDetail: final movieDetail,
                movieRecommendations: final movieRecommendations,
                isAddedToWatchlist: final isAddedToWatchlist,
              ) =>
                SafeArea(
                  child: DetailContent(
                    movieDetail,
                    movieRecommendations,
                    isAddedToWatchlist,
                  ),
                ),

              // Error(message: final message) => ErrorStateWidget2(
              //   message: message,
              //   onRetry: () {
              //     MovieDetailEvent.fetchMovieDetail(widget.id);
              //   },
              // ),
              ErrorMovieDetail(message: final message) => ErrorStateWidget2(
                message: message,
                onRetry: () {
                  context.read<MovieDetailBloc>().add(
                    MovieDetailEvent.fetchMovieDetail(widget.id),
                  );
                },
              ),

              MovieDetailState() => throw UnimplementedError(),
            };
          },
        ),
      ),

      // Provider Movie Detail
      // body: Consumer<MovieDetailNotifier>(
      //   builder: (context, provider, child) {
      //     if (provider.movieState == RequestState.Loading) {
      //       return Center(
      //         child: Lottie.asset(
      //           key: Key('loading_movie_detail'),
      //           'assets/image_lottie/loading_bar.json',
      //           width: 100,
      //           height: 100,
      //           fit: BoxFit.fill,
      //         ),
      //       );
      //     } else if (provider.movieState == RequestState.Loaded) {
      //       final movie = provider.movie;
      //       return SafeArea(
      //         child: DetailContent(
      //           movie!,
      //           provider.movieRecommendations,
      //           provider.isAddedToWatchlist,
      //         ),
      //       );
      //     } else {
      //       return Center(
      //         child: ErrorStateWidget2(
      //           message: provider.message,
      //           onRetry: () => provider.fetchMovieDetail(widget.id),
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(
    this.movie,
    this.recommendations,
    this.isAddedWatchlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Gambar poster vertikal
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder:
              (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

        // Content Detail
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movie.title ?? 'Title Null', style: kHeading5),

                            FilledButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context.read<MovieDetailBloc>().add(
                                    MovieDetailEvent.addToWatchlist(movie),
                                  );

                                  // await Provider.of<MovieDetailNotifier>(
                                  //   context,
                                  //   listen: false,
                                  // ).addWatchlist(movie);
                                } else {
                                  context.read<MovieDetailBloc>().add(
                                    MovieDetailEvent.removeFromWatchlist(movie),
                                  );

                                  // await Provider.of<MovieDetailNotifier>(
                                  //   context,
                                  //   listen: false,
                                  // ).removeFromWatchlist(movie);
                                }

                                // final message =
                                //     Provider.of<MovieDetailNotifier>(
                                //       context,
                                //       listen: false,
                                //     ).watchlistMessage;
                                //
                                // if (message ==
                                //         MovieDetailNotifier
                                //             .watchlistAddSuccessMessage ||
                                //     message ==
                                //         MovieDetailNotifier
                                //             .watchlistRemoveSuccessMessage) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text(message)),
                                //   );
                                // } else {
                                //   showDialog(
                                //     context: context,
                                //     builder: (context) {
                                //       return AlertDialog(
                                //         content: Text(message),
                                //       );
                                //     },
                                //   );
                                // }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(movie.genres!)),
                            Text(_showDuration(movie.runtime!)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder:
                                      (context, index) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(movie.overview ?? 'Overview Null'),
                            SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            BlocBuilder<MovieDetailBloc, MovieDetailState>(
                              builder: (context, state) {
                                // PERBAIKAN: Menggunakan switch dengan pattern matching
                                return switch (state) {
                                  LoadedMovieDetail(
                                    recommendationState: final recState,
                                    movieRecommendations: final recs,
                                  ) =>
                                    recState == RequestState.Loading
                                        ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                        : recState == RequestState.Loaded
                                        ? SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final movie = recs[index];
                                              return Padding(
                                                padding: const EdgeInsets.all(
                                                  4.0,
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushReplacementNamed(
                                                      context,
                                                      movieDetailRoute,
                                                      arguments: movie.id,
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                      placeholder:
                                                          (
                                                            context,
                                                            url,
                                                          ) => const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          ),
                                                      errorWidget:
                                                          (
                                                            context,
                                                            url,
                                                            error,
                                                          ) => const Icon(
                                                            Icons.error,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: recs.length,
                                          ),
                                        )
                                        : const Text(
                                          "Failed to load recommendations.",
                                        ),
                                  _ => const SizedBox.shrink(),
                                };
                              },
                            ),

                            // Provider Recommendation
                            // Consumer<MovieDetailNotifier>(
                            //   builder: (context, data, child) {
                            //     if (data.recommendationState ==
                            //         RequestState.Loading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (data.recommendationState ==
                            //         RequestState.Error) {
                            //       return Text(data.message);
                            //     } else if (data.recommendationState ==
                            //         RequestState.Loaded) {
                            //       return Container(
                            //         height: 150,
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (context, index) {
                            //             final movie = recommendations[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     MovieDetailPage.ROUTE_NAME,
                            //                     arguments: movie.id,
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: CachedNetworkImage(
                            //                     imageUrl:
                            //                         'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            //                     placeholder:
                            //                         (context, url) => Center(
                            //                           child:
                            //                               CircularProgressIndicator(),
                            //                         ),
                            //                     errorWidget:
                            //                         (context, url, error) =>
                            //                             Icon(Icons.error),
                            //                   ),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //           itemCount: recommendations.length,
                            //         ),
                            //       );
                            //     } else {
                            //       return Container();
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
