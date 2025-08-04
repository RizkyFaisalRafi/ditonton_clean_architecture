import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/module/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/test_helper_movie.mocks.dart';

// @GenerateMocks([
//   GetNowPlayingMovies,
//   GetPopularMovies,
//   GetTopRatedMovies,
//   GetUpComingMovies,
// ])
void main() {
  late MovieListNotifier provider;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MockGetUpComingMovies mockGetUpComingMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetUpComingMovies = MockGetUpComingMovies();
    provider = MovieListNotifier(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
      getUpComingMovies: mockGetUpComingMovies,
      autoInit: false,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];
  const tPage = 1;

  group('Initial State', () {
    test('should have initial empty state', () {
      expect(provider.nowPlayingState, RequestState.empty);
      expect(provider.popularMoviesState, RequestState.empty);
      expect(provider.topRatedMoviesState, RequestState.empty);
      expect(provider.upComingMoviesState, RequestState.empty);
      expect(provider.nowPlayingMovies, isEmpty);
      expect(provider.popularMovies, isEmpty);
      expect(provider.topRatedMovies, isEmpty);
      expect(provider.upComingMovies, isEmpty);
    });
  });

  group('Now Playing Movie', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetNowPlayingMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));

      // act
      await provider.fetchNowPlayingMovies();

      // assert
      expect(provider.nowPlayingState, RequestState.loaded);
      expect(provider.nowPlayingMovies, tMovieList);
      expect(listenerCallCount, 1);
    });

    test('should update page when success', () async {
      // arrange
      when(
        mockGetNowPlayingMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));

      // act
      await provider.fetchNowPlayingMovies();

      // assert
      expect(provider.nowPlayingMovies.length, tMovieList.length);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetNowPlayingMovies.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchNowPlayingMovies();

      // assert
      expect(provider.nowPlayingState, RequestState.error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('Popular Movie', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetPopularMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));

      // act
      await provider.fetchPopularMovies();

      // assert
      expect(provider.popularMoviesState, RequestState.loaded);
      expect(provider.popularMovies, tMovieList);
      expect(listenerCallCount, 1);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetPopularMovies.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchPopularMovies();

      // assert
      expect(provider.popularMoviesState, RequestState.error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('Top Rated Movie', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetTopRatedMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));

      // act
      await provider.fetchTopRatedMovies();

      // assert
      expect(provider.topRatedMoviesState, RequestState.loaded);
      expect(provider.topRatedMovies, tMovieList);
      expect(listenerCallCount, 1);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetTopRatedMovies.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchTopRatedMovies();

      // assert
      expect(provider.topRatedMoviesState, RequestState.error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('Up Coming Movie', () {
    test('should update data when success', () async {
      // arrange
      when(
        mockGetUpComingMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));

      // act
      await provider.fetchUpComingMovies();

      // assert
      expect(provider.upComingMoviesState, RequestState.loaded);
      expect(provider.upComingMovies, tMovieList);
      expect(listenerCallCount, 1);
    });

    test('should handle error', () async {
      // arrange
      when(
        mockGetUpComingMovies.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.fetchUpComingMovies();

      // assert
      expect(provider.upComingMoviesState, RequestState.error);
      expect(provider.message, 'Error');
      expect(listenerCallCount, 1);
    });
  });

  group('Refresh', () {
    test('should reset all data when refreshed', () async {
      // arrange
      when(
        mockGetNowPlayingMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));
      when(
        mockGetPopularMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));
      when(
        mockGetTopRatedMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));
      when(
        mockGetUpComingMovies.execute(tPage),
      ).thenAnswer((_) async => Right(tMovieList));

      // act
      await provider.onRefresh();

      // assert
      expect(provider.nowPlayingState, RequestState.loaded);
      expect(provider.popularMoviesState, RequestState.loaded);
      expect(provider.topRatedMoviesState, RequestState.loaded);
      expect(provider.upComingMoviesState, RequestState.loaded);
      expect(provider.refreshC.isRefresh, false);
    });

    test('should handle refresh error', () async {
      // arrange
      when(
        mockGetNowPlayingMovies.execute(tPage),
      ).thenAnswer((_) async => Left(ServerFailure('Error')));

      // act
      await provider.onRefresh();

      // assert
      expect(provider.nowPlayingState, RequestState.error);
      expect(provider.refreshC.isRefresh, false);
    });
  });

  group('Load More', () {
    test('should load more now playing Movie', () async {
      // arrange
      final tTvSeries2 = <Movie>[testMovie, testMovie];

      // Stub untuk mencegah error unexpected call
      when(mockGetNowPlayingMovies.execute(1))
          .thenAnswer((_) async => Right(<Movie>[]));

      provider.nowPlayingMovies = tTvSeries2;
      provider.nowPlayingPage = 2;
      when(mockGetNowPlayingMovies.execute(2))
          .thenAnswer((_) async => Right(tTvSeries2));

      // act
      await provider.loadMoreMovieNowPlaying();

      // assert
      expect(provider.nowPlayingMovies.length, tMovieList.length * 2);
      verify(mockGetNowPlayingMovies.execute(2));
    });

    test('should not load more when fetching', () async {
      // arrange
      provider.isFetching = true;

      // act
      await provider.loadMoreMovieNowPlaying();

      // assert
      verifyNever(mockGetNowPlayingMovies.execute(any));
    });
  });
}
