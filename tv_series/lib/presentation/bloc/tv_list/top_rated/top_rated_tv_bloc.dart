import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../domain/usecases/get_top_rated_tv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tv_series.dart';

part 'top_rated_tv_event.dart';

part 'top_rated_tv_state.dart';

part 'top_rated_tv_bloc.freezed.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc({required this.getTopRatedTv}) : super(InitialTrTv()) {
    // Fetch untuk pertama kali
    on<FetchInitialTopRatedTv>(_onFetchInitialTvS);

    // For Refresh
    on<RefreshTvTr>(_onRefreshTv);

    // Gunakan `droppable()` untuk mencegah request ganda saat user scroll cepat
    on<FetchMoreTopRatedTv>(_onFetchMoreTopRatedTv, transformer: droppable());
  }

  Future<void> _onFetchInitialTvS(
    FetchInitialTopRatedTv event,
    Emitter<TopRatedTvState> emit,
  ) async {
    emit(const TopRatedTvState.loadingTrTv());

    // Fetch kategori secara paralel
    final results = await Future.wait([getTopRatedTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(TopRatedTvState.errorTrTv(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      TopRatedTvState.loadedTrTv(
        topRated: results[0].getOrElse(() => []),
        topRatedPage: 2,
        hasMoreTopRated: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshTvTr event,
    Emitter<TopRatedTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialTopRatedTv());
  }

  Future<void> _onFetchMoreTopRatedTv(
    FetchMoreTopRatedTv event,
    Emitter<TopRatedTvState> emit,
  ) async {
    if (state is LoadedTrTv) {
      final currentState = state as LoadedTrTv;
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
