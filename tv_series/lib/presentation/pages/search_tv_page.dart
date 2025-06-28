import 'package:core/module/core.dart';
import '../../module/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SearchTvPage extends StatelessWidget {
  const SearchTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<TvSearchBloc>().add(OnQueryChangedTv(query));
              },
              decoration: InputDecoration(
                hintText: 'Search Tv Series',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),

            Text('Search Result', style: kHeading6),

            // BLOC
            BlocBuilder<TvSearchBloc, TvSearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return Expanded(
                    child: Center(
                      child: Lottie.asset(
                        key: Key('loading_state_lottie'),
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
                      key: Key('loaded_state_empty_search'),
                      message: 'No results found',
                      title: 'TV',
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvS = result[index];
                        return TvCard(tv: tvS);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  // return Expanded(child: Center(child: Text(state.message)));
                  return Expanded(
                    child: ErrorStateWidget(
                      key: Key('error_state'),
                      message: state.message,
                      title: 'TV',
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
                            Text('Search TV Series', style: kHeading6),
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
