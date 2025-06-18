import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/airing_today/airing_today_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/popular/popular_tv_bloc.dart'
    as popularBloc;
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/top_rated/top_rated_tv_bloc.dart'
    as topRatedBloc;
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/constants.dart';
import '../../bloc/tv/tv_list/on_the_air/on_the_air_tv_bloc.dart'
    as onTheAirBloc;
import '../../widgets/custom_drawer.dart';
import '../../widgets/error_state_widget.dart';
import 'on_the_air_tv_page.dart';

class TvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';

  const TvSeriesPage({super.key});

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  // Deklarasikan semua ScrollController dan RefreshController
  final RefreshController _refreshController = RefreshController();
  late final ScrollController _airingTodayScrollController;
  late final ScrollController _onTheAirScrollController;
  late final ScrollController _popularScrollController;
  late final ScrollController _topRatedScrollController;

  @override
  void initState() {
    super.initState();

    /// Inisialisasi controller
    _airingTodayScrollController = ScrollController();
    _onTheAirScrollController = ScrollController();
    _popularScrollController = ScrollController();
    _topRatedScrollController = ScrollController();

    /// Fetch data awal BLoC
    context.read<AiringTodayTvBloc>().add(
      const AiringTodayTvEvent.fetchInitialTvS(),
    );
    context.read<onTheAirBloc.OnTheAirTvBloc>().add(
      const onTheAirBloc.OnTheAirTvEvent.fetchInitialOnTheAir(),
    );
    context.read<popularBloc.PopularTvBloc>().add(
      const popularBloc.PopularTvEvent.fetchInitialTvS(),
    );
    context.read<topRatedBloc.TopRatedTvBloc>().add(
      const topRatedBloc.TopRatedTvEvent.fetchInitialTvS(),
    );

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
        context.read<onTheAirBloc.OnTheAirTvBloc>().add(
          const onTheAirBloc.OnTheAirTvEvent.fetchMoreOnTheAirTv(),
        );
      }
    });

    /// Listener untuk infinite scroll Popular
    _popularScrollController.addListener(() {
      if (_popularScrollController.position.pixels >=
          _popularScrollController.position.maxScrollExtent - 200) {
        context.read<popularBloc.PopularTvBloc>().add(
          const popularBloc.PopularTvEvent.fetchMorePopularTv(),
        );
      }
    });

    /// Listener untuk infinite scroll Top Rated
    _topRatedScrollController.addListener(() {
      if (_topRatedScrollController.position.pixels >=
          _topRatedScrollController.position.maxScrollExtent - 200) {
        context.read<topRatedBloc.TopRatedTvBloc>().add(
          const topRatedBloc.TopRatedTvEvent.fetchMoreTopRatedTv(),
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
        child: MultiBlocListener(
          listeners: [
            /// Listener AiringTodayTvBloc
            BlocListener<AiringTodayTvBloc, AiringTodayTvState>(
              listener: (context, state) {
                if (state is Error) {
                  _refreshController.refreshFailed();
                }
                if (state is Loaded) {
                  _refreshController.refreshCompleted();
                }
              },
            ),

            /// Listener OnTheAirTvBloc
            BlocListener<
              onTheAirBloc.OnTheAirTvBloc,
              onTheAirBloc.OnTheAirTvState
            >(
              listener: (context, state) {
                if (state is onTheAirBloc.Error) {
                  _refreshController.refreshFailed();
                }
                if (state is onTheAirBloc.Loaded) {
                  _refreshController.refreshCompleted();
                }
              },
            ),

            /// Listener PopularTvBloc
            BlocListener<popularBloc.PopularTvBloc, popularBloc.PopularTvState>(
              listener: (context, state) {
                if (state is popularBloc.Error) {
                  _refreshController.refreshFailed();
                }
                if (state is popularBloc.Loaded) {
                  _refreshController.refreshCompleted();
                }
              },
            ),

            /// Listener TopRatedTvBloc
            BlocListener<
              topRatedBloc.TopRatedTvBloc,
              topRatedBloc.TopRatedTvState
            >(
              listener: (context, state) {
                if (state is topRatedBloc.Error) {
                  _refreshController.refreshFailed();
                }
                if (state is topRatedBloc.Loaded) {
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
                const AiringTodayTvEvent.refreshTv(),
              );

              /// Refresh OnTheAirTvBloc
              context.read<onTheAirBloc.OnTheAirTvBloc>().add(
                const onTheAirBloc.OnTheAirTvEvent.refreshTvOTA(),
              );

              /// Refresh PopularTvBloc
              context.read<popularBloc.PopularTvBloc>().add(
                const popularBloc.PopularTvEvent.refreshTv(),
              );

              /// Refresh TopRatedTvBloc
              context.read<topRatedBloc.TopRatedTvBloc>().add(
                const topRatedBloc.TopRatedTvEvent.refreshTv(),
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
                        Initial() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        Loading() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Error(message: final message) => ErrorStateWidget2(
                          message: message,
                          onRetry: () {
                            context.read<AiringTodayTvBloc>().add(
                              AiringTodayTvEvent.refreshTv(),
                            );
                          },
                        ),
                        Loaded(
                          airingToday: final airingToday,
                          hasMoreAiringToday: final hasMoreAt,
                        ) =>
                          airingToday.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
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
                      return Navigator.pushNamed(
                        context,
                        OnTheAirTvPage.ROUTE_NAME,
                      );
                    },
                  ),

                  /// On The Air Bloc
                  BlocBuilder<
                    onTheAirBloc.OnTheAirTvBloc,
                    onTheAirBloc.OnTheAirTvState
                  >(
                    builder: (context, state) {
                      // Gunakan switch expression untuk pattern matching yang modern
                      return switch (state) {
                        onTheAirBloc.Initial() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        onTheAirBloc.Loading() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTheAirBloc.Error(message: final message) =>
                          ErrorStateWidget2(
                            message: message,
                            onRetry: () {
                              context.read<onTheAirBloc.OnTheAirTvBloc>().add(
                                onTheAirBloc.OnTheAirTvEvent.refreshTvOTA(),
                              );
                            },
                          ),

                        onTheAirBloc.Loaded(
                          onTheAir: final onTheAir,
                          hasMoreOnTheAir: final hasMoreOta,
                        ) =>
                          onTheAir.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
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
                        PopularTvPage.ROUTE_NAME,
                      );
                    },
                  ),

                  /// Popular Bloc
                  BlocBuilder<
                    popularBloc.PopularTvBloc,
                    popularBloc.PopularTvState
                  >(
                    builder: (context, state) {
                      // Gunakan switch expression untuk pattern matching yang modern
                      return switch (state) {
                        popularBloc.Initial() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        popularBloc.Loading() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        popularBloc.Error(message: final message) =>
                          ErrorStateWidget2(
                            message: message,
                            onRetry: () {
                              context.read<popularBloc.PopularTvBloc>().add(
                                popularBloc.PopularTvEvent.refreshTv(),
                              );
                            },
                          ),

                        popularBloc.Loaded(
                          popular: final popularTv,
                          hasMorePopular: final hasMoreP,
                        ) =>
                          popularTv.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
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
                        TopRatedTvPage.ROUTE_NAME,
                      );
                    },
                  ),

                  /// Top Rated Bloc
                  BlocBuilder<
                    topRatedBloc.TopRatedTvBloc,
                    topRatedBloc.TopRatedTvState
                  >(
                    builder: (context, state) {
                      return switch (state) {
                        topRatedBloc.Initial() => EmptyStateWidget(
                          message:
                              "Please Check Your Internet and refresh the page by clicking the 'Retry' button or Scroll the Page up",
                        ),
                        topRatedBloc.Loading() => Center(
                          child: Lottie.asset(
                            key: Key('loading_bar_lottie'),
                            'assets/image_lottie/loading_bar.json',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        topRatedBloc.Error(message: final message) =>
                          ErrorStateWidget2(
                            message: message,
                            onRetry: () {
                              context.read<topRatedBloc.TopRatedTvBloc>().add(
                                topRatedBloc.TopRatedTvEvent.refreshTv(),
                              );
                            },
                          ),

                        topRatedBloc.Loaded(
                          topRated: final topRatedTv,
                          hasMoreTopRated: final hasMoreTr,
                        ) =>
                          topRatedTv.isEmpty
                              ? const EmptyStateWidget(
                                message: 'No Tv available.',
                              )
                              : TvSeriesList(
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
      ),
    );
  }
}
