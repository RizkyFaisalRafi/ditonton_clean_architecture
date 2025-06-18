import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/entities/tv/tv_series.dart';

part 'top_rated_tv_event.dart';

part 'top_rated_tv_state.dart';

part 'top_rated_tv_bloc.freezed.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc({required this.getTopRatedTv}) : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialTvS>(_onFetchInitialTvS);

    // For Refresh
    on<RefreshTv>(_onRefreshTv);

    // Gunakan `droppable()` untuk mencegah request ganda saat user scroll cepat
    on<FetchMoreTopRatedTv>(_onFetchMoreTopRatedTv, transformer: droppable());
  }

  Future<void> _onFetchInitialTvS(
    FetchInitialTvS event,
    Emitter<TopRatedTvState> emit,
  ) async {
    emit(const TopRatedTvState.loading());

    // Fetch kategori secara paralel
    final results = await Future.wait([getTopRatedTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(TopRatedTvState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      TopRatedTvState.loaded(
        topRated: results[0].getOrElse(() => []),
        topRatedPage: 2,
        hasMoreTopRated: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshTv event,
    Emitter<TopRatedTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialTvS());
  }

  Future<void> _onFetchMoreTopRatedTv(
    FetchMoreTopRatedTv event,
    Emitter<TopRatedTvState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      if (!currentState.hasMoreTopRated) return;

      final result = await getTopRatedTv.execute(currentState.topRatedPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newTvS) {
          emit(
            currentState.copyWith(
              topRated: List.of(currentState.topRated)..addAll(newTvS),
              topRatedPage: currentState.topRatedPage + 1,
              hasMoreTopRated: newTvS.isNotEmpty,
            ),
          );
        },
      );
    }
  }
}
