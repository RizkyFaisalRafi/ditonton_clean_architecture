import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([GetPopularTv])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTv mockGetPopularTv;

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
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(getPopularTv: mockGetPopularTv);
  });

  // Tes untuk memastikan state awal adalah Initial
  test('initial state should be Initial', () {
    expect(popularTvBloc.state, const PopularTvState.initialPopularTv());
  });

  group('FetchInitialTvS', () {
    // Tes untuk kasus sukses saat pertama kali fetch data
    blocTest<PopularTvBloc, PopularTvState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        // Atur mock untuk mengembalikan data sukses
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(const PopularTvEvent.fetchInitialPopularTv()),
      expect:
          () => <PopularTvState>[
            const PopularTvState.loadingPopularTv(),
            PopularTvState.loadedPopularTv(
              popular: tTvList,
              popularPage: 2, // Halaman berikutnya adalah 2
              hasMorePopular: true, // Masih ada data karena list tidak kosong
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman pertama (1)
        verify(mockGetPopularTv.execute(1));
      },
    );

    // Tes untuk kasus sukses tapi data yang diterima kosong
    blocTest<PopularTvBloc, PopularTvState>(
      'should emit [Loading, Loaded] with empty list and no more data when fetched data is empty',
      build: () {
        // Atur mock untuk mengembalikan list kosong
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => const Right([]));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(const PopularTvEvent.fetchInitialPopularTv()),
      expect:
          () => <PopularTvState>[
            const PopularTvState.loadingPopularTv(),
            const PopularTvState.loadedPopularTv(
              popular: [],
              popularPage: 2,
              hasMorePopular: false, // Tidak ada data lagi
            ),
          ],
    );

    // Tes untuk kasus kegagalan (misal: error server)
    blocTest<PopularTvBloc, PopularTvState>(
      'should emit [Loading, Error] when data fetching fails',
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(const PopularTvEvent.fetchInitialPopularTv()),
      expect:
          () => <PopularTvState>[
            const PopularTvState.loadingPopularTv(),
            const PopularTvState.errorPopularTv('Server Failure'),
          ],
    );
  });

  group('RefreshTv', () {
    // Tes untuk pull-to-refresh. Logikanya sama dengan fetch awal.
    blocTest<PopularTvBloc, PopularTvState>(
      'should emit [Loading, Loaded] when RefreshTv is added',
      build: () {
        when(
          mockGetPopularTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      // Trigger event refresh
      act: (bloc) => bloc.add(const PopularTvEvent.refreshPTv()),
      expect:
          () => <PopularTvState>[
            // Karena `RefreshTv` memanggil `FetchInitialTvS`, urutan state-nya sama
            const PopularTvState.loadingPopularTv(),
            PopularTvState.loadedPopularTv(
              popular: tTvList,
              popularPage: 2,
              hasMorePopular: true,
            ),
          ],
      verify: (_) {
        // Verifikasi bahwa proses fetch dari halaman pertama terjadi
        verify(mockGetPopularTv.execute(1));
      },
    );
  });

  group('FetchMorePopularTv', () {
    // Tes untuk infinite scroll saat sukses
    blocTest<PopularTvBloc, PopularTvState>(
      'should emit [Loaded] with additional data when fetching more is successful',
      // 'seed' adalah state awal sebelum 'act' dieksekusi
      seed:
          () => PopularTvState.loadedPopularTv(
            popular: tTvList,
            popularPage: 2, // Halaman saat ini yang akan di-fetch
            hasMorePopular: true,
          ),
      build: () {
        // Atur mock untuk halaman berikutnya (halaman 2)
        when(
          mockGetPopularTv.execute(2),
        ).thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(const PopularTvEvent.fetchMorePopularTv()),
      expect:
          () => <PopularTvState>[
            PopularTvState.loadedPopularTv(
              // Data lama digabung dengan data baru
              popular: List.of(tTvList)..addAll(tTvList),
              popularPage: 3, // Halaman selanjutnya adalah 3
              hasMorePopular: true,
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman yang benar (2)
        verify(mockGetPopularTv.execute(2));
      },
    );

    // Tes untuk infinite scroll saat gagal
    blocTest<PopularTvBloc, PopularTvState>(
      'should emit [Loaded] with minorError when fetching more fails',
      seed:
          () => PopularTvState.loadedPopularTv(
            popular: tTvList,
            popularPage: 2,
            hasMorePopular: true,
          ),
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetPopularTv.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Fetch More Failed')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(const PopularTvEvent.fetchMorePopularTv()),
      expect:
          () => <PopularTvState>[
            // State Loaded tetap ada, tapi dengan pesan error minor
            PopularTvState.loadedPopularTv(
              popular: tTvList,
              popularPage: 2, // Halaman tidak bertambah karena gagal
              hasMorePopular: true,
              minorError: 'Fetch More Failed',
            ),
          ],
    );

    // Tes untuk memastikan tidak ada event yang di-emit jika sudah tidak ada data lagi
    blocTest<PopularTvBloc, PopularTvState>(
      'should not emit new state when hasMorePopular is false',
      seed:
          () => const PopularTvState.loadedPopularTv(
            popular: [],
            popularPage: 2,
            hasMorePopular: false, // Kondisi penting untuk tes ini
          ),
      build: () => popularTvBloc,
      act: (bloc) => bloc.add(const PopularTvEvent.fetchMorePopularTv()),
      // 'expect' harus kosong karena tidak ada state baru yang di-emit
      expect: () => <PopularTvState>[],
      verify: (_) {
        // Pastikan use case tidak pernah dipanggil
        verifyNever(mockGetPopularTv.execute(any));
      },
    );
  });
}
