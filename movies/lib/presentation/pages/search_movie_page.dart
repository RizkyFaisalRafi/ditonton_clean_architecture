import 'package:core/module/core.dart';

// import 'package:tv_series/module/tv_series.dart';
import '../../module/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchMoviePage extends StatelessWidget {
  const SearchMoviePage({super.key});

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
                if (state is MovieSearchLoading) {
                  return Expanded(
                    child: Center(
                      child: Lottie.asset(
                        key: Key('loading_state_lottie'),
                        loadingElephantLottiePath,
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                } else if (state is MovieSearchHasData) {
                  final result = state.result;

                  if (result.isEmpty) {
                    return ErrorStateWidget(
                      key: Key('loaded_state_empty_search'),
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
                } else if (state is MovieSearchError) {
                  // return Expanded(child: Center(child: Text(state.message)));
                  return Expanded(
                    child: ErrorStateWidget(
                      key: Key('error_state'),
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
                              animationMovieLottiePath,
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
          ],
        ),
      ),
    );
  }
}
