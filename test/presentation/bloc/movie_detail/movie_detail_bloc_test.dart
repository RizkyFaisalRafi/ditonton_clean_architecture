import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_movie_detail.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/get_watchlist_status.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/remove_watchlist.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/save_watchlist.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
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
            const MovieDetailState.loading(),
            MovieDetailState.loaded(
              movieDetail: testMovieDetail,
              movieRecommendations: tMovies,
              recommendationState: RequestState.Loaded,
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
            const MovieDetailState.loading(),
            const MovieDetailState.error('Server Failure'),
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
            const MovieDetailState.loading(),
            MovieDetailState.loaded(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.Error,
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
          () => MovieDetailState.loaded(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: false,
          ),
      act: (bloc) => bloc.add(MovieDetailEvent.addToWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loaded(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.Loaded,
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
          () => MovieDetailState.loaded(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: false,
          ),
      act: (bloc) => bloc.add(MovieDetailEvent.addToWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loaded(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.Loaded,
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
          () => MovieDetailState.loaded(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: true,
          ),
      act:
          (bloc) =>
              bloc.add(MovieDetailEvent.removeFromWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loaded(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.Loaded,
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
          () => MovieDetailState.loaded(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: true,
          ),
      act:
          (bloc) =>
              bloc.add(MovieDetailEvent.removeFromWatchlist(testMovieDetail)),
      expect:
          () => [
            MovieDetailState.loaded(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.Loaded,
              isAddedToWatchlist: true,
              watchlistMessage: 'Database Failure',
            ),
          ],
    );
  });
}
