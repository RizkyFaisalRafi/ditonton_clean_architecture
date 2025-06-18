import 'package:ditonton_clean_architecture/common/constants.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_search/movie_search_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../widgets/error_state_widget.dart';

class SearchMoviePage extends StatelessWidget {
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
              onChanged: (query) {
                context.read<MovieSearchBloc>().add(OnQueryChanged(query));
              },
              // onSubmitted: (query) {
              //   Provider.of<MovieSearchNotifier>(
              //     context,
              //     listen: false,
              //   ).fetchMovieSearch(query);
              // },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text('Search Result', style: kHeading6),

            // BLOC
            BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/image_lottie/loading_elephant.json',
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                } else if (state is SearchHasData) {
                  final result = state.result;

                  if (result.isEmpty) {
                    return ErrorStateWidget(
                      message: 'No results found',
                      title: 'Movie',
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  // return Expanded(child: Center(child: Text(state.message)));
                  return Expanded(
                    child: ErrorStateWidget(
                      message: state.message,
                      title: 'Movie',
                    ),
                  );
                } else {
                  // return Expanded(child: Container());
                  // Initial state
                  return Expanded(
                    child: Center(
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
                    ),
                  );
                }
              },
            ),

            // Expanded(
            //   child: Consumer<MovieSearchNotifier>(
            //     builder: (context, data, child) {
            //       if (data.state == RequestState.Loading) {
            //         return Center(
            //           child: Lottie.asset(
            //             'assets/image_lottie/loading_elephant.json',
            //             width: 300,
            //             height: 300,
            //             fit: BoxFit.fill,
            //           ),
            //         );
            //       } else if (data.state == RequestState.Error) {
            //         return ErrorStateWidget(
            //           message: data.message,
            //           title: 'Movie',
            //         );
            //       } else if (data.state == RequestState.Loaded) {
            //         if (data.searchResult.isEmpty) {
            //           return ErrorStateWidget(
            //             message: 'No results found',
            //             title: 'Movie',
            //           );
            //         }
            //         return ListView.builder(
            //           padding: const EdgeInsets.all(8),
            //           itemBuilder: (context, index) {
            //             final movie = data.searchResult[index];
            //             return MovieCard(movie);
            //           },
            //           itemCount: data.searchResult.length,
            //         );
            //       } else {
            //         // Initial state
            //         return Center(
            //           child: SingleChildScrollView(
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Lottie.asset(
            //                   'assets/image_lottie/animation_movie.json',
            //                   width: 300,
            //                   height: 300,
            //                   fit: BoxFit.fill,
            //                 ),
            //                 Text('Search Movie', style: kHeading6),
            //               ],
            //             ),
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
