import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movies/module/movies.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tv_series/module/tv_series.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage>
    with AutomaticKeepAliveClientMixin<PopularMoviesPage> {
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _popularScrollController;

  @override
  void initState() {
    super.initState();
    _popularScrollController = ScrollController();

    // Logika Smart Fetching: Hanya panggil event fetch jika state BLoC masih dalam
    // kondisi awal (Initial). mencegah fetch berulang saat kembali ke halaman ini.
    if (context.read<SeeMorePopularMovieBloc>().state
        is InitialPopularMSeeMore) {
      context.read<SeeMorePopularMovieBloc>().add(
        const SeeMorePopularMovieEvent.fetchInitialPopularMovies(),
      );
    }

    final onScrollC = context.read<SeeMorePopularMovieBloc>();
    _popularScrollController.addListener(
      () => onScrollC.onScroll(_popularScrollController, () {
        context.read<SeeMorePopularMovieBloc>().add(
          const SeeMorePopularMovieEvent.fetchMorePopularSeeMoreMovies(),
        );
      }),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _popularScrollController.dispose();
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
      appBar: AppBar(title: Text('Popular Movies')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<SeeMorePopularMovieBloc, SeeMorePopularMovieState>(
          listener: (context, state) {
            // Listen for state changes to control the RefreshController
            if (state is LoadedPopularMSeeMore) {
              _refreshController.refreshCompleted();
            }
            if (state is Error) {
              _refreshController.refreshFailed();
            }
          },
          child: BlocBuilder<SeeMorePopularMovieBloc, SeeMorePopularMovieState>(
            builder: (context, state) {
              return switch (state) {
                InitialPopularMSeeMore() || LoadingPopularMSeeMore() => Center(
                  child: Lottie.asset(
                    key: Key('loading_popular_movie'),
                    'assets/image_lottie/loading_bar.json',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),

                LoadedPopularMSeeMore(popular: final popular) =>
                  popular.isEmpty
                      ? EmptyStateWidget(
                        message: 'There are no popular movies at the moment',
                      )
                      : SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh:
                            () => context.read<SeeMorePopularMovieBloc>().add(
                              const SeeMorePopularMovieEvent.refreshPopularMovies(),
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
                          key: Key('loaded_popular'),
                          controller: _popularScrollController,
                          itemCount: popular.length,
                          itemBuilder: (context, index) {
                            final movie = popular[index];
                            return MovieCard(movie);
                          },
                        ),
                      ),

                ErrorPopularMSeeMore(message: final message) => () {
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
                        () => context.read<SeeMorePopularMovieBloc>().add(
                          const SeeMorePopularMovieEvent.refreshPopularMovies(),
                        ),
                  );
                }(),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),
      ),
    );
  }
}
