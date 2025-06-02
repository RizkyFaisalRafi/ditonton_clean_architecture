import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/state_enum.dart';
import '../../provider/tv_series/tv_list_notifier.dart';
import '../../widgets/tv_card.dart';

class TopRatedTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated Tv Series')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<TvListNotifier>(
          builder: (context, data, child) {
            if (data.topRatedTvState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (data.topRatedTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final topRatedTv = data.topRatedTvSeries[index];
                  return TvCard(tv: topRatedTv);
                },
                itemCount: data.topRatedTvSeries.length,
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
