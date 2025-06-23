import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/utils.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_watchlist/watchlist_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../common/constants.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/error_state_widget.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTvPage({super.key});

  @override
  WatchlistTvPageState createState() => WatchlistTvPageState();
}

class WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvBloc>().add(
      const WatchlistTvEvent.fetchInitialWatchlistTv(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Mengirim event ke BLoC untuk mengambil ulang data watchlist
    context.read<WatchlistTvBloc>().add(
      const WatchlistTvEvent.fetchInitialWatchlistTv(),
    );
    super.didPopNext(); // Sebaiknya panggil super juga
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist TV'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // drawerKey.currentState?.toggle();
            final customDrawerState =
                context.findRootAncestorStateOfType<CustomDrawerState>();
            customDrawerState?.toggle();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            return switch (state) {
              Initial() || Loading() => Center(
                child: Lottie.asset(
                  key: Key('loading_watchlist_tv'),
                  'assets/image_lottie/loading_bar.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),

              Loaded(watchlistTv: final watchlistTv) =>
                watchlistTv.isEmpty
                    ? EmptyStateWidget(message: 'No Watchlist Available.')
                    : ListView.builder(
                      itemCount: watchlistTv.length,
                      itemBuilder: (context, index) {
                        final watchlist = watchlistTv[index];
                        return TvCard(watchlist);
                      },
                    ),

              Error(message: final message) => () {
                return EmptyStateWidget(message: message);
              }(),
              _ => const SizedBox.shrink(),
            };
          },
        ),
      ),
    );
  }
}

class TvCard extends StatelessWidget {
  final TvSeries tv;

  const TvCard(this.tv, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          print('--- TvCard Tapped for id: ${tv.id}! ---');
          Navigator.pushNamed(
            context,
            TvSeriesDetailPage.ROUTE_NAME,
            arguments: tv.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tv.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      tv.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  width: 80,
                  placeholder:
                      (context, url) =>
                          Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
