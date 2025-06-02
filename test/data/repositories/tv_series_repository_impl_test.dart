import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/data/datasources/tv_series/tv_series_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/genre_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/created_by_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/episode_to_air_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/production_companies_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/season_model.dart';
import 'package:ditonton_clean_architecture/data/models/tv_series/tv_detail_model.dart';
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

  group('On The Air Tv Series', () {
    group('cache on the air tv series', () {
      late TvSeriesLocalDatasourceImpl localDataSource;
      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
        localDataSource = TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
      });

      /**
       * Menguji apakah method cacheOnTheAirTvSeries() menyimpan data ke local database.
       * Verifikasi bahwa clearCacheTv dan insertCacheTransactionTv terpanggil.
       */
      test('should call database helper to save data', () async {
        // arrange
        when(
          mockDatabaseHelper.clearCacheTvSeries('on the air'),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], 'on the air'),
        ).thenAnswer((_) async => {});

        final dataSource = TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
        // act
        await dataSource.cacheOnTheAirTvSeries([testTvCache]);

        // assert
        verify(mockDatabaseHelper.clearCacheTvSeries('on the air'));
        verify(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], 'on the air'),
        );
      });

      /// Jika cache ada → return list tvSeries.
      test('should return list of movies from db when data exist', () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheTvSeries('on the air'),
        ).thenAnswer((_) async => [testTvCacheMap]);

        // act
        final result = await localDataSource.getCachedOnTheAirTv();

        // assert
        expect(result, [testTvCache]);
      });

      /// Jika cache kosong → lempar CacheException.
      test(
        'should throw CacheException when cache data is not exist',
        () async {
          // arrange
          when(
            mockDatabaseHelper.getCacheTvSeries('on the air'),
          ).thenAnswer((_) async => []);

          // act
          final call = localDataSource.getCachedOnTheAirTv();

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
        when(mockRemoteDataSource.getOnTheAir()).thenAnswer((_) async => []);

        // act (Aksi dalam Skenario Pengujian)
        await repository.getOnTheAir();

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
          // Ketika mockRemoteDataSource.getOnTheAir dijalankan maka
          // jawabannya hasil response (Ini mensimulasikan respons sukses dari server)
          when(
            mockRemoteDataSource.getOnTheAir(),
          ).thenAnswer((_) async => tTvSeriesModelList);

          // act
          // Melakukan aksi/memanggil fungsi yang akan diuji kemudian disimpan di variabel
          final result = await repository.getOnTheAir();

          // assert
          //  memastikan bahwa sebuah metode mock (tiruan) dipanggil saat test dijalankan.
          verify(mockRemoteDataSource.getOnTheAir());
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
            mockRemoteDataSource.getOnTheAir(),
          ).thenAnswer((_) async => tTvSeriesModelList);
          // act
          await repository.getOnTheAir();
          // assert
          verify(mockRemoteDataSource.getOnTheAir());
          verify(mockLocalDataSource.cacheOnTheAirTvSeries([testTvCache]));
        },
      );

      /// Remote gagal
      /// Jika terjadi ServerException, return Left(ServerFailure).
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getOnTheAir()).thenThrow(ServerException());
          // act
          final result = await repository.getOnTheAir();
          // assert
          verify(mockRemoteDataSource.getOnTheAir());
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
          mockLocalDataSource.getCachedOnTheAirTv(),
        ).thenAnswer((_) async => [testTvCache]);

        // act
        // panggil method yang akan di uji dan simpan nilai kembaliannya ke dalam sebuah variabel.
        final result = await repository.getOnTheAir();

        // assert
        // masukkan ekspektasi pengujian yang diharapkan. Kita ingin memastikan
        // localDataSource.getCachedOnTheAirTv() dipanggil lalu nilai yang
        // dikembalikan juga sesuai.
        verify(mockLocalDataSource.getCachedOnTheAirTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      /// ketika tidak ada data di dalam cache
      /// Jika cache kosong → return Left(CacheFailure).
      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedOnTheAirTv(),
        ).thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getOnTheAir();
        // assert
        verify(mockLocalDataSource.getCachedOnTheAirTv());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Tv Series', () {
    group('cache popular tv series', () {
      late TvSeriesLocalDatasourceImpl localDataSource;
      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
        localDataSource = TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
      });

      /**
       * Menguji apakah method cachePopularTvSeries() menyimpan data ke local database.
       * Verifikasi bahwa clearCacheTv dan insertCacheTransactionTv terpanggil.
       */
      test('should call database helper to save data', () async {
        // arrange
        when(
          mockDatabaseHelper.clearCacheTvSeries('popular'),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], 'popular'),
        ).thenAnswer((_) async => {});

        final dataSource = TvSeriesLocalDatasourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
        // act
        await dataSource.cachePopularTvSeries([testTvCache]);

        // assert
        verify(mockDatabaseHelper.clearCacheTvSeries('popular'));
        verify(
          mockDatabaseHelper.insertCacheTransactionTvSeries([
            testTvCache,
          ], 'popular'),
        );
      });

      /// Jika cache ada → return list tvSeries.
      test('should return list of movies from db when data exist', () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheTvSeries('popular'),
        ).thenAnswer((_) async => [testTvCacheMap]);

        // act
        final result = await localDataSource.getCachedPopularTv();

        // assert
        expect(result, [testTvCache]);
      });

      /// Jika cache kosong → lempar CacheException.
      test(
        'should throw CacheException when cache data is not exist',
        () async {
          // arrange
          when(
            mockDatabaseHelper.getCacheTvSeries('popular'),
          ).thenAnswer((_) async => []);

          // act
          final call = localDataSource.getCachedPopularTv();

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
        when(mockRemoteDataSource.getPopularTv()).thenAnswer((_) async => []);

        // act (Aksi dalam Skenario Pengujian)
        await repository.getPopularTv();

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
          // Ketika mockRemoteDataSource.getPopularTv dijalankan maka
          // jawabannya hasil response (Ini mensimulasikan respons sukses dari server)
          when(
            mockRemoteDataSource.getPopularTv(),
          ).thenAnswer((_) async => tTvSeriesModelList);

          // act
          // Melakukan aksi/memanggil fungsi yang akan diuji kemudian disimpan di variabel
          final result = await repository.getPopularTv();

          // assert
          //  memastikan bahwa sebuah metode mock (tiruan) dipanggil saat test dijalankan.
          verify(mockRemoteDataSource.getPopularTv());
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
            mockRemoteDataSource.getPopularTv(),
          ).thenAnswer((_) async => tTvSeriesModelList);
          // act
          await repository.getPopularTv();
          // assert
          verify(mockRemoteDataSource.getPopularTv());
          verify(mockLocalDataSource.cachePopularTvSeries([testTvCache]));
        },
      );

      /// Remote gagal
      /// Jika terjadi ServerException, return Left(ServerFailure).
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getPopularTv(),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getPopularTv();
          // assert
          verify(mockRemoteDataSource.getPopularTv());
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
          mockLocalDataSource.getCachedPopularTv(),
        ).thenAnswer((_) async => [testTvCache]);

        // act
        // panggil method yang akan di uji dan simpan nilai kembaliannya ke dalam sebuah variabel.
        final result = await repository.getPopularTv();

        // assert
        // masukkan ekspektasi pengujian yang diharapkan. Kita ingin memastikan
        // localDataSource.getCachedPopularTv() dipanggil lalu nilai yang
        // dikembalikan juga sesuai.
        verify(mockLocalDataSource.getCachedPopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      /// ketika tidak ada data di dalam cache
      /// Jika cache kosong → return Left(CacheFailure).
      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedPopularTv(),
        ).thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getPopularTv();
        // assert
        verify(mockLocalDataSource.getCachedPopularTv());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Tv Detail', () {
    final tId = 1;
    final tTvDetailResponse = TvDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      createdBy: [
        CreatedByModel(
          id: 1,
          creditId: "creditId",
          name: "name",
          originalName: "originalName",
          gender: 1,
          profilePath: "profilePath",
        ),
      ],
      episodeRunTime: [1],
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: 'homepage',
      id: tId,
      inProduction: false,
      languages: [],
      lastAirDate: 'lastAirDate',
      lastEpisodeToAir: EpisodeToAirModel(
        id: 1,
        name: 'name',
        overview: 'overview',
        voteAverage: 1.0,
        voteCount: 1,
        airDate: 'airDate',
        episodeNumber: 1,
        episodeType: 'episodeType',
        productionCode: 'productionCode',
        runtime: 1,
        seasonNumber: 1,
        showId: 1,
        stillPath: 'stillPath',
      ),
      name: 'name',
      nextEpisodeToAir: EpisodeToAirModel(
        id: 1,
        name: 'name',
        overview: 'overview',
        voteAverage: 1.0,
        voteCount: 1,
        airDate: 'airDate',
        episodeNumber: 1,
        episodeType: 'episodeType',
        productionCode: 'productionCode',
        runtime: 1,
        seasonNumber: 1,
        showId: 1,
        stillPath: 'stillPath',
      ),
      networks: [
        ProductionCompaniesModel(
          id: 1,
          logoPath: 'logoPath',
          name: 'name',
          originCountry: 'originCountry',
        ),
      ],
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 2.0,
      posterPath: 'posterPath',
      productionCompanies: [
        ProductionCompaniesModel(
          id: 1,
          logoPath: 'logoPath',
          name: 'name',
          originCountry: 'originCountry',
        ),
      ],
      seasons: [
        SeasonModel(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
          voteAverage: 1.0,
        ),
      ],
      status: 'status',
      tagline: 'tagline',
      voteAverage: 1,
      voteCount: 1,
    );

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      /// Memeriksa apakah aplikasi terhubung dengan internet?
      test('should check if the device is online', () async {
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.getTvDetail(tId),
        ).thenAnswer((_) async => tTvDetailResponse);

        // Act
        await repository.getTvDetail(tId);

        // Assert
        verify(mockNetworkInfo.isConnected);
      });

      test(
        'should return TvDetail data when the call to remote data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTvDetail(tId),
          ).thenAnswer((_) async => tTvDetailResponse);
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Right(testTvDetail)));
        },
      );

      test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTvDetail(tId),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return connection failure when the device is not connected to internet',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTvDetail(tId),
          ).thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvDetail(tId));
          expect(
            result,
            equals(Left(ConnectionFailure('Failed to connect to the network'))),
          );
        },
      );
    });
  });

  group('Get Tv Recommendations', () {
    final tTvSeriesList = <TvModel>[];
    final tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(
        mockRemoteDataSource.getTvRecommendations(tId),
      ).thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvRecommendations(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTvRecommendations(tId);
        // assertbuild runner
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTvRecommendations(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getTvRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getTvRecommendations(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Search TvSeries', () {
    final tQuery = 'gutezeiten';

    test(
      'should return tv list when call to data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      },
    );

    test(
      'should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenThrow(ServerException());
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchTvSeries(tQuery),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.searchTvSeries(tQuery);
        // assert
        expect(
          result,
          Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(testTvTable),
      ).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(testTvTable),
      ).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testTvTable),
      ).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testTvTable),
      ).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watchlist status whether data is found', () async {
      // arrange
      final tId = 1;
      when(
        mockLocalDataSource.getTvSeriesById(tId),
      ).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeries', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlistTv(),
      ).thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
