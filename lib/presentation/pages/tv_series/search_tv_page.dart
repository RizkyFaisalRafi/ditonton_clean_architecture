import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
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
                    return Center(child: CircularProgressIndicator());
                  } else if (data.state == RequestState.Error) {
                    return Center(
                      child: Text(
                        data.message,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    if (data.searchResult.isEmpty) {
                      return const Center(child: Text('No results found'));
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
                    // Initial state before searching
                    return const Center(
                      child: Text('Enter a TV series title to search'),
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
