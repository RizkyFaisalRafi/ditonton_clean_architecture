import 'package:ditonton_clean_architecture/common/utils.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/error_state_widget.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(
      const WatchlistMovieEvent.fetchInitialWatchlistMovies(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // Mengirim event ke BLoC untuk mengambil ulang data watchlist
    context.read<WatchlistMovieBloc>().add(
      const WatchlistMovieEvent.fetchInitialWatchlistMovies(),
    );
    super.didPopNext(); // Sebaiknya panggil super juga
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist Movie'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            final customDrawerState =
                context.findRootAncestorStateOfType<CustomDrawerState>();
            customDrawerState?.toggle();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            return switch (state) {
              Initial() || Loading() => Center(
                child: Lottie.asset(
                  key: Key('loading_watchlist_movie'),
                  'assets/image_lottie/loading_bar.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              ),

              Loaded(watchlistMovie: final watchlistMovie) =>
                watchlistMovie.isEmpty
                    ? EmptyStateWidget(message: 'No Watchlist Available.')
                    : ListView.builder(
                      itemCount: watchlistMovie.length,
                      itemBuilder: (context, index) {
                        final watchlist = watchlistMovie[index];
                        return MovieCard(watchlist);
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
