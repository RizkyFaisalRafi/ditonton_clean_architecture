import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/state_enum.dart';
import '../../provider/movies/up_coming_movies_notifier.dart';
import '../../widgets/error_state_widget.dart';
import '../../widgets/movie_card_list.dart';

class UpComingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/up-coming-movie';

  @override
  State<UpComingMoviesPage> createState() => _UpComingMoviesPageState();
}

class _UpComingMoviesPageState extends State<UpComingMoviesPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.microtask(
  //     () =>
  //         Provider.of<UpComingMoviesNotifier>(
  //           context,
  //           listen: false,
  //         ).fetchUpComingMovies(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpComingMoviesNotifier>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Up Coming Movies')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<UpComingMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: Lottie.asset(
                  key: Key('loading_up_coming_movie'),
                  'assets/image_lottie/loading_bar.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
              );
            } else if (data.state == RequestState.Loaded) {
              if (data.movies.isEmpty) {
                return const EmptyStateWidget(message: 'No movies available.');
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
                  key: Key('loaded_up_coming'),
                  controller: data.scrollController,
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return MovieCard(movie);
                  },
                  itemCount: data.movies.length,
                ),
              );
            } else {
              return ErrorStateWidget2(
                key: Key('error_message'),
                message: data.message,
                onRetry: () => data.onRefresh(),
              );
              // return Center(
              //   key: Key('error_message'),
              //   child: Text(data.message),
              // );
            }
          },
        ),
      ),
    );
  }
}
