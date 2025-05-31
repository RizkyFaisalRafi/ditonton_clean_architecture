import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_model.dart';
import 'package:ditonton_clean_architecture/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  // Set Up
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvSeriesLocalDatasource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    mockDatabaseHelper = MockDatabaseHelper();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvModel(
    adult: false,
    backdropPath: "/ottT2Yt0OfHiHp3PHJTLNVV8JPE.jpg",
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

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/ottT2Yt0OfHiHp3PHJTLNVV8JPE.jpg",
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

  final tTvSeriesModelList = <TvModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Airing Today Tv Series', () {
    group('cache airing today tv series', () {
      late TvSeriesLocalDatasourceImpl localDataSource;
      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
        localDataSource = TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
      });

      /**
       * Menguji apakah method cacheAiringTodayTvSeries() menyimpan data ke local database.
       * Verifikasi bahwa clearCacheTv dan insertCacheTransactionTv terpanggil.
       */
      test('should call database helper to save data', () async {
        // arrange
        when(
          mockDatabaseHelper.clearCacheTvSeries('airing today'),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], 'airing today'),
        ).thenAnswer((_) async => {});

        final dataSource = TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
        // act
        await dataSource.cacheAiringTodayTvSeries([testTvCache]);

        // assert
        verify(mockDatabaseHelper.clearCacheTvSeries('airing today'));
        verify(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], 'airing today'),
        );
      });

      /// Jika cache ada → return list tvSeries.
      test('should return list of movies from db when data exist', () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheTvSeries('airing today'),
        ).thenAnswer((_) async => [testTvCacheMap]);

        // act
        final result = await localDataSource.getCachedAiringTodayTv();

        // assert
        expect(result, [testTvCache]);
      });

      /// Jika cache kosong → lempar CacheException.
      test(
        'should throw CacheException when cache data is not exist',
        () async {
          // arrange
          when(
            mockDatabaseHelper.getCacheTvSeries('airing today'),
          ).thenAnswer((_) async => []);

          // act
          final call = localDataSource.getCachedAiringTodayTv();

          // assert
          expect(() => call, throwsA(isA<CacheException>()));
        },
      );
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      /// Memeriksa apakah aplikasi terhubung dengan internet?
      test('should check if the device is online', () async {
        // arrange (Menyiapkan objek dan konfigurasi untuk pengujian)
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getAiringToday()).thenAnswer((_) async => []);

        // act (Aksi dalam Skenario Pengujian)
        await repository.getAiringToday();

        // assert (Assert adalah memvalidasi nilai atau aksi yang diekspektasikan)
        // ingin memverifikasi bahwa telah dilakukan pengecekan apakah aplikasi terhubung ke internet.
        verify(mockNetworkInfo.isConnected);
        //   Fungsi verify() merupakan fungsi dari package mockito untuk memverifikasi apakah suatu method dieksekusi.
      });

      /// Jika sukses ambil data dari API, kembalikan hasil Right<List<TvSeries>>.
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          // Ketika mockRemoteDataSource.getNowPlayingMovies dijalankan maka
          // jawabannya hasil response (Ini mensimulasikan respons sukses dari server)
          when(
            mockRemoteDataSource.getAiringToday(),
          ).thenAnswer((_) async => tTvSeriesModelList);

          // act
          // Melakukan aksi/memanggil fungsi yang akan diuji kemudian disimpan di variabel
          final result = await repository.getAiringToday();

          // assert
          //  memastikan bahwa sebuah metode mock (tiruan) dipanggil saat test dijalankan.
          verify(mockRemoteDataSource.getAiringToday());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          // repository.getNowPlayingMovies() kemungkinan besar mengembalikan objek Either<Failure, List<Movie>> dari package dartz
          // digunakan untuk mengambil nilai di dalam Right, atau list kosong jika hasilnya Left.
          /**
           * Ini adalah workaround untuk menghindari masalah membandingkan
           * Right<List> langsung (karena dartz tidak membolehkan langsung
           * menggunakan expect(result, Right(expected)) pada list, karena
           * masalah equality kompleks,
           */
          final resultList = result.getOrElse(() => []);
          // Digunakan untuk memeriksa hasil (output) dari sebuah operasi.
          // expect(actualValue, expectedValue);
          expect(resultList, tTvSeriesList);
        },
      );

      /// Simpan data yang didapat dari API ke dalam database.
      /// Setelah ambil data dari remote, data juga disimpan ke local (caching).
      /// untuk memastikan bahwa memanggil data dari internet lalu menyimpannya secara lokal
      test(
        'should cache data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getAiringToday(),
          ).thenAnswer((_) async => tTvSeriesModelList);
          // act
          await repository.getAiringToday();
          // assert
          verify(mockRemoteDataSource.getAiringToday());
          verify(mockLocalDataSource.cacheAiringTodayTvSeries([testTvCache]));
        },
      );

      /// Remote gagal
      /// Jika terjadi ServerException, return Left(ServerFailure).
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getAiringToday(),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getAiringToday();
          // assert
          verify(mockRemoteDataSource.getAiringToday());
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      /// Saat offline, ambil data dari local cache.
      /// Hasil berupa Right<List<TvSeries>>.
      test('should return cached data when device is offline', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedAiringTodayTv(),
        ).thenAnswer((_) async => [testTvCache]);

        // act
        // panggil method yang akan di uji dan simpan nilai kembaliannya ke dalam sebuah variabel.
        final result = await repository.getAiringToday();

        // assert
        // masukkan ekspektasi pengujian yang diharapkan. Kita ingin memastikan
        // localDataSource.getCachedNowPlayingMovies() dipanggil lalu nilai yang
        // dikembalikan juga sesuai.
        verify(mockLocalDataSource.getCachedAiringTodayTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      /// ketika tidak ada data di dalam cache
      /// Jika cache kosong → return Left(CacheFailure).
      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedAiringTodayTv(),
        ).thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getAiringToday();
        // assert
        verify(mockLocalDataSource.getCachedAiringTodayTv());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });


}
