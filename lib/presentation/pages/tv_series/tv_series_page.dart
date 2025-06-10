import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../provider/tv_series/tv_list_notifier.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/error_state_widget.dart';
import 'on_the_air_tv_page.dart';

class TvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/tv-series';

  const TvSeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TvListNotifier>(context);

    return Scaffold(
      /// Home Content
      appBar: AppBar(
        title: Text('TV Series Ditonton'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            final customDrawerState =
                context.findRootAncestorStateOfType<CustomDrawerState>();
            customDrawerState?.toggle();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(8.0),
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
                /// Now Playing / Airing Today
                Text('Airing Today', style: kHeading6),
                Consumer<TvListNotifier>(
                  builder: (context, data, child) {
                    final state = data.airingTodayState;
                    if (state == RequestState.Loading) {
                      return Center(
                        child: Lottie.asset(
                          key: Key('loading_bar_airing_lottie'),
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
                      if (data.airingTodayTvSeries.isEmpty) {
                        return const EmptyStateWidget(
                          message: 'No movies available.',
                        );
                      }

                      return TvSeriesList(
                        data.airingTodayTvSeries,
                        data.airingTodayController,
                      );
                    } else {
                      // Initial State
                      return EmptyStateWidget(message: 'Failed');
                    }
                  },
                ),

                /// On The Air
                _buildSubHeading(
                  title: 'On The Air',
                  onTap: () {
                    return Navigator.pushNamed(
                      context,
                      OnTheAirTvPage.ROUTE_NAME,
                    );
                  },
                ),
                Consumer<TvListNotifier>(
                  builder: (context, data, child) {
                    final state = data.onTheAirState;
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
                      return TvSeriesList(
                        data.onTheAirTvSeries,
                        data.onTheAirController,
                      );
                    } else {
                      return EmptyStateWidget(
                        message:
                            "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                      );
                    }
                  },
                ),

                /// Popular Tv Series
                _buildSubHeading(
                  title: 'Popular',
                  onTap: () {
                    return Navigator.pushNamed(
                      context,
                      PopularTvPage.ROUTE_NAME,
                    );
                  },
                ),
                Consumer<TvListNotifier>(
                  builder: (context, data, child) {
                    final state = data.popularTvState;
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
                      return TvSeriesList(
                        data.popularTvSeries,
                        data.popularController,
                      );
                    } else {
                      return EmptyStateWidget(message: "Failed to Load Data");
                    }
                  },
                ),

                /// Top Rated
                _buildSubHeading(
                  title: 'Top Rated',
                  onTap: () {
                    return Navigator.pushNamed(
                      context,
                      TopRatedTvPage.ROUTE_NAME,
                    );
                  },
                ),
                Consumer<TvListNotifier>(
                  builder: (context, data, child) {
                    final state = data.topRatedTvState;
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
                      return TvSeriesList(
                        data.topRatedTvSeries,
                        data.topRatedController,
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

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;
  final ScrollController scrollController;

  const TvSeriesList(this.tvSeries, this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeriesData = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                /// Go to Detail Page Data Provider dari TvListNotifier harusnya
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSeriesData.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeriesData.posterPath}',
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
