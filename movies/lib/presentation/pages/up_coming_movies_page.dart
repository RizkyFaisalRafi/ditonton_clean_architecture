import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../module/movies.dart';

class UpComingMoviesPage extends StatefulWidget {
  const UpComingMoviesPage({super.key});

  @override
  State<UpComingMoviesPage> createState() => _UpComingMoviesPageState();
}

class _UpComingMoviesPageState extends State<UpComingMoviesPage>
    with AutomaticKeepAliveClientMixin<UpComingMoviesPage> {
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _upComingScrollController;

  @override
  void initState() {
    super.initState();
    _upComingScrollController = ScrollController();

    // Logika Smart Fetching: Hanya panggil event fetch jika state BLoC masih dalam
    // kondisi awal (Initial). mencegah fetch berulang saat kembali ke halaman ini.
    if (context.read<SeeMoreUpcomingMovieBloc>().state
        is InitialUpComingMSeeMore) {
      context.read<SeeMoreUpcomingMovieBloc>().add(
        const SeeMoreUpcomingMovieEvent.fetchInitialUpComingMovies(),
      );
    }

    final onScrollC = context.read<SeeMoreUpcomingMovieBloc>();
    _upComingScrollController.addListener(
      () => onScrollC.onScroll(_upComingScrollController, () {
        context.read<SeeMoreUpcomingMovieBloc>().add(
          const SeeMoreUpcomingMovieEvent.fetchMoreUpComingSeeMoreMovies(),
        );
      }),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _upComingScrollController.dispose();
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
      appBar: AppBar(title: Text('Up Coming Movies')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocListener<
          SeeMoreUpcomingMovieBloc,
          SeeMoreUpcomingMovieState
        >(
          listener: (context, state) {
            // Listen for state changes to control the RefreshController
            if (state is LoadedUpComingMSeeMore) {
              _refreshController.refreshCompleted();
            }
            if (state is Error) {
              _refreshController.refreshFailed();
            }
          },
          child: BlocBuilder<
            SeeMoreUpcomingMovieBloc,
            SeeMoreUpcomingMovieState
          >(
            builder: (context, state) {
              return switch (state) {
                InitialUpComingMSeeMore() ||
                LoadingUpComingMSeeMore() => Center(
                  child: Lottie.asset(
                    key: Key('loading_up_coming_movie'),
                    loadingBarLottiePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),

                LoadedUpComingMSeeMore(upComing: final upComing) =>
                  upComing.isEmpty
                      ? EmptyStateWidget(
                        message: 'There are no up coming movies at the moment',
                      )
                      : SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh:
                            () => context.read<SeeMoreUpcomingMovieBloc>().add(
                              const SeeMoreUpcomingMovieEvent.refreshUpComingMovies(),
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
                          key: Key('loaded_up_coming'),
                          controller: _upComingScrollController,
                          itemCount: upComing.length,
                          itemBuilder: (context, index) {
                            final movie = upComing[index];
                            return MovieCard(movie);
                          },
                        ),
                      ),

                ErrorUpComingMSeeMore(message: final message) => () {
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
                        () => context.read<SeeMoreUpcomingMovieBloc>().add(
                          const SeeMoreUpcomingMovieEvent.refreshUpComingMovies(),
                        ),
                  );
                }(),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),

        // child: Consumer<UpComingMoviesNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return Center(
        //         child: Lottie.asset(
        //           key: Key('loading_up_coming_movie'),
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
        //           key: Key('loaded_up_coming'),
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
        //       // return Center(
        //       //   key: Key('error_message'),
        //       //   child: Text(data.message),
        //       // );
        //     }
        //   },
        // ),
      ),
    );
  }
}
