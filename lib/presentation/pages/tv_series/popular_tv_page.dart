import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/state_enum.dart';
import '../../provider/tv_series/tv_list_notifier.dart';
import '../../widgets/tv_card.dart';

class PopularTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-tv';
  const PopularTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvListNotifier>(
          builder: (context, data, child) {
            if (data.popularTvState == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (data.popularTvState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final onTheAirTv = data.popularTvSeries[index];
                  return TvCard(tv: onTheAirTv);
                },
                itemCount: data.popularTvSeries.length,
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
