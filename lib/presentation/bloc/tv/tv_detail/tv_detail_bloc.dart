import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/failure.dart';
import '../../../../common/state_enum.dart';
import '../../../../domain/usecases/tv_series/get_tv_detail.dart';
import '../../../../domain/usecases/tv_series/get_tv_recommendations.dart';
import '../../../../domain/usecases/tv_series/get_watchlist_status_tv.dart';
import '../../../../domain/usecases/tv_series/remove_watchlist_tv.dart';
import '../../../../domain/usecases/tv_series/save_watchlist_tv.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

part 'tv_detail_bloc.freezed.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(Initial()) {
    on<FetchTvDetail>(_onFetchTvDetail);
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
  }

  Future<void> _onFetchTvDetail(
    FetchTvDetail event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(const TvDetailState.loading());

    // Mengambil semua data yang dibutuhkan secara bersamaan
    final results = await Future.wait([
      getTvDetail.execute(event.id),
      getTvRecommendations.execute(event.id),
      getWatchListStatus.execute(event.id),
    ]);

    final detailResult = results[0] as Either<Failure, TvDetail>;
    final recommendationResult = results[1] as Either<Failure, List<TvSeries>>;
    final watchlistStatusResult = results[2] as Either<Failure, bool>;

    detailResult.fold(
      (failure) {
        emit(TvDetailState.error(failure.message));
      },
      (tvDetail) {
        final isAdded = watchlistStatusResult.getOrElse(() => false);

        recommendationResult.fold(
          (failure) {
            // Jika rekomendasi gagal, tetap tampilkan detail
            emit(
              TvDetailState.loaded(
                tvDetail: tvDetail,
                tvRecommendations: [],
                recommendationState: RequestState.Error,
                isAddedToWatchlist: isAdded,
              ),
            );
          },
          (recommendations) {
            emit(
              TvDetailState.loaded(
                tvDetail: tvDetail,
                tvRecommendations: recommendations,
                recommendationState: RequestState.Loaded,
                isAddedToWatchlist: isAdded,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onAddToWatchlist(
    AddToWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    // Hanya bisa dijalankan jika state saat ini adalah Loaded
    if (state is Loaded) {
      final currentState = state as Loaded;
      final result = await saveWatchlist.execute(event.tvDetail);

      final newStatus = await getWatchListStatus.execute(event.tvDetail.id!);

      result.fold(
        (failure) {
          emit(currentState.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(
            currentState.copyWith(
              watchlistMessage: successMessage,
              isAddedToWatchlist: newStatus.getOrElse(() => true),
            ),
          );
        },
      );
    }
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      final result = await removeWatchlist.execute(event.tvDetail);

      final newStatus = await getWatchListStatus.execute(event.tvDetail.id!);

      result.fold(
        (failure) {
          emit(currentState.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(
            currentState.copyWith(
              watchlistMessage: successMessage,
              isAddedToWatchlist: newStatus.getOrElse(() => false),
            ),
          );
        },
      );
    }
  }
}
