import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/movie.dart';
import 'package:ditonton_clean_architecture/presentation/provider/up_coming_movies_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks([UpComingMoviesNotifier])
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

  test('should change state to loading when usecase is called', () async {
    // Arrange
    when(
      mockGetUpComingMovies.execute(),
    ).thenAnswer((_) async => Right(tMovieList));

    // Act
    notifier.fetchUpComingMovies();

    // Assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // Arrange
    when(
      mockGetUpComingMovies.execute(),
    ).thenAnswer((_) async => Right(tMovieList));
    // Act
    await notifier.fetchUpComingMovies();
    // Assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // Arrange
    when(
      mockGetUpComingMovies.execute(),
    ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // Act
    await notifier.fetchUpComingMovies();
    // Assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
