import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_tv_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_status_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/remove_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/save_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchListStatusTv,
      saveWatchlist: mockSaveWatchlistTv,
      removeWatchlist: mockRemoveWatchlistTv,
    );
  });

  const tId = 1;

  group('FetchTvDetail', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(
          mockGetTvDetail.execute(tId),
        ).thenAnswer((_) async => Right(testTvDetail));
        when(
          mockGetTvRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(testTvList));
        when(
          mockGetWatchListStatusTv.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const TvDetailEvent.fetchTvDetail(tId)),
      expect:
          () => [
            const TvDetailState.loading(),
            TvDetailState.loaded(
              tvDetail: testTvDetail,
              tvRecommendations: testTvList,
              recommendationState: RequestState.Loaded,
              isAddedToWatchlist: true,
            ),
          ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
        verify(mockGetWatchListStatusTv.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, Error] when get tv detail is unsuccessful',
      build: () {
        when(
          mockGetTvDetail.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetTvRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(testTvList));
        when(
          mockGetWatchListStatusTv.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const TvDetailEvent.fetchTvDetail(tId)),
      expect:
          () => [
            const TvDetailState.loading(),
            const TvDetailState.error('Server Failure'),
          ],
      verify: (_) => verify(mockGetTvDetail.execute(tId)),
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, Loaded] with recommendation error when recommendation fetch fails',
      build: () {
        when(
          mockGetTvDetail.execute(tId),
        ).thenAnswer((_) async => Right(testTvDetail));
        when(
          mockGetTvRecommendations.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetWatchListStatusTv.execute(tId),
        ).thenAnswer((_) async => const Right(false));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const TvDetailEvent.fetchTvDetail(tId)),
      expect:
          () => [
            const TvDetailState.loading(),
            TvDetailState.loaded(
              tvDetail: testTvDetail,
              tvRecommendations: [],
              recommendationState: RequestState.Error,
              isAddedToWatchlist: false,
            ),
          ],
    );
  });

  group('AddToWatchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit Loaded with success message when added successfully',
      build: () {
        when(
          mockSaveWatchlistTv.execute(testTvDetail),
        ).thenAnswer((_) async => const Right('Added to Watchlist'));
        when(
          mockGetWatchListStatusTv.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return tvDetailBloc;
      },
      // Seed state diperlukan karena event ini hanya berjalan jika state sudah Loaded
      seed:
          () => TvDetailState.loaded(
            tvDetail: testTvDetail,
            tvRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: false,
          ),
      act: (bloc) => bloc.add(TvDetailEvent.addToWatchlist(testTvDetail)),
      expect:
          () => [
            TvDetailState.loaded(
              tvDetail: testTvDetail,
              tvRecommendations: [],
              recommendationState: RequestState.Loaded,
              isAddedToWatchlist: true,
              watchlistMessage: 'Added to Watchlist',
            ),
          ],
      verify: (_) => verify(mockSaveWatchlistTv.execute(testTvDetail)),
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit Loaded with failure message when added unsuccessfully',
      build: () {
        when(
          mockSaveWatchlistTv.execute(testTvDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(
          mockGetWatchListStatusTv.execute(tId),
        ).thenAnswer((_) async => const Right(false));
        return tvDetailBloc;
      },
      seed:
          () => TvDetailState.loaded(
            tvDetail: testTvDetail,
            tvRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: false,
          ),
      act: (bloc) => bloc.add(TvDetailEvent.addToWatchlist(testTvDetail)),
      expect:
          () => [
            TvDetailState.loaded(
              tvDetail: testTvDetail,
              tvRecommendations: [],
              recommendationState: RequestState.Loaded,
              isAddedToWatchlist: false,
              watchlistMessage: 'Database Failure',
            ),
          ],
    );
  });

  group('RemoveFromWatchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit Loaded with success message when removed successfully',
      build: () {
        when(
          mockRemoveWatchlistTv.execute(testTvDetail),
        ).thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(
          mockGetWatchListStatusTv.execute(tId),
        ).thenAnswer((_) async => const Right(false));
        return tvDetailBloc;
      },
      seed:
          () => TvDetailState.loaded(
            tvDetail: testTvDetail,
            tvRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: true,
          ),
      act: (bloc) => bloc.add(TvDetailEvent.removeFromWatchlist(testTvDetail)),
      expect:
          () => [
            TvDetailState.loaded(
              tvDetail: testTvDetail,
              tvRecommendations: [],
              recommendationState: RequestState.Loaded,
              isAddedToWatchlist: false,
              watchlistMessage: 'Removed from Watchlist',
            ),
          ],
      verify: (_) => verify(mockRemoveWatchlistTv.execute(testTvDetail)),
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'should emit Loaded with failure message when removed unsuccessfully',
      build: () {
        when(
          mockRemoveWatchlistTv.execute(testTvDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(
          mockGetWatchListStatusTv.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return tvDetailBloc;
      },
      seed:
          () => TvDetailState.loaded(
            tvDetail: testTvDetail,
            tvRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: true,
          ),
      act: (bloc) => bloc.add(TvDetailEvent.removeFromWatchlist(testTvDetail)),
      expect:
          () => [
            TvDetailState.loaded(
              tvDetail: testTvDetail,
              tvRecommendations: [],
              recommendationState: RequestState.Loaded,
              isAddedToWatchlist: true,
              watchlistMessage: 'Database Failure',
            ),
          ],
    );
  });
}
