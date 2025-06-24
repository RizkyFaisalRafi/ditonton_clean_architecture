import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_top_rated_tv.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/see_more_top_rated/see_more_top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'see_more_top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
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
    expect(seeMoreTopRatedTvBloc.state, SeeMoreTopRatedTvState.initial());
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
          const SeeMoreTopRatedTvState.loading(),
          SeeMoreTopRatedTvState.loaded(
            topRatedTv: testTvList,
            topRatedTvPage: 2,
            hasMoreTopRatedTv: true,
          ),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv(),
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
          const SeeMoreTopRatedTvState.loading(),
          const SeeMoreTopRatedTvState.error('Server Failure'),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv(),
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
          const SeeMoreTopRatedTvState.loading(),
          SeeMoreTopRatedTvState.loaded(
            topRatedTv: testTvList,
            topRatedTvPage: 2,
            hasMoreTopRatedTv: true,
          ),
          SeeMoreTopRatedTvState.loaded(
            topRatedTv: [...testTvList, ...testTvList],
            topRatedTvPage: 3,
            hasMoreTopRatedTv: true,
          ),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        // First, get the initial data to put the BLoC into a Loaded state
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv(),
        );
        // Then, trigger the fetch more event
        await Future.delayed(
          Duration.zero,
        ); // allow the first event to be processed
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchMoreTopRatedTv(),
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
          const SeeMoreTopRatedTvState.loading(),
          SeeMoreTopRatedTvState.loaded(
            topRatedTv: testTvList,
            topRatedTvPage: 2,
            hasMoreTopRatedTv: true,
          ),
          SeeMoreTopRatedTvState.loaded(
            topRatedTv: testTvList,
            topRatedTvPage: 3,
            hasMoreTopRatedTv: false,
          ),
        ];
        expectLater(seeMoreTopRatedTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv(),
        );
        await Future.delayed(Duration.zero);
        seeMoreTopRatedTvBloc.add(
          const SeeMoreTopRatedTvEvent.fetchMoreTopRatedTv(),
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
        const SeeMoreTopRatedTvEvent.fetchInitialTopRatedTv(),
      );
      await seeMoreTopRatedTvBloc.stream.firstWhere(
        (state) => state is Loaded,
      ); // Wait until loaded
      seeMoreTopRatedTvBloc.add(
        const SeeMoreTopRatedTvEvent.fetchMoreTopRatedTv(),
      );
      await seeMoreTopRatedTvBloc.stream.firstWhere(
        (state) => (state as Loaded).hasMoreTopRatedTv == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMoreTopRatedTv: false. Try to fetch again.
      seeMoreTopRatedTvBloc.add(
        const SeeMoreTopRatedTvEvent.fetchMoreTopRatedTv(),
      );

      // Assert
      // verify that execute(3) was never called.
      verifyNever(mockGetTopRatedTv.execute(3));
    });
  });
}
