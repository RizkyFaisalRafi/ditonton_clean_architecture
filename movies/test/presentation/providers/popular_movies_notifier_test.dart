import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/module/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper_movie.mocks.dart';

// @GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularMovies = MockGetPopularMovies();
    notifier = PopularMoviesNotifier(getPopularMovies: mockGetPopularMovies)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(
      mockGetPopularMovies.execute(1),
    ).thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchPopularMovies();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 1);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(
      mockGetPopularMovies.execute(1),
    ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularMovies();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 1);
  });
}
