import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/module/core.dart';
import '../../domain/entities/tv_series.dart';
import 'package:flutter/material.dart';

class TvCard extends StatelessWidget {
  final TvSeries tv;

  const TvCard({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          log('--- TvCard Tapped for id: ${tv.id}! ---');
          Navigator.pushNamed(context, tvSeriesDetailRoute, arguments: tv.id);
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tv.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      tv.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child:
                    tv.posterPath != null
                        ? CachedNetworkImage(
                          imageUrl: '$baseImageUrl${tv.posterPath}',
                          width: 80,
                          placeholder:
                              (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                          errorWidget:
                              (context, url, error) => Icon(Icons.error),
                        )
                        : const SizedBox(
                          width: 80,
                          height: 120,
                          child: Icon(Icons.error),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
