import 'package:flutter/widgets.dart';
import 'package:tv_series/module/tv_series.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String showDuration(int runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h ${minutes}m';
  } else {
    return '${minutes}m';
  }
}

String showGenres(List<Genre> genres) {
  if (genres.isEmpty) return '-';
  return genres.map((genre) => genre.name).join(', ');
}
