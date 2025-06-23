import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/get_on_the_air_tv.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/see_more_on_the_air/see_more_on_the_air_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'see_more_on_the_air_tv_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirTv])
void main() {
  late SeeMoreOnTheAirTvBloc seeMoreOnTheAirTvBloc;
  late MockGetOnTheAirTv mockGetOnTheAirTv;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    seeMoreOnTheAirTvBloc = SeeMoreOnTheAirTvBloc(
      getOnTheAirTv: mockGetOnTheAirTv,
    );
  });

  tearDown(() {
    seeMoreOnTheAirTvBloc.close();
  });

  test('initial state should be Initial', () {
    expect(seeMoreOnTheAirTvBloc.state, const SeeMoreOnTheAirTvState.initial());
  });

  group('FetchInitialOnTheAirTv', () {
    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // Arrange
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));

        // Assert
        // We expect the BLoC to emit Loading, then Loaded.
        final expected = [
          const SeeMoreOnTheAirTvState.loading(),
          SeeMoreOnTheAirTvState.loaded(
            onTheAir: testTvList,
            onTheAirPage: 2,
            hasMoreOnTheAir: true,
          ),
        ];
        expectLater(seeMoreOnTheAirTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreOnTheAirTvBloc.add(
          const SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirTv(),
        );
      },
    );

    test(
      'should emit [Loading, Error] when get top rated movies is unsuccessful',
      () async {
        // Arrange
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        // Assert
        final expected = [
          const SeeMoreOnTheAirTvState.loading(),
          const SeeMoreOnTheAirTvState.error('Server Failure'),
        ];
        expectLater(seeMoreOnTheAirTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreOnTheAirTvBloc.add(
          const SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirTv(),
        );
      },
    );
  });

  group('FetchMoreOnTheAirTv', () {
    test(
      'should emit new Loaded state with more data when successful',
      () async {
        // Arrange
        // Mock for the initial fetch
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));
        // Mock for the "load more" fetch
        when(
          mockGetOnTheAirTv.execute(2),
        ).thenAnswer((_) async => Right(testTvList));

        // Assert
        final expected = [
          const SeeMoreOnTheAirTvState.loading(),
          SeeMoreOnTheAirTvState.loaded(
            onTheAir: testTvList,
            onTheAirPage: 2,
            hasMoreOnTheAir: true,
          ),
          SeeMoreOnTheAirTvState.loaded(
            onTheAir: [...testTvList, ...testTvList],
            onTheAirPage: 3,
            hasMoreOnTheAir: true,
          ),
        ];
        expectLater(seeMoreOnTheAirTvBloc.stream, emitsInOrder(expected));

        // Act
        // First, get the initial data to put the BLoC into a Loaded state
        seeMoreOnTheAirTvBloc.add(
          const SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirTv(),
        );
        // Then, trigger the fetch more event
        await Future.delayed(
          Duration.zero,
        ); // allow the first event to be processed
        seeMoreOnTheAirTvBloc.add(
          const SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirTv(),
        );
      },
    );

    test(
      'should emit Loaded with hasMoreOnTheAir false when no more data',
      () async {
        // Arrange
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => Right(testTvList));
        when(
          mockGetOnTheAirTv.execute(2),
        ).thenAnswer((_) async => const Right([])); // Return empty list

        // Assert
        final expected = [
          const SeeMoreOnTheAirTvState.loading(),
          SeeMoreOnTheAirTvState.loaded(
            onTheAir: testTvList,
            onTheAirPage: 2,
            hasMoreOnTheAir: true,
          ),
          SeeMoreOnTheAirTvState.loaded(
            onTheAir: testTvList,
            onTheAirPage: 3,
            hasMoreOnTheAir: false,
          ),
        ];
        expectLater(seeMoreOnTheAirTvBloc.stream, emitsInOrder(expected));

        // Act
        seeMoreOnTheAirTvBloc.add(
          const SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirTv(),
        );
        await Future.delayed(Duration.zero);
        seeMoreOnTheAirTvBloc.add(
          const SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirTv(),
        );
      },
    );

    test('should not call usecase when hasMoreOnTheAir is false', () async {
      // Arrange
      when(
        mockGetOnTheAirTv.execute(1),
      ).thenAnswer((_) async => Right(testTvList));
      when(
        mockGetOnTheAirTv.execute(2),
      ).thenAnswer((_) async => Right([])); // Page 2 has no data

      // Act
      // Load initial data, then load more (which will return empty)
      seeMoreOnTheAirTvBloc.add(
        const SeeMoreOnTheAirTvEvent.fetchInitialOnTheAirTv(),
      );
      await seeMoreOnTheAirTvBloc.stream.firstWhere(
        (state) => state is Loaded,
      ); // Wait until loaded
      seeMoreOnTheAirTvBloc.add(
        const SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirTv(),
      );
      await seeMoreOnTheAirTvBloc.stream.firstWhere(
        (state) => (state as Loaded).hasMoreOnTheAir == false,
      ); // Wait until hasMore is false

      // Now the state is Loaded with hasMoreOnTheAir: false. Try to fetch again.
      seeMoreOnTheAirTvBloc.add(
        const SeeMoreOnTheAirTvEvent.fetchMoreOnTheAirTv(),
      );

      // Assert
      // verify that execute(3) was never called.
      verifyNever(mockGetOnTheAirTv.execute(3));
    });
  });
}
