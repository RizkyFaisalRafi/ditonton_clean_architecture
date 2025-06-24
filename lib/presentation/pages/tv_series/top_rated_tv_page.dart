import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/constants.dart';
import '../../bloc/tv/see_more_top_rated/see_more_top_rated_tv_bloc.dart';
import '../../widgets/error_state_widget.dart';
import '../../widgets/tv_card.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvPage({super.key});

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage>
    with AutomaticKeepAliveClientMixin<TopRatedTvPage> {
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _topRatedTvScrollController;

  @override
  void initState() {
    super.initState();

    _topRatedTvScrollController = ScrollController();
    // Logika Smart Fetching: Hanya panggil event fetch jika state BLoC masih dalam
    // kondisi awal (Initial). mencegah fetch berulang saat kembali ke halaman ini.
    if (context.read<SeeMoreTopRatedTvBloc>().state is Initial) {
      context.read<SeeMoreTopRatedTvBloc>().add(
        const SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv(),
      );
    }

    final onScrollC = context.read<SeeMoreTopRatedTvBloc>();
    _topRatedTvScrollController.addListener(
      () => onScrollC.onScroll(_topRatedTvScrollController, () {
        context.read<SeeMoreTopRatedTvBloc>().add(
          const SeeMoreTopRatedTvEvent.fetchMoreTopRatedTv(),
        );
      }),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _topRatedTvScrollController.dispose();
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
      appBar: AppBar(title: Text('Top Rated Tv Series')),
      body: Padding(
        padding: EdgeInsets.all(8.0),

        child: BlocListener<SeeMoreTopRatedTvBloc, SeeMoreTopRatedTvState>(
          listener: (context, state) {
            // Listen for state changes to control the RefreshController
            if (state is Loaded) {
              _refreshController.refreshCompleted();
            }
            if (state is Error) {
              _refreshController.refreshFailed();
            }
          },
          child: BlocBuilder<SeeMoreTopRatedTvBloc, SeeMoreTopRatedTvState>(
            builder: (context, state) {
              return switch (state) {
                Initial() || Loading() => Center(
                  child: Lottie.asset(
                    key: Key('loading_top_rated_tv'),
                    'assets/image_lottie/loading_bar.json',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),

                Loaded(topRatedTv: final topRatedTv) =>
                  topRatedTv.isEmpty
                      ? EmptyStateWidget(
                        message: 'There are no top rated tv at the moment',
                      )
                      : SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh:
                            () => context.read<SeeMoreTopRatedTvBloc>().add(
                              const SeeMoreTopRatedTvEvent.refreshTv(),
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
                          key: Key('loaded_top_rated_tv'),
                          controller: _topRatedTvScrollController,
                          itemCount: topRatedTv.length,
                          itemBuilder: (context, index) {
                            final tv = topRatedTv[index];
                            return TvCard(tv: tv);
                          },
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
                        () => context.read<SeeMoreTopRatedTvBloc>().add(
                          const SeeMoreTopRatedTvEvent.refreshTv(),
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
