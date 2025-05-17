import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/state_enum.dart';
import '../provider/up_coming_movies_notifier.dart';
import '../widgets/movie_card_list.dart';

class UpComingMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/up-coming-movie';

  @override
  State<UpComingMoviesPage> createState() => _UpComingMoviesPageState();
}

class _UpComingMoviesPageState extends State<UpComingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<UpComingMoviesNotifier>(
            context,
            listen: false,
          ).fetchUpComingMovies(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Up Coming Movies')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<UpComingMoviesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.movies[index];
                  return MovieCard(movie);
                },
                itemCount: data.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
