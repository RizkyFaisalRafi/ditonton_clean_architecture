import 'package:bloc/bloc.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tv/tv_series.dart';

part 'watchlist_tv_event.dart';

part 'watchlist_tv_state.dart';

part 'watchlist_tv_bloc.freezed.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvBloc({required this.getWatchlistTv}) : super(Initial()) {
    // Fetch Data Watchlist
    on<FetchInitialWatchlistTv>(_onFetchWatchlistTv);
  }

  Future<void> _onFetchWatchlistTv(
    FetchInitialWatchlistTv event,
    Emitter<WatchlistTvState> emit,
  ) async {
    // Emit state Loading untuk memberitahu UI bahwa proses dimulai
    emit(const WatchlistTvState.loading());

    // Eksekusi use case
    final result = await getWatchlistTv.execute();

    // Proses hasil dari use case menggunakan fold
    result.fold(
      // Jika gagal (Failure)
      (failure) {
        emit(WatchlistTvState.error(failure.message));
      },
      // Jika berhasil (Success)
      (tvData) {
        emit(WatchlistTvState.loaded(watchlistTv: tvData));
      },
    );
  }
}
