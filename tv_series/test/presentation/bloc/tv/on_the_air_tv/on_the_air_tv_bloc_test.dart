import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../../../helpers/test_helper_tv.mocks.dart';

// @GenerateMocks([GetOnTheAirTv])
void main() {
  late OnTheAirTvBloc onTheAirTvBloc;
  late MockGetOnTheAirTv mockGetOnTheAirTv;

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
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    onTheAirTvBloc = OnTheAirTvBloc(getOnTheAirTv: mockGetOnTheAirTv);
  });

  // Tes untuk memastikan state awal adalah Initial
  test('initial state should be Initial', () {
    expect(onTheAirTvBloc.state, const OnTheAirTvState.initialOtaTv());
  });

  group('FetchInitialTvS', () {
    // Tes untuk kasus sukses saat pertama kali fetch data
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        // Atur mock untuk mengembalikan data sukses
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(const OnTheAirTvEvent.fetchInitialOnTheAir()),
      expect:
          () => <OnTheAirTvState>[
            const OnTheAirTvState.loadingOtaTv(),
            OnTheAirTvState.loadedOtaTv(
              onTheAir: tTvList,
              onTheAirPage: 2, // Halaman berikutnya adalah 2
              hasMoreOnTheAir: true, // Masih ada data karena list tidak kosong
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman pertama (1)
        verify(mockGetOnTheAirTv.execute(1));
      },
    );

    // Tes untuk kasus sukses tapi data yang diterima kosong
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'should emit [Loading, Loaded] with empty list and no more data when fetched data is empty',
      build: () {
        // Atur mock untuk mengembalikan list kosong
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => const Right([]));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(const OnTheAirTvEvent.fetchInitialOnTheAir()),
      expect:
          () => <OnTheAirTvState>[
            const OnTheAirTvState.loadingOtaTv(),
            const OnTheAirTvState.loadedOtaTv(
              onTheAir: [],
              onTheAirPage: 2,
              hasMoreOnTheAir: false, // Tidak ada data lagi
            ),
          ],
    );

    // Tes untuk kasus kegagalan (misal: error server)
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'should emit [Loading, Error] when data fetching fails',
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(const OnTheAirTvEvent.fetchInitialOnTheAir()),
      expect:
          () => <OnTheAirTvState>[
            const OnTheAirTvState.loadingOtaTv(),
            const OnTheAirTvState.errorOtaTv('Server Failure'),
          ],
    );
  });

  group('RefreshTv', () {
    // Tes untuk pull-to-refresh. Logikanya sama dengan fetch awal.
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'should emit [Loading, Loaded] when RefreshTv is added',
      build: () {
        when(
          mockGetOnTheAirTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return onTheAirTvBloc;
      },
      // Trigger event refresh
      act: (bloc) => bloc.add(const OnTheAirTvEvent.refreshTvOta()),
      expect:
          () => <OnTheAirTvState>[
            // Karena `RefreshTv` memanggil `FetchInitialTvS`, urutan state-nya sama
            const OnTheAirTvState.loadingOtaTv(),
            OnTheAirTvState.loadedOtaTv(
              onTheAir: tTvList,
              onTheAirPage: 2,
              hasMoreOnTheAir: true,
            ),
          ],
      verify: (_) {
        // Verifikasi bahwa proses fetch dari halaman pertama terjadi
        verify(mockGetOnTheAirTv.execute(1));
      },
    );
  });

  group('FetchMoreOnTheAirTv', () {
    // Tes untuk infinite scroll saat sukses
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'should emit [Loaded] with additional data when fetching more is successful',
      // 'seed' adalah state awal sebelum 'act' dieksekusi
      seed:
          () => OnTheAirTvState.loadedOtaTv(
            onTheAir: tTvList,
            onTheAirPage: 2, // Halaman saat ini yang akan di-fetch
            hasMoreOnTheAir: true,
          ),
      build: () {
        // Atur mock untuk halaman berikutnya (halaman 2)
        when(
          mockGetOnTheAirTv.execute(2),
        ).thenAnswer((_) async => Right(tTvList));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(const OnTheAirTvEvent.fetchMoreOnTheAirTv()),
      expect:
          () => <OnTheAirTvState>[
            OnTheAirTvState.loadedOtaTv(
              // Data lama digabung dengan data baru
              onTheAir: List.of(tTvList)..addAll(tTvList),
              onTheAirPage: 3, // Halaman selanjutnya adalah 3
              hasMoreOnTheAir: true,
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman yang benar (2)
        verify(mockGetOnTheAirTv.execute(2));
      },
    );

    // Tes untuk infinite scroll saat gagal
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'should emit [Loaded] with minorError when fetching more fails',
      seed:
          () => OnTheAirTvState.loadedOtaTv(
            onTheAir: tTvList,
            onTheAirPage: 2,
            hasMoreOnTheAir: true,
          ),
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetOnTheAirTv.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Fetch More Failed')));
        return onTheAirTvBloc;
      },
      act: (bloc) => bloc.add(const OnTheAirTvEvent.fetchMoreOnTheAirTv()),
      expect:
          () => <OnTheAirTvState>[
            // State Loaded tetap ada, tapi dengan pesan error minor
            OnTheAirTvState.loadedOtaTv(
              onTheAir: tTvList,
              onTheAirPage: 2, // Halaman tidak bertambah karena gagal
              hasMoreOnTheAir: true,
              minorError: 'Fetch More Failed',
            ),
          ],
    );

    // Tes untuk memastikan tidak ada event yang di-emit jika sudah tidak ada data lagi
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'should not emit new state when hasMoreOnTheAir is false',
      seed:
          () => const OnTheAirTvState.loadedOtaTv(
            onTheAir: [],
            onTheAirPage: 2,
            hasMoreOnTheAir: false, // Kondisi penting untuk tes ini
          ),
      build: () => onTheAirTvBloc,
      act: (bloc) => bloc.add(const OnTheAirTvEvent.fetchMoreOnTheAirTv()),
      // 'expect' harus kosong karena tidak ada state baru yang di-emit
      expect: () => <OnTheAirTvState>[],
      verify: (_) {
        // Pastikan use case tidak pernah dipanggil
        verifyNever(mockGetOnTheAirTv.execute(any));
      },
    );
  });
}
