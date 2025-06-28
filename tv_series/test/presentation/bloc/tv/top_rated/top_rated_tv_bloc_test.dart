import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([GetTopRatedTv])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  // Data dummy untuk digunakan dalam tes
  final tTvSeries = TvSeries(
    id: 1,
    name: 'Test TV Series',
    overview: 'Test Overview',
    posterPath: '/test.jpg',
    backdropPath: '/test_backdrop.jpg',
    adult: false,
    genreIds: const [1],
    originCountry: const ["US"],
    originalLanguage: "en",
    originalName: 'Test Original Name',
    popularity: 1.0,
    firstAirDate: "2022-01-01",
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvList = <TvSeries>[tTvSeries];

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(getTopRatedTv: mockGetTopRatedTv);
  });

  // Tes untuk memastikan state awal adalah Initial
  test('initial state should be Initial', () {
    expect(topRatedTvBloc.state, const TopRatedTvState.initialTrTv());
  });

  group('FetchInitialTvS', () {
    // Tes untuk kasus sukses saat pertama kali fetch data
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        // Atur mock untuk mengembalikan data sukses
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(const TopRatedTvEvent.fetchInitialTopRatedTv()),
      expect:
          () => <TopRatedTvState>[
            const TopRatedTvState.loadingTrTv(),
            TopRatedTvState.loadedTrTv(
              topRated: tTvList,
              topRatedPage: 2, // Halaman berikutnya adalah 2
              hasMoreTopRated: true, // Masih ada data karena list tidak kosong
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman pertama (1)
        verify(mockGetTopRatedTv.execute(1));
      },
    );

    // Tes untuk kasus sukses tapi data yang diterima kosong
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'should emit [Loading, Loaded] with empty list and no more data when fetched data is empty',
      build: () {
        // Atur mock untuk mengembalikan list kosong
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => const Right([]));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(const TopRatedTvEvent.fetchInitialTopRatedTv()),
      expect:
          () => <TopRatedTvState>[
            const TopRatedTvState.loadingTrTv(),
            const TopRatedTvState.loadedTrTv(
              topRated: [],
              topRatedPage: 2,
              hasMoreTopRated: false, // Tidak ada data lagi
            ),
          ],
    );

    // Tes untuk kasus kegagalan (misal: error server)
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'should emit [Loading, Error] when data fetching fails',
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(const TopRatedTvEvent.fetchInitialTopRatedTv()),
      expect:
          () => <TopRatedTvState>[
            const TopRatedTvState.loadingTrTv(),
            const TopRatedTvState.errorTrTv('Server Failure'),
          ],
    );
  });

  group('RefreshTv', () {
    // Tes untuk pull-to-refresh. Logikanya sama dengan fetch awal.
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'should emit [Loading, Loaded] when RefreshTv is added',
      build: () {
        when(
          mockGetTopRatedTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      // Trigger event refresh
      act: (bloc) => bloc.add(const TopRatedTvEvent.refreshTvTr()),
      expect:
          () => <TopRatedTvState>[
            // Karena `RefreshTv` memanggil `FetchInitialTvS`, urutan state-nya sama
            const TopRatedTvState.loadingTrTv(),
            TopRatedTvState.loadedTrTv(
              topRated: tTvList,
              topRatedPage: 2,
              hasMoreTopRated: true,
            ),
          ],
      verify: (_) {
        // Verifikasi bahwa proses fetch dari halaman pertama terjadi
        verify(mockGetTopRatedTv.execute(1));
      },
    );
  });

  group('FetchMoreTopRatedTv', () {
    // Tes untuk infinite scroll saat sukses
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'should emit [Loaded] with additional data when fetching more is successful',
      // 'seed' adalah state awal sebelum 'act' dieksekusi
      seed:
          () => TopRatedTvState.loadedTrTv(
            topRated: tTvList,
            topRatedPage: 2, // Halaman saat ini yang akan di-fetch
            hasMoreTopRated: true,
          ),
      build: () {
        // Atur mock untuk halaman berikutnya (halaman 2)
        when(
          mockGetTopRatedTv.execute(2),
        ).thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(const TopRatedTvEvent.fetchMoreTopRatedTv()),
      expect:
          () => <TopRatedTvState>[
            TopRatedTvState.loadedTrTv(
              // Data lama digabung dengan data baru
              topRated: List.of(tTvList)..addAll(tTvList),
              topRatedPage: 3, // Halaman selanjutnya adalah 3
              hasMoreTopRated: true,
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman yang benar (2)
        verify(mockGetTopRatedTv.execute(2));
      },
    );

    // Tes untuk infinite scroll saat gagal
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'should emit [Loaded] with minorError when fetching more fails',
      seed:
          () => TopRatedTvState.loadedTrTv(
            topRated: tTvList,
            topRatedPage: 2,
            hasMoreTopRated: true,
          ),
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetTopRatedTv.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Fetch More Failed')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(const TopRatedTvEvent.fetchMoreTopRatedTv()),
      expect:
          () => <TopRatedTvState>[
            // State Loaded tetap ada, tapi dengan pesan error minor
            TopRatedTvState.loadedTrTv(
              topRated: tTvList,
              topRatedPage: 2, // Halaman tidak bertambah karena gagal
              hasMoreTopRated: true,
              minorError: 'Fetch More Failed',
            ),
          ],
    );

    // Tes untuk memastikan tidak ada event yang di-emit jika sudah tidak ada data lagi
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'should not emit new state when hasMoreTopRated is false',
      seed:
          () => const TopRatedTvState.loadedTrTv(
            topRated: [],
            topRatedPage: 2,
            hasMoreTopRated: false,
          ),
      build: () => topRatedTvBloc,
      act: (bloc) => bloc.add(const TopRatedTvEvent.fetchMoreTopRatedTv()),
      // 'expect' harus kosong karena tidak ada state baru yang di-emit
      expect: () => <TopRatedTvState>[],
      verify: (_) {
        // Pastikan use case tidak pernah dipanggil
        verifyNever(mockGetTopRatedTv.execute(any));
      },
    );
  });
}
