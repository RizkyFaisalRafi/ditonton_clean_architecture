import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../../common/utils.dart';
import '../../widgets/build_episode_card.dart';
import '../../widgets/error_state_widget.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';

  final int id;

  const TvSeriesDetailPage({super.key, required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(
        context,
        listen: false,
      ).fetchTvDetail(widget.id);
      Provider.of<TvDetailNotifier>(
        context,
        listen: false,
      ).loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvState == RequestState.Loading) {
            return Center(
              child: Lottie.asset(
                key: Key('loading_tv_detail'),
                'assets/image_lottie/loading_bar.json',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            );
          } else if (provider.tvState == RequestState.Loaded) {
            final tvDetail = provider.tvDetail;
            return SafeArea(
              child: DetailContents(
                tvDetail!,
                provider.tvRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Center(
              child: ErrorStateWidget2(
                message: provider.message,
                onRetry: () => provider.fetchTvDetail(widget.id),
              ),
            );
          }
        },
      ),
    );
  }
}

class DetailContents extends StatelessWidget {
  final TvDetail tvDetail;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  const DetailContents(
    this.tvDetail,
    this.recommendations,
    this.isAddedWatchlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        // Gambar poster vertikal
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder:
              (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

        // Content Detail
        Container(
          margin: const EdgeInsets.only(top: 56),
          child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.32,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Backdrop Path (Gambar poster Horizontal)
                            if (tvDetail.backdropPath != null)
                              CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500${tvDetail.backdropPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder:
                                    (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget:
                                    (context, url, error) =>
                                        Icon(Icons.broken_image, size: 100),
                              )
                            else
                              Container(),

                            SizedBox(height: 8),

                            // Name
                            Text(tvDetail.name ?? 'No Title', style: kHeading5),

                            // Watchlist Button
                            FilledButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  await Provider.of<TvDetailNotifier>(
                                    context,
                                    listen: false,
                                  ).addWatchlist(tvDetail);
                                } else {
                                  await Provider.of<TvDetailNotifier>(
                                    context,
                                    listen: false,
                                  ).removeFromWatchlist(tvDetail);
                                }

                                final message =
                                    Provider.of<TvDetailNotifier>(
                                      context,
                                      listen: false,
                                    ).watchlistMessage;

                                if (message ==
                                        TvDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        TvDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(message),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),

                            SizedBox(height: 8),

                            // Genres
                            Text(showGenres(tvDetail.genres!)),

                            SizedBox(height: 8),

                            // Rating
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (tvDetail.voteAverage ?? 0) / 2,
                                  itemCount: 5,
                                  itemBuilder:
                                      (context, _) => Icon(
                                        Icons.star,
                                        color: kMikadoYellow,
                                      ),
                                  itemSize: 25,
                                ),
                                const SizedBox(width: 8),

                                Text('${tvDetail.voteAverage ?? 0}'),
                              ],
                            ),
                            SizedBox(height: 8),

                            // Popularity
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.thumb_up,
                                    color: Colors.blueAccent,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Popularity: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                  Text(
                                    tvDetail.popularity?.toStringAsFixed(1) ??
                                        'Not Available',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16),

                            // Creator / Created By
                            Text(
                              'Created by',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children:
                                  tvDetail.createdBy?.isNotEmpty == true
                                      ? tvDetail.createdBy!.map((creator) {
                                        return Chip(
                                          label: Text(
                                            creator.name ?? 'Unknown',
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.blueAccent,
                                        );
                                      }).toList()
                                      : [
                                        const Chip(
                                          label: Text(
                                            'Unknown',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          backgroundColor: Colors.grey,
                                        ),
                                      ],
                            ),

                            SizedBox(height: 16),

                            // Overview
                            Text('Overview', style: kHeading6),
                            const SizedBox(height: 8),
                            Text(tvDetail.overview ?? 'No overview available.'),

                            SizedBox(height: 16),

                            // Season Information
                            Text('Season Information', style: kHeading6),
                            const SizedBox(height: 8),
                            tvDetail.seasons != null &&
                                    tvDetail.seasons!.isNotEmpty
                                ? SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tvDetail.seasons!.length,
                                    itemBuilder: (context, index) {
                                      final season = tvDetail.seasons![index];
                                      return Container(
                                        width: 140,
                                        margin: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    season.posterPath != null
                                                        ? 'https://image.tmdb.org/t/p/w300${season.posterPath}'
                                                        : noImage,
                                                // placeholder
                                                width: 140,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                placeholder:
                                                    (context, url) => Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                          Icons.broken_image,
                                                        ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              season.name ?? 'Unknown Season',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '${season.episodeCount ?? 0} episodes',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              season.airDate ?? 'No date',
                                              style: TextStyle(
                                                color: Colors.white54,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                                : Text(
                                  'No season information available.',
                                  style: TextStyle(color: Colors.white54),
                                ),

                            SizedBox(height: 16),

                            // LAST EPISODE
                            if (tvDetail.lastEpisodeToAir != null)
                              buildEpisodeCard(
                                context,
                                title: 'Last Episode',
                                name: tvDetail.lastEpisodeToAir?.name,
                                airDate: tvDetail.lastEpisodeToAir?.airDate,
                                overview: tvDetail.lastEpisodeToAir?.overview,
                                imagePath: tvDetail.lastEpisodeToAir?.stillPath,
                                runtime: tvDetail.lastEpisodeToAir?.runtime,
                              ),

                            // NEXT EPISODE
                            if (tvDetail.nextEpisodeToAir != null)
                              buildEpisodeCard(
                                context,
                                title: 'Next Episode',
                                name: tvDetail.nextEpisodeToAir?.name,
                                airDate: tvDetail.nextEpisodeToAir?.airDate,
                                overview: tvDetail.nextEpisodeToAir?.overview,
                                imagePath: tvDetail.nextEpisodeToAir?.stillPath,
                                runtime: tvDetail.nextEpisodeToAir?.runtime,
                              ),

                            // Recommendations Tv Series
                            Text('Recommendations Tv Series', style: kHeading6),
                            SizedBox(height: 8),
                            Consumer<TvDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: recommendations.length,
                                      itemBuilder: (context, index) {
                                        final tvRecommend =
                                            recommendations[index];
                                        return Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Stack(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // Navigation Detail Page
                                                  Navigator.pushReplacementNamed(
                                                    context,
                                                    TvSeriesDetailPage
                                                        .ROUTE_NAME,
                                                    arguments: tvRecommend.id,
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(8),
                                                      ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        'https://image.tmdb.org/t/p/w500${tvRecommend.posterPath}',
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (
                                                          context,
                                                          url,
                                                        ) => Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),

                                              /// Textnya sesuai dengan ukuran Gambar
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 100,
                                                  height: 40,
                                                  color: Colors.black54,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                    vertical: 4,
                                                  ),
                                                  child: Text(
                                                    tvRecommend.name ??
                                                        'No Title',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
