import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([GetPopularTv])
void main() {
  late SeeMorePopularTvBloc seeMorePopularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    seeMorePopularTvBloc = SeeMorePopularTvBloc(getPopularTv: mockGetPopularTv);
  });

  tearDown(() {
    seeMorePopularTvBloc.close();
  });

  test('initial state should be Initial', () {
    expect(
      seeMorePopularTvBloc.state,
      SeeMorePopularTvState.initialPopularTSeeMore(),
    );
  });

  group('FetchInitialPopularTv', () {
    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // Arrange
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));

        // Assert
        // We expect the BLoC to emit Loading, then Loaded.
        final expected = [
          const SeeMorePopularTvState.loadingPopularTSeeMore(),
          SeeMorePopularTvState.loadedPopularTSeeMore(
            popularTv: testTvList,
            popularTvPage: 2,
            hasMorePopularTv: true,
          ),
        ];
        expectLater(seeMorePopularTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMorePopularTvBloc.add(
          const SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv(),
        );
      },
    );

    test(
      'should emit [Loading, Error] when get top rated movies is unsuccessful',
      () async {
        // Arrange
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // Assert
        final expected = [
          const SeeMorePopularTvState.loadingPopularTSeeMore(),
          const SeeMorePopularTvState.errorPopularTSeeMore('Server Failure'),
        ];
        expectLater(seeMorePopularTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMorePopularTvBloc.add(
          const SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv(),
        );
      },
    );
  });

  group('FetchMorePopularTv', () {
    test(
      'should emit new Loaded state with more data when successful',
      () async {
        // Arrange
        // Mock for the initial fetch
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));
        // Mock for the "load more" fetch
        when(
          mockGetPopularTv.execute(2),
        ).thenAnswer((_) async => Right(testTvList));

        // Assert
        final expected = [
          const SeeMorePopularTvState.loadingPopularTSeeMore(),
          SeeMorePopularTvState.loadedPopularTSeeMore(
            popularTv: testTvList,
            popularTvPage: 2,
            hasMorePopularTv: true,
          ),
          SeeMorePopularTvState.loadedPopularTSeeMore(
            popularTv: [...testTvList, ...testTvList],
            popularTvPage: 3,
            hasMorePopularTv: true,
          ),
        ];
        expectLater(seeMorePopularTvBloc.stream, emitsInOrder(expected));

        // Act
        // First, get the initial data to put the BLoC into a Loaded state
        seeMorePopularTvBloc.add(
          const SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv(),
        );
        // Then, trigger the fetch more event
        await Future.delayed(
          Duration.zero,
        ); // allow the first event to be processed
        seeMorePopularTvBloc.add(
          const SeeMorePopularTvEvent.fetchMorePopularSeeMoreTv(),
        );
      },
    );

    test(
      'should emit Loaded with hasMorePopularTv false when no more data',
      () async {
        // Arrange
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));
        when(
          mockGetPopularTv.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return empty list

        // Assert
        final expected = [
          const SeeMorePopularTvState.loadingPopularTSeeMore(),
          SeeMorePopularTvState.loadedPopularTSeeMore(
            popularTv: testTvList,
            popularTvPage: 2,
            hasMorePopularTv: true,
          ),
          SeeMorePopularTvState.loadedPopularTSeeMore(
            popularTv: testTvList,
            popularTvPage: 3,
            hasMorePopularTv: false,
          ),
        ];
        expectLater(seeMorePopularTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMorePopularTvBloc.add(
          const SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv(),
        );
        await Future.delayed(Duration.zero);
        seeMorePopularTvBloc.add(
          const SeeMorePopularTvEvent.fetchMorePopularSeeMoreTv(),
        );
      },
    );

    test('should not call usecase when hasMorePopularTv is false', () async {
      // Arrange
      when(
        mockGetPopularTv.execute(1),
      ).thenAnswer((_) async => Right(testTvList));
      when(
        mockGetPopularTv.execute(2),
      ).thenAnswer((_) async => Right([])); // Page 2 has no data

      // Act
      // Load initial data, then load more (which will return empty)
      seeMorePopularTvBloc.add(
        const SeeMorePopularTvEvent.fetchInitialPopularSeeMoreTv(),
      );
      await seeMorePopularTvBloc.stream.firstWhere(
        (state) => state is LoadedPopularTSeeMore,
      ); // Wait until loaded
      seeMorePopularTvBloc.add(
        const SeeMorePopularTvEvent.fetchMorePopularSeeMoreTv(),
      );
      await seeMorePopularTvBloc.stream.firstWhere(
        (state) => (state as LoadedPopularTSeeMore).hasMorePopularTv == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMorePopularTv: false. Try to fetch again.
      seeMorePopularTvBloc.add(
        const SeeMorePopularTvEvent.fetchMorePopularSeeMoreTv(),
      );

      // Assert
      // verify that execute(3) was never called.
      verifyNever(mockGetPopularTv.execute(3));
    });
  });
}
