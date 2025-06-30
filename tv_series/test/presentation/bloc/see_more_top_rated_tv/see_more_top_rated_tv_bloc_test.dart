import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([GetTopRatedTv])
void main() {
  late SeeMoreTopRatedTvBloc seeMoreTopRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    seeMoreTopRatedTvBloc = SeeMoreTopRatedTvBloc(
      getTopRatedTv: mockGetTopRatedTv,
    );
  });
  tearDown(() {
    seeMoreTopRatedTvBloc.close();
  });

  test('initial state should be Initial', () {
    expect(
      seeMoreTopRatedTvBloc.state,
      SeeMoreTopRatedTvState.initialTopRatedTSeeMore(),
    );
  });

  group('FetchInitialTopRatedTv', () {
    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // Arrange
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));

        // Assert
        // We expect the BLoC to emit Loading, then Loaded.
        final expected = [
          const SeeMoreTopRatedTvState.loadingTopRatedTSeeMore(),
          SeeMoreTopRatedTvState.loadedTopRatedTSeeMore(
            topRatedTv: testTvList,
            topRatedTvPage: 2,
            hasMoreTopRatedTv: true,
          ),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedSeeMoreTv(),
        );
      },
    );

    test(
      'should emit [Loading, Error] when get top rated movies is unsuccessful',
      () async {
        // Arrange
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // Assert
        final expected = [
          const SeeMoreTopRatedTvState.loadingTopRatedTSeeMore(),
          const SeeMoreTopRatedTvState.errorTopRatedTSeeMore('Server Failure'),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedSeeMoreTv(),
        );
      },
    );
  });

  group('FetchMoreTopRatedTv', () {
    test(
      'should emit new Loaded state with more data when successful',
      () async {
        // Arrange
        // Mock for the initial fetch
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));
        // Mock for the "load more" fetch
        when(
          mockGetTopRatedTv.execute(2),
        ).thenAnswer((_) async => Right(testTvList));

        // Assert
        final expected = [
          const SeeMoreTopRatedTvState.loadingTopRatedTSeeMore(),
          SeeMoreTopRatedTvState.loadedTopRatedTSeeMore(
            topRatedTv: testTvList,
            topRatedTvPage: 2,
            hasMoreTopRatedTv: true,
          ),
          SeeMoreTopRatedTvState.loadedTopRatedTSeeMore(
            topRatedTv: [...testTvList, ...testTvList],
            topRatedTvPage: 3,
            hasMoreTopRatedTv: true,
          ),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        // First, get the initial data to put the BLoC into a Loaded state
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedSeeMoreTv(),
        );
        // Then, trigger the fetch more event
        await Future.delayed(
          Duration.zero,
        ); // allow the first event to be processed
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchMoreTopRatedSeeMoreTv(),
        );
      },
    );

    test(
      'should emit Loaded with hasMoreTopRatedTv false when no more data',
      () async {
        // Arrange
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));
        when(
          mockGetTopRatedTv.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return empty list

        // Assert
        final expected = [
          const SeeMoreTopRatedTvState.loadingTopRatedTSeeMore(),
          SeeMoreTopRatedTvState.loadedTopRatedTSeeMore(
            topRatedTv: testTvList,
            topRatedTvPage: 2,
            hasMoreTopRatedTv: true,
          ),
          SeeMoreTopRatedTvState.loadedTopRatedTSeeMore(
            topRatedTv: testTvList,
            topRatedTvPage: 3,
            hasMoreTopRatedTv: false,
          ),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedSeeMoreTv(),
        );
        await Future.delayed(Duration.zero);
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchMoreTopRatedSeeMoreTv(),
        );
      },
    );

    test('should not call usecase when hasMoreTopRatedTv is false', () async {
      // Arrange
      when(
        mockGetTopRatedTv.execute(1),
      ).thenAnswer((_) async => Right(testTvList));
      when(
        mockGetTopRatedTv.execute(2),
      ).thenAnswer((_) async => Right([])); // Page 2 has no data

      // Act
      // Load initial data, then load more (which will return empty)
      seeMoreTopRatedTvBloc.add(
        const SeeMoreTopRatedTvEvent.fetchInitialTopRatedSeeMoreTv(),
      );
      await seeMoreTopRatedTvBloc.stream.firstWhere(
        (state) => state is LoadedTopRatedTSeeMore,
      ); // Wait until loaded
      seeMoreTopRatedTvBloc.add(
        const SeeMoreTopRatedTvEvent.fetchMoreTopRatedSeeMoreTv(),
      );
      await seeMoreTopRatedTvBloc.stream.firstWhere(
        (state) => (state as LoadedTopRatedTSeeMore).hasMoreTopRatedTv == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMoreTopRatedTv: false. Try to fetch again.
      seeMoreTopRatedTvBloc.add(
        const SeeMoreTopRatedTvEvent.fetchMoreTopRatedSeeMoreTv(),
      );

      // Assert
      // verify that execute(3) was never called.
      verifyNever(mockGetTopRatedTv.execute(3));
    });
  });
}
