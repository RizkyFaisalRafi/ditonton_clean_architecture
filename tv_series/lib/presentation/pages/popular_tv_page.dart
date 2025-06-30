import 'package:core/module/core.dart';
import '../../module/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PopularTvPage extends StatefulWidget {
  static const routeName = '/popular-tv';

  const PopularTvPage({super.key});

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage>
    with AutomaticKeepAliveClientMixin<PopularTvPage> {
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _popularTvScrollController;

  @override
  void initState() {
    super.initState();

    _popularTvScrollController = ScrollController();
    // Logika Smart Fetching: Hanya panggil event fetch jika state BLoC masih dalam
    // kondisi awal (Initial). mencegah fetch berulang saat kembali ke halaman ini.
    if (context.read<SeeMorePopularTvBloc>().state is InitialPopularTSeeMore) {
      context.read<SeeMorePopularTvBloc>().add(
        const SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv(),
      );
    }

    final onScrollC = context.read<SeeMorePopularTvBloc>();
    _popularTvScrollController.addListener(
      () => onScrollC.onScroll(_popularTvScrollController, () {
        context.read<SeeMorePopularTvBloc>().add(
          const SeeMorePopularTvEvent.fetchMorePopularSeeMoreTv(),
        );
      }),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _popularTvScrollController.dispose();
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
      appBar: AppBar(title: Text('Popular Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: BlocListener<SeeMorePopularTvBloc, SeeMorePopularTvState>(
          listener: (context, state) {
            // Listen for state changes to control the RefreshController
            if (state is LoadedPopularTSeeMore) {
              _refreshController.refreshCompleted();
            }
            if (state is ErrorPopularTSeeMore) {
              _refreshController.refreshFailed();
            }
          },
          child: BlocBuilder<SeeMorePopularTvBloc, SeeMorePopularTvState>(
            builder: (context, state) {
              return switch (state) {
                InitialPopularTSeeMore() || LoadingPopularTSeeMore() => Center(
                  child: Lottie.asset(
                    key: Key('loading_popular_tv'),
                    loadingBarLottiePath,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),

                LoadedPopularTSeeMore(popularTv: final popularTv) =>
                  popularTv.isEmpty
                      ? EmptyStateWidget(
                        message: 'There are no popular tv at the moment',
                      )
                      : SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh:
                            () => context.read<SeeMorePopularTvBloc>().add(
                              const SeeMorePopularTvEvent.refreshPopularTv(),
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
                          key: Key('loaded_popular_tv'),
                          controller: _popularTvScrollController,
                          itemCount: popularTv.length,
                          itemBuilder: (context, index) {
                            final tv = popularTv[index];
                            return TvCard(tv: tv);
                          },
                        ),
                      ),

                ErrorPopularTSeeMore(message: final message) => () {
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
                        () => context.read<SeeMorePopularTvBloc>().add(
                          const SeeMorePopularTvEvent.refreshPopularTv(),
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
