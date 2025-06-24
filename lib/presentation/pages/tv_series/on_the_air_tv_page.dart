import 'package:ditonton_clean_architecture/presentation/bloc/tv/see_more_on_the_air/see_more_on_the_air_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/on_the_air_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../widgets/error_state_widget.dart';

class OnTheAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-the-air-tv';

  const OnTheAirTvPage({super.key});

  @override
  State<OnTheAirTvPage> createState() => _OnTheAirTvPageState();
}

class _OnTheAirTvPageState extends State<OnTheAirTvPage>
    with AutomaticKeepAliveClientMixin<OnTheAirTvPage> {
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _onTheAirScrollController;

  @override
  void initState() {
    super.initState();

    _onTheAirScrollController = ScrollController();
    // Logika Smart Fetching: Hanya panggil event fetch jika state BLoC masih dalam
    // kondisi awal (Initial). mencegah fetch berulang saat kembali ke halaman ini.
    if (context.read<SeeMoreOnTheAirTvBloc>().state is Initial) {
      context.read<SeeMoreOnTheAirTvBloc>().add(
        const SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirTv(),
      );
    }

    final onScrollC = context.read<SeeMoreOnTheAirTvBloc>();
    _onTheAirScrollController.addListener(
      () => onScrollC.onScroll(_onTheAirScrollController, () {
        context.read<SeeMoreOnTheAirTvBloc>().add(
          const SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirTv(),
        );
      }),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _onTheAirScrollController.dispose();
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
      appBar: AppBar(title: Text('On The Air Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: BlocListener<SeeMoreOnTheAirTvBloc, SeeMoreOnTheAirTvState>(
          listener: (context, state) {
            // Listen for state changes to control the RefreshController
            if (state is Loaded) {
              _refreshController.refreshCompleted();
            }
            if (state is Error) {
              _refreshController.refreshFailed();
            }
          },
          child: BlocBuilder<SeeMoreOnTheAirTvBloc, SeeMoreOnTheAirTvState>(
            builder: (context, state) {
              return switch (state) {
                Initial() || Loading() => Center(
                  child: Lottie.asset(
                    key: Key('loading_on_the_air_tv'),
                    'assets/image_lottie/loading_bar.json',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),

                Loaded(onTheAir: final onTheAir) =>
                  onTheAir.isEmpty
                      ? EmptyStateWidget(
                        message: 'There are no on the air tv at the moment',
                      )
                      : SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        onRefresh:
                            () => context.read<SeeMoreOnTheAirTvBloc>().add(
                              const SeeMoreOnTheAirTvEvent.refreshTv(),
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
                          key: Key('loaded_on_the_air'),
                          controller: _onTheAirScrollController,
                          itemCount: onTheAir.length,
                          itemBuilder: (context, index) {
                            final tv = onTheAir[index];
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
                        () => context.read<SeeMoreOnTheAirTvBloc>().add(
                          const SeeMoreOnTheAirTvEvent.refreshTv(),
                        ),
                  );
                }(),
                _ => const SizedBox.shrink(),
              };
            },
          ),
        ),

        // child: Consumer<OnTheAirNotifier>(
        //   builder: (context, data, child) {
        //     if (data.state == RequestState.Loading) {
        //       return Center(
        //         child: Lottie.asset(
        //           key: Key('loading_on_the_air_tv'),
        //           'assets/image_lottie/loading_bar.json',
        //           width: 100,
        //           height: 100,
        //           fit: BoxFit.fill,
        //         ),
        //       );
        //     } else if (data.state == RequestState.Loaded) {
        //       if (data.tvSeriesList.isEmpty) {
        //         return const EmptyStateWidget(
        //           message: 'No tv series available.',
        //         );
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
        //         child: ListView.builder(
        //           key: Key('loaded_on_the_air'),
        //           controller: data.scrollController,
        //           itemBuilder: (context, index) {
        //             final onTheAirTv = data.tvSeriesList[index];
        //             return TvCard(tv: onTheAirTv);
        //           },
        //           itemCount: data.tvSeriesList.length,
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
