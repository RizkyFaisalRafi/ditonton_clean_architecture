import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../helpers/test_helper_movie.mocks.dart';

// @GenerateMocks([UpComingMoviesNotifier])
void main() {
  late MockGetUpComingMovies mockGetUpComingMovies;
  late UpComingMoviesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetUpComingMovies = MockGetUpComingMovies();
    notifier = UpComingMoviesNotifier(getUpComingMovies: mockGetUpComingMovies)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: "/jRvhP4AfFnJ03lCQhp1fie7XPSd.jpg",
    genreIds: [28, 53],
    id: 977294,
    originalTitle: "Tin Soldier",
    overview:
        "An ex-special forces operative seeks revenge against a cult leader who has corrupted his former comrades, the Shinjas. This leader, known as The Bokushi, promises veterans a purpose and protection, but is revealed to be a destructive influence. The ex-soldier, Nash Cavanaugh, joins forces with military operative Emmanuel Ashburn to infiltrate the Bokushi's fortress and expose his reign of terror",
    popularity: 377.063,
    posterPath: "/lFFDrFLXywFhy6khHes1LCFVMsL.jpg",
    releaseDate: "2025-05-22",
    title: "Tin Soldier",
    video: false,
    voteAverage: 5.333,
    voteCount: 9,
  );

  final tMovieList = <Movie>[tMovie];

  test('should change movies data when data is gotten successfully', () async {
    // Arrange
    when(
      mockGetUpComingMovies.execute(1),
    ).thenAnswer((_) async => Right(tMovieList));
    // Act
    await notifier.fetchUpComingMovies();
    // Assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 1);
  });

  test('should return error when data is unsuccessful', () async {
    // Arrange
    when(
      mockGetUpComingMovies.execute(1),
    ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // Act
    await notifier.fetchUpComingMovies();
    // Assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 1);
  });
}
