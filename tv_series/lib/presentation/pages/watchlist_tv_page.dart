import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:core/module/core.dart';
import '../../module/tv_series.dart';

class WatchlistTvPage extends StatefulWidget {
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
              InitialWatchlistTv() || LoadingWatchlistTv() => Center(
                child: Lottie.asset(
                  key: Key('loading_watchlist_tv'),
                  'assets/image_lottie/loading_bar.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),

              LoadedWatchlistTv(watchlistTv: final watchlistTv) =>
                watchlistTv.isEmpty
                    ? EmptyStateWidget(message: 'No Watchlist Available.')
                    : ListView.builder(
                      itemCount: watchlistTv.length,
                      itemBuilder: (context, index) {
                        final watchlist = watchlistTv[index];
                        return TvCard(tv: watchlist);
                      },
                    ),

              ErrorWatchlistTv(message: final message) => () {
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
