import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../../dummy_data/dummy_objects_movie.dart';
import '../../../helpers/test_helper_movie.mocks.dart';

void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
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
  final tMovies = <Movie>[tMovie];

  group('FetchMovieDetail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Right(testMovieDetail));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tMovies));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailEvent.fetchMovieDetail(tId)),
      expect:
          () => [
            const MovieDetailState.loadingMovieDetail(),
            MovieDetailState.loadedMovieDetail(
              movieDetail: testMovieDetail,
              movieRecommendations: tMovies,
              recommendationState: RequestState.loaded,
              isAddedToWatchlist: true,
            ),
          ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Error] when get movie detail is unsuccessful',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tMovies));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailEvent.fetchMovieDetail(tId)),
      expect:
          () => [
            const MovieDetailState.loadingMovieDetail(),
            const MovieDetailState.errorMovieDetail('Server Failure'),
          ],
      verify: (_) => verify(mockGetMovieDetail.execute(tId)),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [Loading, Loaded] with recommendation error when recommendation fetch fails',
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Right(testMovieDetail));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => const Right(false));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailEvent.fetchMovieDetail(tId)),
      expect:
          () => [
            const MovieDetailState.loadingMovieDetail(),
            MovieDetailState.loadedMovieDetail(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.error,
              isAddedToWatchlist: false,
            ),
          ],
    );
  });

  group('AddToWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit Loaded with success message when added successfully',
      build: () {
        when(
          mockSaveWatchlist.execute(testMovieDetail),
        ).thenAnswer((_) async => const Right('Added to Watchlist'));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return movieDetailBloc;
      },
      // Seed state diperlukan karena event ini hanya berjalan jika state sudah Loaded
      seed:
          () => MovieDetailState.loadedMovieDetail(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: false,
          ),
      act: (bloc) => bloc.add(MovieDetailEvent.addToWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loadedMovieDetail(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.loaded,
              isAddedToWatchlist: true,
              watchlistMessage: 'Added to Watchlist',
            ),
          ],
      verify: (_) => verify(mockSaveWatchlist.execute(testMovieDetail)),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit Loaded with failure message when added unsuccessfully',
      build: () {
        when(
          mockSaveWatchlist.execute(testMovieDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => const Right(false));
        return movieDetailBloc;
      },
      seed:
          () => MovieDetailState.loadedMovieDetail(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: false,
          ),
      act: (bloc) => bloc.add(MovieDetailEvent.addToWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loadedMovieDetail(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.loaded,
              isAddedToWatchlist: false,
              watchlistMessage: 'Database Failure',
            ),
          ],
    );
  });

  group('RemoveFromWatchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit Loaded with success message when removed successfully',
      build: () {
        when(
          mockRemoveWatchlist.execute(testMovieDetail),
        ).thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => const Right(false));
        return movieDetailBloc;
      },
      seed:
          () => MovieDetailState.loadedMovieDetail(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: true,
          ),
      act:
          (bloc) =>
              bloc.add(MovieDetailEvent.removeFromWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loadedMovieDetail(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.loaded,
              isAddedToWatchlist: false,
              watchlistMessage: 'Removed from Watchlist',
            ),
          ],
      verify: (_) => verify(mockRemoveWatchlist.execute(testMovieDetail)),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit Loaded with failure message when removed unsuccessfully',
      build: () {
        when(
          mockRemoveWatchlist.execute(testMovieDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => const Right(true));
        return movieDetailBloc;
      },
      seed:
          () => MovieDetailState.loadedMovieDetail(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.loaded,
            isAddedToWatchlist: true,
          ),
      act:
          (bloc) =>
              bloc.add(MovieDetailEvent.removeFromWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loadedMovieDetail(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.loaded,
              isAddedToWatchlist: true,
              watchlistMessage: 'Database Failure',
            ),
          ],
    );
  });
}
