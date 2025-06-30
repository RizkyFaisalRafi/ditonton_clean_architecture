import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../module/movies.dart';
import 'package:core/module/core.dart';

class TopRatedMoviesPage extends StatefulWidget {
  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage>
    with AutomaticKeepAliveClientMixin<TopRatedMoviesPage> {
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _topRatedScrollController;

  @override
  void initState() {
    super.initState();
    _topRatedScrollController = ScrollController();

    // Logika Smart Fetching: Hanya panggil event fetch jika state BLoC masih dalam
    // kondisi awal (Initial). mencegah fetch berulang saat kembali ke halaman ini.
    if (context.read<SeeMoreTopRatedMovieBloc>().state
        is InitialTopRatedMSeeMore) {
      context.read<SeeMoreTopRatedMovieBloc>().add(
        const SeeMoreTopRatedMovieEvent.fetchInitialTopRatedMovies(),
      );
    }

    final onScrollC = context.read<SeeMoreTopRatedMovieBloc>();
    _topRatedScrollController.addListener(
      () => onScrollC.onScroll(_topRatedScrollController, () {
        context.read<SeeMoreTopRatedMovieBloc>().add(
          const SeeMoreTopRatedMovieEvent.fetchMoreTopRatedSeeMoreMovies(),
        );
      }),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _topRatedScrollController.dispose();
    super.dispose();
  }

  // Override `wantKeepAlive` dan return true agar state tidak di-reset.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // Panggil `super.build(context)` sesuai syarat dari mixin.
    super.build(context);

    return Scaffold(
      appBar: AppBar(title: Text('Top Rated Movies')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: BlocListener<
          SeeMoreTopRatedMovieBloc,
          SeeMoreTopRatedMovieState
        >(
          listener: (context, state) {
            // Listen for state changes to control the RefreshController
            if (state is LoadedTopRatedMSeeMore) {
              _refreshController.refreshCompleted();
            }
            if (state is Error) {
              _refreshController.refreshFailed();
            }
          },
          child: BlocBuilder<
            SeeMoreTopRatedMovieBloc,
            SeeMoreTopRatedMovieState
          >(
            builder: (context, state) {
              return switch (state) {
                InitialTopRatedMSeeMore() ||
                LoadingTopRatedMSeeMore() => Center(
                  child: Lottie.asset(
                    key: Key('loading_top_rated_movie'),
                    loadingBarLottiePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),

                LoadedTopRatedMSeeMore(topRated: final topRated) =>
                  topRated.isEmpty
                      ? EmptyStateWidget(
                        message: 'There are no top rated movies at the moment',
                      )
                      : SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh:
                            () => context.read<SeeMoreTopRatedMovieBloc>().add(
                              const SeeMoreTopRatedMovieEvent.refreshTopRatedMovies(),
                            ),
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
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = const Text("Pull up to load more");
                              // body = Text(AppLocalizations.of(context)!.pullUpToLoadMore);
                            } else if (mode == LoadStatus.loading) {
                              body = const CircularProgressIndicator();
                            } else if (mode == LoadStatus.failed) {
                              body = const Text("Load Failed! Click retry!");
                              // body = Text(AppLocalizations.of(context)!.loadFailedClickRetry);
                            } else if (mode == LoadStatus.noMore) {
                              body = const Text("No more data");
                              // body = Text(AppLocalizations.of(context)!.noMoreData);
                            } else {
                              body = const SizedBox();
                            }

                            return SizedBox(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),

                        child: ListView.builder(
                          key: Key('loaded_top_rated'),
                          controller: _topRatedScrollController,
                          itemCount: topRated.length,
                          itemBuilder: (context, index) {
                            final movie = topRated[index];
                            return MovieCard(movie);
                          },
                        ),
                      ),

                ErrorTopRatedMSeeMore(message: final message) => () {
                  // Tampilkan error state yang sesuai
                  if (message.contains('Failed to connect to the network')) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            noConnectionLottiePath,
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
                        () => context.read<SeeMoreTopRatedMovieBloc>().add(
                          const SeeMoreTopRatedMovieEvent.refreshTopRatedMovies(),
                        ),
                  );
                }(),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),

        // child: Consumer<TopRatedMoviesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return Center(
        //         child: Lottie.asset(
        //           key: Key('loading_top_rated_movie'),
        //           'assets/image_lottie/loading_bar.json',
        //           width: 100,
        //           height: 100,
        //           fit: BoxFit.fill,
        //         ),
        //       );
        //     } else if (data.state == RequestState.Loaded) {
        //       if (data.movies.isEmpty) {
        //         return const EmptyStateWidget(message: 'No movies available.');
        //       }
        //
        //       return SmartRefresher(
        //         controller: provider.refreshC,
        //         enablePullDown: true,
        //         enablePullUp: true,
        //         onRefresh: provider.onRefresh,
        //         header: const WaterDropHeader(
        //           complete: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Icon(Icons.check_circle_outline_rounded),
        //               Text('Refresh Complete'),
        //             ],
        //           ),
        //           failed: Text('Refresh Failed'),
        //           refresh: CircularProgressIndicator(),
        //           waterDropColor: Colors.orange,
        //           idleIcon: Icon(
        //             Icons.refresh_rounded,
        //             size: 20,
        //             color: Colors.white,
        //           ),
        //         ),
        //         footer: CustomFooter(
        //           builder: (BuildContext context, LoadStatus? mode) {
        //             Widget body;
        //             if (mode == LoadStatus.idle) {
        //               body = const Text("Pull up to load more");
        //               // body = Text(AppLocalizations.of(context)!.pullUpToLoadMore);
        //             } else if (mode == LoadStatus.loading) {
        //               body = const CircularProgressIndicator();
        //             } else if (mode == LoadStatus.failed) {
        //               body = const Text("Load Failed! Click retry!");
        //               // body = Text(AppLocalizations.of(context)!.loadFailedClickRetry);
        //             } else if (mode == LoadStatus.noMore) {
        //               body = const Text("No more data");
        //               // body = Text(AppLocalizations.of(context)!.noMoreData);
        //             } else {
        //               body = const SizedBox();
        //             }
        //
        //             return SizedBox(height: 55.0, child: Center(child: body));
        //           },
        //         ),
        //
        //         child: ListView.builder(
        //           key: Key('loaded_top_rated'),
        //           controller: data.scrollController,
        //           itemBuilder: (context, index) {
        //             final movie = data.movies[index];
        //             return MovieCard(movie);
        //           },
        //           itemCount: data.movies.length,
        //         ),
        //       );
        //     } else {
        //       return ErrorStateWidget2(
        //         key: Key('error_message'),
        //         message: data.message,
        //         onRetry: () => data.onRefresh(),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
