import 'package:ditonton_clean_architecture/common/constants.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/movie_search_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widgets/error_state_widget.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Movie')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(
                  context,
                  listen: false,
                ).fetchMovieSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text('Search Result', style: kHeading6),

            Expanded(
              child: Consumer<MovieSearchNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: Lottie.asset(
                        'assets/image_lottie/loading_elephant.json',
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    );
                  } else if (data.state == RequestState.Error) {
                    return ErrorStateWidget(
                      message: data.message,
                      title: 'Movie',
                    );
                  } else if (data.state == RequestState.Loaded) {
                    if (data.searchResult.isEmpty) {
                      return ErrorStateWidget(
                        message: 'No results found',
                        title: 'Movie',
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = data.searchResult[index];
                        return MovieCard(movie);
                      },
                      itemCount: data.searchResult.length,
                    );
                  } else {
                    // Initial state
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/image_lottie/animation_movie.json',
                              width: 300,
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                            Text('Search Movie', style: kHeading6),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
