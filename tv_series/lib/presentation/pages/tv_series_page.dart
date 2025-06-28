import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../module/tv_series.dart';
import 'package:core/module/core.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({super.key});

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage>
    with AutomaticKeepAliveClientMixin<TvSeriesPage> {
  // Deklarasikan semua ScrollController dan RefreshController
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _airingTodayScrollController;
  late final ScrollController _onTheAirScrollController;
  late final ScrollController _popularScrollController;
  late final ScrollController _topRatedScrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    /// Inisialisasi controller
    _airingTodayScrollController = ScrollController();
    _onTheAirScrollController = ScrollController();
    _popularScrollController = ScrollController();
    _topRatedScrollController = ScrollController();

    final tvAiringTodayBloc = context.read<AiringTodayTvBloc>();
    final tvOnTheAirBloc = context.read<OnTheAirTvBloc>();
    final tvPopularBloc = context.read<PopularTvBloc>();
    final tvTopRatedBloc = context.read<TopRatedTvBloc>();

    // Hanya fetch data jika state-nya masih initial (belum ada data)
    if (tvAiringTodayBloc.state is InitialAtTv) {
      tvAiringTodayBloc.add(const AiringTodayTvEvent.fetchInitialAiringToday());
    }
    if (tvOnTheAirBloc.state is InitialOtaTv) {
      tvOnTheAirBloc.add(const OnTheAirTvEvent.fetchInitialOnTheAir());
    }
    if (tvPopularBloc.state is InitialPopularTv) {
      tvPopularBloc.add(const PopularTvEvent.fetchInitialPopularTv());
    }
    if (tvTopRatedBloc.state is InitialTrTv) {
      tvTopRatedBloc.add(const TopRatedTvEvent.fetchInitialTopRatedTv());
    }

    /// Fetch data awal BLoC
    // context.read<AiringTodayTvBloc>().add(
    //   const AiringTodayTvEvent.fetchInitialTvS(),
    // );
    // context.read<onTheAirBloc.OnTheAirTvBloc>().add(
    //   const onTheAirBloc.OnTheAirTvEvent.fetchInitialOnTheAir(),
    // );
    // context.read<popularBloc.PopularTvBloc>().add(
    //   const popularBloc.PopularTvEvent.fetchInitialTvS(),
    // );
    // context.read<topRatedBloc.TopRatedTvBloc>().add(
    //   const topRatedBloc.TopRatedTvEvent.fetchInitialTvS(),
    // );

    /// listener untuk infinite scroll Airing Today
    _airingTodayScrollController.addListener(() {
      final airingTodayBloc = context.read<AiringTodayTvBloc>();
      if (_airingTodayScrollController.position.pixels >=
          _airingTodayScrollController.position.maxScrollExtent - 200) {
        airingTodayBloc.add(const AiringTodayTvEvent.fetchMoreAiringTodayTv());
      }
    });

    /// Listener untuk infinite scroll On The Air
    _onTheAirScrollController.addListener(() {
      if (_onTheAirScrollController.position.pixels >=
          _onTheAirScrollController.position.maxScrollExtent - 200) {
        context.read<OnTheAirTvBloc>().add(
          const OnTheAirTvEvent.fetchMoreOnTheAirTv(),
        );
      }
    });

    /// Listener untuk infinite scroll Popular
    _popularScrollController.addListener(() {
      if (_popularScrollController.position.pixels >=
          _popularScrollController.position.maxScrollExtent - 200) {
        context.read<PopularTvBloc>().add(
          const PopularTvEvent.fetchMorePopularTv(),
        );
      }
    });

    /// Listener untuk infinite scroll Top Rated
    _topRatedScrollController.addListener(() {
      if (_topRatedScrollController.position.pixels >=
          _topRatedScrollController.position.maxScrollExtent - 200) {
        context.read<TopRatedTvBloc>().add(
          const TopRatedTvEvent.fetchMoreTopRatedTv(),
        );
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _airingTodayScrollController.dispose();
    _onTheAirScrollController.dispose();
    _popularScrollController.dispose();
    _topRatedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
              Navigator.pushNamed(context, searchTvRoute);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: MultiBlocListener(
          listeners: [
            /// Listener AiringTodayTvBloc
            BlocListener<AiringTodayTvBloc, AiringTodayTvState>(
              listener: (context, state) {
                if (state is Error) {
                  _refreshController.refreshFailed();
                }
                if (state is LoadedAtTv) {
                  _refreshController.refreshCompleted();
                }
              },
            ),

            /// Listener OnTheAirTvBloc
            BlocListener<OnTheAirTvBloc, OnTheAirTvState>(
              listener: (context, state) {
                if (state is ErrorOtaTv) {
                  _refreshController.refreshFailed();
                }
                if (state is LoadedOtaTv) {
                  _refreshController.refreshCompleted();
                }
              },
            ),

            /// Listener PopularTvBloc
            BlocListener<PopularTvBloc, PopularTvState>(
              listener: (context, state) {
                if (state is ErrorPopularTv) {
                  _refreshController.refreshFailed();
                }
                if (state is LoadedPopularTv) {
                  _refreshController.refreshCompleted();
                }
              },
            ),

            /// Listener TopRatedTvBloc
            BlocListener<TopRatedTvBloc, TopRatedTvState>(
              listener: (context, state) {
                if (state is ErrorTrTv) {
                  _refreshController.refreshFailed();
                }
                if (state is LoadedTrTv) {
                  _refreshController.refreshCompleted();
                }
              },
            ),
          ],
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () {
              /// Refresh AiringTodayTvBloc
              context.read<AiringTodayTvBloc>().add(
                const AiringTodayTvEvent.refreshTvAt(),
              );

              /// Refresh OnTheAirTvBloc
              context.read<OnTheAirTvBloc>().add(
                const OnTheAirTvEvent.refreshTvOta(),
              );

              /// Refresh PopularTvBloc
              context.read<PopularTvBloc>().add(
                const PopularTvEvent.refreshPTv(),
              );

              /// Refresh TopRatedTvBloc
              context.read<TopRatedTvBloc>().add(
                const TopRatedTvEvent.refreshTvTr(),
              );
            },
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
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Now Playing / Airing Today
                  Text('Airing Today', style: kHeading6),

                  /// Airing Today Bloc
                  BlocBuilder<AiringTodayTvBloc, AiringTodayTvState>(
                    builder: (context, state) {
                      // Menggunakan switch expression dengan pattern matching
                      return switch (state) {
                        InitialAtTv() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        LoadingAtTv() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ErrorAtTv(message: final message) =>
                          message.contains('Failed to connect to the network')
                              ? Center(
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
                                      style: kSubtitle,
                                    ),
                                  ],
                                ),
                              )
                              : ErrorStateWidget2(
                                message: message,
                                onRetry: () {
                                  context.read<AiringTodayTvBloc>().add(
                                    AiringTodayTvEvent.refreshTvAt(),
                                  );
                                },
                              ),
                        LoadedAtTv(
                          airingToday: final airingToday,
                          hasMoreAiringToday: final hasMoreAt,
                        ) =>
                          airingToday.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
                                key: const Key('airing_today_list'),
                                tvSeries: airingToday,
                                scrollController: _airingTodayScrollController,
                                hasMore: hasMoreAt,
                              ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),

                  /// On The Air
                  _buildSubHeading(
                    title: 'On The Air',
                    onTap: () {
                      return Navigator.pushNamed(context, onTheAirTvRoute);
                    },
                  ),

                  /// On The Air Bloc
                  BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
                    builder: (context, state) {
                      // Gunakan switch expression untuk pattern matching yang modern
                      return switch (state) {
                        InitialOtaTv() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        LoadingOtaTv() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ErrorOtaTv(message: final message) => ErrorStateWidget2(
                          message: message,
                          onRetry: () {
                            context.read<OnTheAirTvBloc>().add(
                              OnTheAirTvEvent.refreshTvOta(),
                            );
                          },
                        ),

                        LoadedOtaTv(
                          onTheAir: final onTheAir,
                          hasMoreOnTheAir: final hasMoreOta,
                        ) =>
                          onTheAir.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
                                key: const Key('on_the_air_list'),
                                tvSeries: onTheAir,
                                scrollController: _onTheAirScrollController,
                                hasMore: hasMoreOta,
                              ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),

                  /// Popular Tv Series
                  _buildSubHeading(
                    title: 'Popular',
                    onTap: () {
                      return Navigator.pushNamed(
                        context,
                        PopularTvPage.routeName,
                      );
                    },
                  ),

                  /// Popular Bloc
                  BlocBuilder<PopularTvBloc, PopularTvState>(
                    builder: (context, state) {
                      // Gunakan switch expression untuk pattern matching yang modern
                      return switch (state) {
                        InitialPopularTv() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        LoadingPopularTv() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ErrorPopularTv(message: final message) =>
                          ErrorStateWidget2(
                            message: message,
                            onRetry: () {
                              context.read<PopularTvBloc>().add(
                                PopularTvEvent.refreshPTv(),
                              );
                            },
                          ),

                        LoadedPopularTv(
                          popular: final popularTv,
                          hasMorePopular: final hasMoreP,
                        ) =>
                          popularTv.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
                                key: const Key('popular_list'),
                                tvSeries: popularTv,
                                scrollController: _popularScrollController,
                                hasMore: hasMoreP,
                              ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),

                  /// Top Rated
                  _buildSubHeading(
                    title: 'Top Rated',
                    onTap: () {
                      return Navigator.pushNamed(
                        context,
                        TopRatedTvPage.routeName,
                      );
                    },
                  ),

                  /// Top Rated Bloc
                  BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                    builder: (context, state) {
                      return switch (state) {
                        InitialTrTv() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        LoadingTrTv() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ErrorTrTv(message: final message) => ErrorStateWidget2(
                          message: message,
                          onRetry: () {
                            context.read<TopRatedTvBloc>().add(
                              TopRatedTvEvent.refreshTvTr(),
                            );
                          },
                        ),

                        LoadedTrTv(
                          topRated: final topRatedTv,
                          hasMoreTopRated: final hasMoreTr,
                        ) =>
                          topRatedTv.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
                                key: const Key('top_rated_list'),
                                tvSeries: topRatedTv,
                                scrollController: _topRatedScrollController,
                                hasMore: hasMoreTr,
                              ),
                        _ => const SizedBox.shrink(),
                      };
                    },
                  ),
                ],
              ),
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
  final bool hasMore;

  const TvSeriesList({
    super.key,
    required this.tvSeries,
    required this.scrollController,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    if (tvSeries.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No TvSeries available.')),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        // itemCount: tvSeries.length,
        // Tambah 1 item jika `hasMore` true untuk menampilkan loading indicator
        itemCount: hasMore ? tvSeries.length + 1 : tvSeries.length,
        itemBuilder: (context, index) {
          // Jika index adalah item terakhir DAN masih ada data, tampilkan loading
          if (index >= tvSeries.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final tvSeriesData = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                /// Go to Detail Page Data Provider dari TvListNotifier harusnya
                Navigator.pushNamed(
                  context,
                  tvSeriesDetailRoute,
                  arguments: tvSeriesData.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvSeriesData.posterPath}',
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
