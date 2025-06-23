import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_watchlist_tv.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    // Inisialisasi mock class dari file .mocks.dart
    mockGetWatchlistTv = MockGetWatchlistTv();
    watchlistTvBloc = WatchlistTvBloc(getWatchlistTv: mockGetWatchlistTv);
  });

  /// Initial State
  test('initial state should be Initial', () {
    expect(watchlistTvBloc.state, Initial());
  });

  group('Get Watchlist Tv', () {
    /// Loading - Loaded Success
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Loaded] when data is gotten successfully',
      setUp: () {
        when(
          mockGetWatchlistTv.execute(),
        ).thenAnswer((_) async => Right(testTvList));
      },
      build: () => watchlistTvBloc,
      act: (bloc) => bloc.add(const WatchlistTvEvent.fetchInitialWatchlistTv()),
      expect:
          () => <WatchlistTvState>[
            const WatchlistTvState.loading(),
            WatchlistTvState.loaded(watchlistTv: testTvList),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    /// Loading - Error Unsuccessfully
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get watchlist is unsuccessful',
      setUp: () {
        when(
          mockGetWatchlistTv.execute(),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      },
      build: () => watchlistTvBloc,
      act: (bloc) => bloc.add(const WatchlistTvEvent.fetchInitialWatchlistTv()),
      expect:
          () => <WatchlistTvState>[
            const WatchlistTvState.loading(),
            const WatchlistTvState.error('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );
  });
}
