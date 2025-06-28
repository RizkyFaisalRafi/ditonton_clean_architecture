import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../domain/entities/tv_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/usecases/get_on_the_air_tv.dart';

part 'on_the_air_tv_event.dart';

part 'on_the_air_tv_state.dart';

part 'on_the_air_tv_bloc.freezed.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTv getOnTheAirTv;

  OnTheAirTvBloc({required this.getOnTheAirTv}) : super(InitialOtaTv()) {
    // Fetch untuk pertama kali
    on<FetchInitialOnTheAir>(_onFetchInitialOnTheAir);
    // For Refresh
    on<RefreshTvOta>(_onRefreshTvOTA);
    // Gunakan `droppable()` untuk mencegah request ganda saat user scroll cepat
    on<FetchMoreOnTheAirTv>(_onFetchMoreOnTheAirTv, transformer: droppable());
  }

  Future<void> _onFetchInitialOnTheAir(
    FetchInitialOnTheAir event,
    Emitter<OnTheAirTvState> emit,
  ) async {
    emit(const OnTheAirTvState.loadingOtaTv());
    // Fetch kategori secara paralel
    final results = await Future.wait([getOnTheAirTv.execute(1)]);
    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(OnTheAirTvState.errorOtaTv(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      OnTheAirTvState.loadedOtaTv(
        onTheAir: results[0].getOrElse(() => []),
        onTheAirPage: 2,
        hasMoreOnTheAir: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTvOTA(
    RefreshTvOta event,
    Emitter<OnTheAirTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialOnTheAir());
  }

  Future<void> _onFetchMoreOnTheAirTv(
    FetchMoreOnTheAirTv event,
    Emitter<OnTheAirTvState> emit,
  ) async {
    if (state is LoadedOtaTv) {
      final currentState = state as LoadedOtaTv;
      if (!currentState.hasMoreOnTheAir) return;
      final result = await getOnTheAirTv.execute(currentState.onTheAirPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newTvS) {
          emit(
            currentState.copyWith(
              onTheAir: List.of(currentState.onTheAir)..addAll(newTvS),
              onTheAirPage: currentState.onTheAirPage + 1,
              hasMoreOnTheAir: newTvS.isNotEmpty,
            ),
          );
        },
      );
    }
  }
}
