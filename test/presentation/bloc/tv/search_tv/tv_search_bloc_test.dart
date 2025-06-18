import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  final tTvModel = TvSeries(
    adult: false,
    backdropPath: '/ottT2Yt0OfHiHp3PHJTLNVV8JPE.jpg',
    genreIds: [18, 10766],
    id: 13945,
    originCountry: ["DE"],
    originalLanguage: "de",
    originalName: "Gute Zeiten, schlechte Zeiten",
    overview:
        "Gute Zeiten, schlechte Zeiten is a long-running German television soap opera, first broadcast on RTL in 1992. The programme concerns the lives of a fictional neighborhood in Germany's capital city Berlin. Over the years the soap opera tends to have an overhaul of young people in their late teens and early twenties; targeting a young viewership.",
    popularity: 677.2062,
    posterPath: "/qujVFLAlBnPU9mZElV4NZgL8iXT.jpg",
    firstAirDate: "1992-05-11",
    name: "Gute Zeiten, schlechte Zeiten",
    voteAverage: 5.769,
    voteCount: 39,
  );

  final tTvList = <TvSeries>[tTvModel];
  final tQuery = 'gute';
  const tInvalidQuery = 'gute!';

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvSearchBloc = TvSearchBloc(searchTvSeries: mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(tvSearchBloc.state, SearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Empty] when query is empty or just spaces',
    build: () => tvSearchBloc,
    act: (bloc) => bloc.add(const TvSearchEvent.onQueryChangedTv('  ')),
    // Tidak perlu wait karena validasi ini terjadi sebelum debounce
    expect: () => [const TvSearchState.searchEmpty()],
    verify: (_) {
      // Pastikan use case tidak pernah dipanggil
      verifyZeroInteractions(mockSearchTvSeries);
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Error] when query contains invalid characters',
    build: () => tvSearchBloc,
    act:
        (bloc) =>
        bloc.add(const TvSearchEvent.onQueryChangedTv(tInvalidQuery)),
    // Tidak perlu wait karena validasi ini terjadi sebelum debounce
    expect:
        () => [
      const TvSearchState.searchError(
        'Query contains invalid characters',
      ),
    ],
    verify: (_) {
      // Pastikan use case tidak pernah dipanggil
      verifyZeroInteractions(mockSearchTvSeries);
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => Right(tTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
    // wait: const Duration(milliseconds: 100),

    // Tunggu durasi debounce agar event diproses
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchLoading(), SearchHasData(tTvList)],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, HasData with empty list] when data is empty',
    build: () {
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => const Right(<TvSeries>[]));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(TvSearchEvent.onQueryChangedTv(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect:
        () => [
      const TvSearchState.searchLoading(),
      const TvSearchState.searchHasData(<TvSeries>[]),
    ],
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(
        mockSearchTvSeries.execute(tQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChangedTv(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchLoading(), SearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(tQuery));
    },
  );

}
