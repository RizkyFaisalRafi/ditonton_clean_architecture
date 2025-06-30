import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([GetWatchlistTv])
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
    expect(watchlistTvBloc.state, InitialWatchlistTv());
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
            const WatchlistTvState.loadingWatchlistTv(),
            WatchlistTvState.loadedWatchlistTv(watchlistTv: testTvList),
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
            const WatchlistTvState.loadingWatchlistTv(),
            const WatchlistTvState.errorWatchlistTv('Server Failure'),
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );
  });
}
