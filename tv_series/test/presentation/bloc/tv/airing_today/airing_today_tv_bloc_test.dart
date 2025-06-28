import 'package:bloc_test/bloc_test.dart';
import 'package:core/module/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/module/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper_tv.mocks.dart';

@GenerateMocks([GetAiringTodayTv])
void main() {
  late AiringTodayTvBloc airingTodayTvBloc;
  late MockGetAiringTodayTv mockGetAiringTodayTv;

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
    mockGetAiringTodayTv = MockGetAiringTodayTv();
    airingTodayTvBloc = AiringTodayTvBloc(
      getAiringTodayTv: mockGetAiringTodayTv,
    );
  });

  // Tes untuk memastikan state awal adalah Initial
  test('initial state should be Initial', () {
    expect(airingTodayTvBloc.state, const AiringTodayTvState.initialAtTv());
  });

  group('FetchInitialTvS', () {
    // Tes untuk kasus sukses saat pertama kali fetch data
    blocTest<AiringTodayTvBloc, AiringTodayTvState>(
      'should emit [Loading, Loaded] when data is fetched successfully',
      build: () {
        // Atur mock untuk mengembalikan data sukses
        when(
          mockGetAiringTodayTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return airingTodayTvBloc;
      },
      act:
          (bloc) =>
              bloc.add(const AiringTodayTvEvent.fetchInitialAiringToday()),
      expect:
          () => <AiringTodayTvState>[
            const AiringTodayTvState.loadingAtTv(),
            AiringTodayTvState.loadedAtTv(
              airingToday: tTvList,
              airingTodayPage: 2, // Halaman berikutnya adalah 2
              hasMoreAiringToday:
                  true, // Masih ada data karena list tidak kosong
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman pertama (1)
        verify(mockGetAiringTodayTv.execute(1));
      },
    );

    // Tes untuk kasus sukses tapi data yang diterima kosong
    blocTest<AiringTodayTvBloc, AiringTodayTvState>(
      'should emit [Loading, Loaded] with empty list and no more data when fetched data is empty',
      build: () {
        // Atur mock untuk mengembalikan list kosong
        when(
          mockGetAiringTodayTv.execute(1),
        ).thenAnswer((_) async => const Right([]));
        return airingTodayTvBloc;
      },
      act:
          (bloc) =>
              bloc.add(const AiringTodayTvEvent.fetchInitialAiringToday()),
      expect:
          () => <AiringTodayTvState>[
            const AiringTodayTvState.loadingAtTv(),
            const AiringTodayTvState.loadedAtTv(
              airingToday: [],
              airingTodayPage: 2,
              hasMoreAiringToday: false, // Tidak ada data lagi
            ),
          ],
    );

    // Tes untuk kasus kegagalan (misal: error server)
    blocTest<AiringTodayTvBloc, AiringTodayTvState>(
      'should emit [Loading, Error] when data fetching fails',
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetAiringTodayTv.execute(1),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return airingTodayTvBloc;
      },
      act:
          (bloc) =>
              bloc.add(const AiringTodayTvEvent.fetchInitialAiringToday()),
      expect:
          () => <AiringTodayTvState>[
            const AiringTodayTvState.loadingAtTv(),
            const AiringTodayTvState.errorAtTv('Server Failure'),
          ],
    );
  });

  group('RefreshTv', () {
    // Tes untuk pull-to-refresh. Logikanya sama dengan fetch awal.
    blocTest<AiringTodayTvBloc, AiringTodayTvState>(
      'should emit [Loading, Loaded] when RefreshTv is added',
      build: () {
        when(
          mockGetAiringTodayTv.execute(1),
        ).thenAnswer((_) async => Right(tTvList));
        return airingTodayTvBloc;
      },
      // Trigger event refresh
      act: (bloc) => bloc.add(const AiringTodayTvEvent.refreshTvAt()),
      expect:
          () => <AiringTodayTvState>[
            // Karena `RefreshTv` memanggil `FetchInitialTvS`, urutan state-nya sama
            const AiringTodayTvState.loadingAtTv(),
            AiringTodayTvState.loadedAtTv(
              airingToday: tTvList,
              airingTodayPage: 2,
              hasMoreAiringToday: true,
            ),
          ],
      verify: (_) {
        // Verifikasi bahwa proses fetch dari halaman pertama terjadi
        verify(mockGetAiringTodayTv.execute(1));
      },
    );
  });

  group('FetchMoreAiringTodayTv', () {
    // Tes untuk infinite scroll saat sukses
    blocTest<AiringTodayTvBloc, AiringTodayTvState>(
      'should emit [Loaded] with additional data when fetching more is successful',
      // 'seed' adalah state awal sebelum 'act' dieksekusi
      seed:
          () => AiringTodayTvState.loadedAtTv(
            airingToday: tTvList,
            airingTodayPage: 2, // Halaman saat ini yang akan di-fetch
            hasMoreAiringToday: true,
          ),
      build: () {
        // Atur mock untuk halaman berikutnya (halaman 2)
        when(
          mockGetAiringTodayTv.execute(2),
        ).thenAnswer((_) async => Right(tTvList));
        return airingTodayTvBloc;
      },
      act:
          (bloc) => bloc.add(const AiringTodayTvEvent.fetchMoreAiringTodayTv()),
      expect:
          () => <AiringTodayTvState>[
            AiringTodayTvState.loadedAtTv(
              // Data lama digabung dengan data baru
              airingToday: List.of(tTvList)..addAll(tTvList),
              airingTodayPage: 3, // Halaman selanjutnya adalah 3
              hasMoreAiringToday: true,
            ),
          ],
      verify: (_) {
        // Pastikan use case dipanggil dengan halaman yang benar (2)
        verify(mockGetAiringTodayTv.execute(2));
      },
    );

    // Tes untuk infinite scroll saat gagal
    blocTest<AiringTodayTvBloc, AiringTodayTvState>(
      'should emit [Loaded] with minorError when fetching more fails',
      seed:
          () => AiringTodayTvState.loadedAtTv(
            airingToday: tTvList,
            airingTodayPage: 2,
            hasMoreAiringToday: true,
          ),
      build: () {
        // Atur mock untuk mengembalikan kegagalan
        when(
          mockGetAiringTodayTv.execute(2),
        ).thenAnswer((_) async => Left(ServerFailure('Fetch More Failed')));
        return airingTodayTvBloc;
      },
      act:
          (bloc) => bloc.add(const AiringTodayTvEvent.fetchMoreAiringTodayTv()),
      expect:
          () => <AiringTodayTvState>[
            // State Loaded tetap ada, tapi dengan pesan error minor
            AiringTodayTvState.loadedAtTv(
              airingToday: tTvList,
              airingTodayPage: 2, // Halaman tidak bertambah karena gagal
              hasMoreAiringToday: true,
              minorError: 'Fetch More Failed',
            ),
          ],
    );

    // Tes untuk memastikan tidak ada event yang di-emit jika sudah tidak ada data lagi
    blocTest<AiringTodayTvBloc, AiringTodayTvState>(
      'should not emit new state when hasMoreAiringToday is false',
      seed:
          () => const AiringTodayTvState.loadedAtTv(
            airingToday: [],
            airingTodayPage: 2,
            hasMoreAiringToday: false, // Kondisi penting untuk tes ini
          ),
      build: () => airingTodayTvBloc,
      act:
          (bloc) => bloc.add(const AiringTodayTvEvent.fetchMoreAiringTodayTv()),
      // 'expect' harus kosong karena tidak ada state baru yang di-emit
      expect: () => <AiringTodayTvState>[],
      verify: (_) {
        // Pastikan use case tidak pernah dipanggil
        verifyNever(mockGetAiringTodayTv.execute(any));
      },
    );
  });
}
