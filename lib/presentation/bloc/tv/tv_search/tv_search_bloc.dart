import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/search_tv_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

part 'tv_search_bloc.freezed.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvSeries searchTvSeries;

  TvSearchBloc({required this.searchTvSeries}) : super(SearchEmpty()) {

    on<OnQueryChangedTv>(
      _onQueryChangedTv,
      // membatalkan proses sebelumnya jika ada event baru yang masuk. Ini perilaku paling efisien.
      transformer: restartable(), // From bloc_concurrency
    );
  }

  // Handler utama untuk event OnQueryChanged
  Future<void> _onQueryChangedTv(
      OnQueryChangedTv event,
      Emitter<TvSearchState> emit,
      ) async {
    final query = event.query;

    // --- LOGIKA VALIDASI ---
    // 1. Jika query kosong setelah di-trim, kembalikan ke state Empty.
    if (query.trim().isEmpty) {
      emit(const TvSearchState.searchEmpty());
      return;
    }
    // 2. Jika query mengandung karakter tidak valid, emit state Error.
    if (RegExp(r'[!@#$%^&*(),.?"{}|<>]').hasMatch(query)) {
      emit(
        const TvSearchState.searchError('Query contains invalid characters'),
      );
      return;
    }
    // --- AKHIR LOGIKA VALIDASI ---

    // Jika validasi lolos, emit state Loading
    emit(const TvSearchState.searchLoading());

    final result = await searchTvSeries.execute(query);

    result.fold(
          (failure) {
        // Jika gagal, emit state Error dengan pesan dari failure
        emit(TvSearchState.searchError(failure.message));
      },
          (data) {
        // Jika berhasil, emit state HasData dengan hasil pencarian
        // UI akan menampilkan data atau pesan "Not Found" jika list kosong.
        emit(TvSearchState.searchHasData(data));
      },
    );
  }

}
