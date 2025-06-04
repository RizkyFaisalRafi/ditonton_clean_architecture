import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../../common/state_enum.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';

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
              onSubmitted: (query) {
                Provider.of<TvSearchNotifier>(
                  context,
                  listen: false,
                ).fetchTvSearch(query);
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

            /// Result List
            Expanded(
              child: Consumer<TvSearchNotifier>(
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
                      title: 'Tv Series',
                    );
                  } else if (data.state == RequestState.Loaded) {
                    if (data.searchResult.isEmpty) {
                      return ErrorStateWidget(
                        message: 'No results found',
                        title: 'Tv Series',
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvS = data.searchResult[index];
                        return TvCard(tv: tvS);
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
                              'assets/image_lottie/search_tv.json',
                              width: 300,
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                            Text('Search TV Series', style: kHeading6),
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
