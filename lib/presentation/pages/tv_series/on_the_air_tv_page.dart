import 'package:ditonton_clean_architecture/presentation/provider/tv_series/on_the_air_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/state_enum.dart';
import '../../widgets/error_state_widget.dart';

class OnTheAirTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/on-the-air-tv';

  const OnTheAirTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnTheAirNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text('On The Air Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnTheAirNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: Lottie.asset(
                  key: Key('loading_on_the_air_tv'),
                  'assets/image_lottie/loading_bar.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              );
            } else if (data.state == RequestState.Loaded) {
              if (data.tvSeriesList.isEmpty) {
                return const EmptyStateWidget(
                  message: 'No tv series available.',
                );
              }

              return SmartRefresher(
                controller: provider.refreshC,
                enablePullDown: true,
                enablePullUp: true,
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

                    return SizedBox(height: 55.0, child: Center(child: body));
                  },
                ),
                child: ListView.builder(
                  key: Key('loaded_on_the_air'),
                  controller: data.scrollController,
                  itemBuilder: (context, index) {
                    final onTheAirTv = data.tvSeriesList[index];
                    return TvCard(tv: onTheAirTv);
                  },
                  itemCount: data.tvSeriesList.length,
                ),
              );
            } else {
              return ErrorStateWidget2(
                key: Key('error_message'),
                message: data.message,
                onRetry: () => data.onRefresh(),
              );
            }
          },
        ),
      ),
    );
  }
}
