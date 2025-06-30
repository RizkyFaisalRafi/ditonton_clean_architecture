import 'package:flutter/material.dart';
import 'package:core/module/core.dart';

String formatAirDate(String? airDate) {
  return 'Air Date: ${airDate ?? 'Air Date Is Not Available'}';
}

Widget buildEpisodeCard(
  BuildContext context, {
  required String title,
  required String? name,
  required String? airDate,
  required String? overview,
  required String? imagePath,
  required int? runtime,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.blueAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imagePath != null
                      ? 'https://image.tmdb.org/t/p/w500$imagePath'
                      : noImage,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title: ${name ?? 'Name Is Not Available'}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatAirDate(airDate),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      overview?.isNotEmpty == true
                          ? overview!
                          : 'Description Is Not Available',
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Duration: ${runtime != null ? showDuration(runtime) : 'Duration Is Not Available'}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}
