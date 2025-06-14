import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_airing_today_tv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'airing_today_tv_event.dart';

part 'airing_today_tv_state.dart';

part 'airing_today_tv_bloc.freezed.dart';

class AiringTodayTvBloc extends Bloc<AiringTodayTvEvent, AiringTodayTvState> {
  final GetAiringTodayTv getAiringTodayTv;

  AiringTodayTvBloc({required this.getAiringTodayTv}) : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialTvS>(_onFetchInitialTvS);

    // For Refresh
    on<RefreshTv>(_onRefreshTv);

    // Gunakan `droppable()` untuk mencegah request ganda saat user scroll cepat
    on<FetchMoreAiringTodayTv>(
      _onFetchMoreAiringTodayTv,
      transformer: droppable(),
    );
  }

  Future<void> _onFetchInitialTvS(
    FetchInitialTvS event,
    Emitter<AiringTodayTvState> emit,
  ) async {
    emit(const AiringTodayTvState.loading());

    // Fetch kategori secara paralel
    final results = await Future.wait([getAiringTodayTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(AiringTodayTvState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      AiringTodayTvState.loaded(
        airingToday: results[0].getOrElse(() => []),
        airingTodayPage: 2,
        hasMoreAiringToday: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshTv event,
    Emitter<AiringTodayTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialTvS());
  }

  Future<void> _onFetchMoreAiringTodayTv(
    FetchMoreAiringTodayTv event,
    Emitter<AiringTodayTvState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      if (!currentState.hasMoreAiringToday) return;

      final result = await getAiringTodayTv.execute(
        currentState.airingTodayPage,
      );
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newTvS) {
          emit(
            currentState.copyWith(
              airingToday: List.of(currentState.airingToday)..addAll(newTvS),
              airingTodayPage: currentState.airingTodayPage + 1,
              hasMoreAiringToday: newTvS.isNotEmpty,
            ),
          );
        },
      );
    }
  }
}
