
import 'package:ditonton_clean_architecture/domain/repositories/tv_series_repository.dart';

class GetWatchListStatusTv {
  final TvSeriesRepository repository;

  GetWatchListStatusTv(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}