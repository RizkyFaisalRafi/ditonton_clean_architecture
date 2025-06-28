import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../domain/usecases/get_popular_tv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/tv_series.dart';

part 'popular_tv_event.dart';

part 'popular_tv_state.dart';

part 'popular_tv_bloc.freezed.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc({required this.getPopularTv}) : super(InitialPopularTv()) {
    // Fetch untuk pertama kali
    on<FetchInitialPopularTv>(_onFetchInitialTvS);

    // For Refresh
    on<RefreshPTv>(_onRefreshTv);

    // Gunakan `droppable()` untuk mencegah request ganda saat user scroll cepat
    on<FetchMorePopularTv>(_onFetchMorePopularTv, transformer: droppable());
  }

  Future<void> _onFetchInitialTvS(
    FetchInitialPopularTv event,
    Emitter<PopularTvState> emit,
  ) async {
    emit(const PopularTvState.loadingPopularTv());

    // Fetch kategori secara paralel
    final results = await Future.wait([getPopularTv.execute(1)]);

    // Cek jika ada kegagalan di salah satu request
    final anyFailure = results.indexWhere((res) => res.isLeft());
    if (anyFailure != -1) {
      results[anyFailure].fold(
        (failure) => emit(PopularTvState.errorPopularTv(failure.message)),
        (_) {},
      );
      return;
    }

    // Jika semua berhasil, emit state Loaded
    emit(
      PopularTvState.loadedPopularTv(
        popular: results[0].getOrElse(() => []),
        popularPage: 2,
        hasMorePopular: results[0].getOrElse(() => []).isNotEmpty,
      ),
    );
  }

  Future<void> _onRefreshTv(
    RefreshPTv event,
    Emitter<PopularTvState> emit,
  ) async {
    // Cukup panggil event untuk fetch awal lagi
    add(const FetchInitialPopularTv());
  }

  Future<void> _onFetchMorePopularTv(
    FetchMorePopularTv event,
    Emitter<PopularTvState> emit,
  ) async {
    if (state is LoadedPopularTv) {
      final currentState = state as LoadedPopularTv;
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
