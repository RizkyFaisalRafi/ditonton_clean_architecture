import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_popular_tv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../domain/entities/tv/tv_series.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';
part 'popular_tv_bloc.freezed.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc({required this.getPopularTv}) : super(Initial()) {
    // Fetch untuk pertama kali
    on<FetchInitialTvS>(_onFetchInitialTvS);

    // For Refresh
    on<RefreshTv>(_onRefreshTv);

    // Gunakan `droppable()` untuk mencegah request ganda saat user scroll cepat
    on<FetchMorePopularTv>(_onFetchMorePopularTv, transformer: droppable());
  }

  Future<void> _onFetchInitialTvS(
    FetchInitialTvS event,
    Emitter<PopularTvState> emit,
  ) async {
    emit(const PopularTvState.loading());

    // Fetch kategori secara paralel
    final results = await Future.wait([getPopularTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(PopularTvState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      PopularTvState.loaded(
        popular: results[0].getOrElse(() => []),
        popularPage: 2,
        hasMorePopular: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshTv event,
    Emitter<PopularTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialTvS());
  }

  Future<void> _onFetchMorePopularTv(
    FetchMorePopularTv event,
    Emitter<PopularTvState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      if (!currentState.hasMorePopular) return;

      final result = await getPopularTv.execute(currentState.popularPage);
      result.fold(
        (failure) => emit(currentState.copyWith(minorError: failure.message)),
        (newTvS) {
          emit(
            currentState.copyWith(
              popular: List.of(currentState.popular)..addAll(newTvS),
              popularPage: currentState.popularPage + 1,
              hasMorePopular: newTvS.isNotEmpty,
            ),
          );
        },
      );
    }
  }
}
