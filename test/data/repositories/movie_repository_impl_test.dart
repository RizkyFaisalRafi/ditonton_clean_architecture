import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ditonton_clean_architecture/data/datasources/movies/movie_local_data_source.dart';
import 'package:ditonton_clean_architecture/data/models/genre_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_detail_model.dart';
import 'package:ditonton_clean_architecture/data/models/movies/movie_model.dart';
import 'package:ditonton_clean_architecture/data/repositories/movie_repository_impl.dart';
import 'package:ditonton_clean_architecture/common/exception.dart';
import 'package:ditonton_clean_architecture/common/failure.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  // SetUp
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    // deklarasi MockNetworkInfo dan inisialisasikan
    mockNetworkInfo = MockNetworkInfo();
    mockDatabaseHelper = MockDatabaseHelper();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {
    /// Test Cache Local
    group('cache now playing movies', () {
      late MovieLocalDataSourceImpl localDataSource;

      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
        localDataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
      });

      /**
       * Menguji apakah method cacheNowPlayingMovies() menyimpan data ke local database.
       * Verifikasi bahwa clearCache dan insertCacheTransaction terpanggil.
       */
      test('should call database helper to save data', () async {
        // arrange
        when(
          mockDatabaseHelper.clearCache('now playing'),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'now playing'),
        ).thenAnswer((_) async => {});

        final dataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
        // act
        await dataSource.cacheNowPlayingMovies([testMovieCache]);

        // assert
        verify(mockDatabaseHelper.clearCache('now playing'));
        verify(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'now playing'),
        );
      });

      /// Jika cache ada → return list movie.
      test('should return list of movies from db when data exist', () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('now playing'),
        ).thenAnswer((_) async => [testMovieCacheMap]);

        // act
        final result = await localDataSource.getCachedNowPlayingMovies();

        // assert
        expect(result, [testMovieCache]);
      });

      /// Jika cache kosong → lempar CacheException.
      test(
        'should throw CacheException when cache data is not exist',
        () async {
          // arrange
          when(
            mockDatabaseHelper.getCacheMovies('now playing'),
          ).thenAnswer((_) async => []);

          // act
          final call = localDataSource.getCachedNowPlayingMovies();

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
        // Menggunakan Mocking dan Stubbing
        // Mocking berarti kita membuat objek palsu atau pengganti.
        // Teknik mocking ini sangat berguna ketika kita ingin menguji suatu fungsi atau objek
        // Stubbing mirip dengan mocking, bedanya yang dipalsukan adalah perilaku dari objeknya.
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.getNowPlayingMovies(),
        ).thenAnswer((_) async => []);

        // act (Aksi dalam Skenario Pengujian)
        await repository.getNowPlayingMovies();

        // assert (Assert adalah memvalidasi nilai atau aksi yang diekspektasikan)
        // ingin memverifikasi bahwa telah dilakukan pengecekan apakah aplikasi terhubung ke internet.
        verify(mockNetworkInfo.isConnected);
        //   Fungsi verify() merupakan fungsi dari package mockito untuk memverifikasi apakah suatu method dieksekusi.
      });

      /// Jika sukses ambil data dari API, kembalikan hasil Right<List<Movie>>.
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          // Ketika mockRemoteDataSource.getNowPlayingMovies dijalankan maka
          // jawabannya hasil response (Ini mensimulasikan respons sukses dari server)
          when(
            mockRemoteDataSource.getNowPlayingMovies(),
          ).thenAnswer((_) async => tMovieModelList);

          // act
          // Melakukan aksi/memanggil fungsi yang akan diuji kemudian disimpan di variabel
          final result = await repository.getNowPlayingMovies();

          // assert
          //  memastikan bahwa sebuah metode mock (tiruan) dipanggil saat test dijalankan.
          verify(mockRemoteDataSource.getNowPlayingMovies());
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
          expect(resultList, tMovieList);
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
            mockRemoteDataSource.getNowPlayingMovies(),
          ).thenAnswer((_) async => tMovieModelList);
          // act
          await repository.getNowPlayingMovies();
          // assert
          verify(mockRemoteDataSource.getNowPlayingMovies());
          verify(mockLocalDataSource.cacheNowPlayingMovies([testMovieCache]));
        },
      );

      /// Remote gagal
      /// Jika terjadi ServerException, return Left(ServerFailure).
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getNowPlayingMovies(),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingMovies();
          // assert
          verify(mockRemoteDataSource.getNowPlayingMovies());
          expect(result, equals(Left(ServerFailure(''))));
        },
      );
    });

    /// Skenario Jika Offline
    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      // Saat ini kita mengembalikan ConnectionFailure ketika tidak terhubung
      // ke internet. Karena kebutuhan aplikasi berubah, skenario ini sudah tidak
      // digunakan dan bisa digantikan dengan skenario baru.
      // Sudah di handle Cache
      // test(
      //   'should return connection failure when the device is not connected to internet',
      //   () async {
      //     // arrange
      //     when(
      //       mockRemoteDataSource.getNowPlayingMovies(),
      //     ).thenThrow(SocketException('Failed to connect to the network'));
      //     // act
      //     final result = await repository.getNowPlayingMovies();
      //     // assert
      //     verify(mockRemoteDataSource.getNowPlayingMovies());
      //     expect(
      //       result,
      //       equals(Left(ConnectionFailure('Failed to connect to the network'))),
      //     );
      //   },
      // );

      /// Saat offline, ambil data dari local cache.
      /// Hasil berupa Right<List<Movie>>.
      test('should return cached data when device is offline', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedNowPlayingMovies(),
        ).thenAnswer((_) async => [testMovieCache]);

        // act
        // panggil method yang akan di uji dan simpan nilai kembaliannya ke dalam sebuah variabel.
        final result = await repository.getNowPlayingMovies();

        // assert
        // masukkan ekspektasi pengujian yang diharapkan. Kita ingin memastikan
        // localDataSource.getCachedNowPlayingMovies() dipanggil lalu nilai yang
        // dikembalikan juga sesuai.
        verify(mockLocalDataSource.getCachedNowPlayingMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      /// ketika tidak ada data di dalam cache
      /// Jika cache kosong → return Left(CacheFailure).
      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedNowPlayingMovies(),
        ).thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getNowPlayingMovies();
        // assert
        verify(mockLocalDataSource.getCachedNowPlayingMovies());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Popular Movies', () {
    /// Test Cache Local
    group('cache popular movies', () {
      late MovieLocalDataSourceImpl localDataSource;

      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
        localDataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
      });

      /**
       * Menguji apakah method cacheNowPlayingMovies() menyimpan data ke local database.
       * Verifikasi bahwa clearCache dan insertCacheTransaction terpanggil.
       */
      test('should call database helper to save data', () async {
        // arrange
        when(
          mockDatabaseHelper.clearCache('popular'),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'popular'),
        ).thenAnswer((_) async => {});

        final dataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
        // act
        await dataSource.cachePopularMovies([testMovieCache]);

        // assert
        verify(mockDatabaseHelper.clearCache('popular'));
        verify(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'popular'),
        );
      });

      /// Jika cache ada → return list movie.
      test('should return list of movies from db when data exist', () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('popular'),
        ).thenAnswer((_) async => [testMovieCacheMap]);

        // act
        final result = await localDataSource.getCachedPopularMovies();

        // assert
        expect(result, [testMovieCache]);
      });

      /// Jika cache kosong → lempar CacheException.
      test(
        'should throw CacheException when cache data is not exist',
        () async {
          // arrange
          when(
            mockDatabaseHelper.getCacheMovies('popular'),
          ).thenAnswer((_) async => []);

          // act
          final call = localDataSource.getCachedPopularMovies();

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
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.getPopularMovies(),
        ).thenAnswer((_) async => []);

        // Act
        await repository.getPopularMovies();

        // Assert
        verify(mockNetworkInfo.isConnected);
      });

      // Jika sukses ambil data dari API, kembalikan hasil Right<List<Movie>>.
      test(
        'should return movie list when call to data source is success',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getPopularMovies(),
          ).thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.getPopularMovies();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
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
            mockRemoteDataSource.getPopularMovies(),
          ).thenAnswer((_) async => tMovieModelList);

          // act
          await repository.getPopularMovies();

          // assert
          verify(mockRemoteDataSource.getPopularMovies());
          verify(mockLocalDataSource.cachePopularMovies([testMovieCache]));
        },
      );

      /// Remote gagal
      /// Jika terjadi ServerException, return Left(ServerFailure).
      test(
        'should return server failure when call to data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getPopularMovies(),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getPopularMovies();
          // assert
          expect(result, Left(ServerFailure('')));
        },
      );
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      // test(
      //   'should return connection failure when device is not connected to the internet',
      //   () async {
      //     // arrange
      //     when(
      //       mockRemoteDataSource.getPopularMovies(),
      //     ).thenThrow(SocketException('Failed to connect to the network'));
      //     // act
      //     final result = await repository.getPopularMovies();
      //     // assert
      //     expect(
      //       result,
      //       Left(ConnectionFailure('Failed to connect to the network')),
      //     );
      //   },
      // );

      /// Saat offline, ambil data dari local cache.
      /// Hasil berupa Right<List<Movie>>.
      test('should return cached data when device is offline', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedPopularMovies(),
        ).thenAnswer((_) async => [testMovieCache]);

        // act
        // panggil method yang akan di uji dan simpan nilai kembaliannya ke dalam sebuah variabel.
        final result = await repository.getPopularMovies();

        // assert
        // masukkan ekspektasi pengujian yang diharapkan. ingin memastikan
        // localDataSource.getCachedNowPlayingMovies() dipanggil lalu nilai yang
        // dikembalikan juga sesuai.
        verify(mockLocalDataSource.getCachedPopularMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      /// ketika tidak ada data di dalam cache
      /// Jika cache kosong → return Left(CacheFailure).
      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedPopularMovies(),
        ).thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getPopularMovies();
        // assert
        verify(mockLocalDataSource.getCachedPopularMovies());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Top Rated Movies', () {
    group('cache top rated movies', () {
      late MovieLocalDataSourceImpl localDataSource;

      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
        localDataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
      });
      /**
       * Menguji apakah method cacheNowPlayingMovies() menyimpan data ke local database.
       * Verifikasi bahwa clearCache dan insertCacheTransaction terpanggil.
       */
      test('should call database helper to save data', () async {
        // arrange
        when(
          mockDatabaseHelper.clearCache('top rated'),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'top rated'),
        ).thenAnswer((_) async => {});

        final dataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
        // act
        await dataSource.cacheTopRatedMovies([testMovieCache]);

        // assert
        verify(mockDatabaseHelper.clearCache('top rated'));
        verify(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'top rated'),
        );
      });

      /// Jika cache ada → return list movie.
      test('should return list of movies from db when data exist', () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('top rated'),
        ).thenAnswer((_) async => [testMovieCacheMap]);

        // act
        final result = await localDataSource.getCachedTopRatedMovies();

        // assert
        expect(result, [testMovieCache]);
      });

      /// Jika cache kosong → lempar CacheException.
      test(
        'should throw CacheException when cache data is not exist',
        () async {
          // arrange
          when(
            mockDatabaseHelper.getCacheMovies('top rated'),
          ).thenAnswer((_) async => []);

          // act
          final call = localDataSource.getCachedTopRatedMovies();

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
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.getTopRatedMovies(),
        ).thenAnswer((_) async => []);

        // Act
        await repository.getTopRatedMovies();

        // Assert
        verify(mockNetworkInfo.isConnected);
      });

      test(
        'should return movie list when call to data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTopRatedMovies(),
          ).thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.getTopRatedMovies();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
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
            mockRemoteDataSource.getTopRatedMovies(),
          ).thenAnswer((_) async => tMovieModelList);
          // act
          await repository.getTopRatedMovies();
          // assert
          verify(mockRemoteDataSource.getTopRatedMovies());
          verify(mockLocalDataSource.cacheTopRatedMovies([testMovieCache]));
        },
      );

      test(
        'should return ServerFailure when call to data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getTopRatedMovies(),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedMovies();
          // assert
          expect(result, Left(ServerFailure('')));
        },
      );
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      // test(
      //   'should return ConnectionFailure when device is not connected to the internet',
      //       () async {
      //     // arrange
      //     when(
      //       mockRemoteDataSource.getTopRatedMovies(),
      //     ).thenThrow(SocketException('Failed to connect to the network'));
      //     // act
      //     final result = await repository.getTopRatedMovies();
      //     // assert
      //     expect(
      //       result,
      //       Left(ConnectionFailure('Failed to connect to the network')),
      //     );
      //   },
      // );

      /// Saat offline, ambil data dari local cache.
      /// Hasil berupa Right<List<Movie>>.
      test('should return cached data when device is offline', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedTopRatedMovies(),
        ).thenAnswer((_) async => [testMovieCache]);

        // act
        // panggil method yang akan di uji dan simpan nilai kembaliannya ke dalam sebuah variabel.
        final result = await repository.getTopRatedMovies();

        // assert
        // masukkan ekspektasi pengujian yang diharapkan. ingin memastikan
        // localDataSource.getCachedNowPlayingMovies() dipanggil lalu nilai yang
        // dikembalikan juga sesuai.
        verify(mockLocalDataSource.getCachedTopRatedMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      /// ketika tidak ada data di dalam cache
      /// Jika cache kosong → return Left(CacheFailure).
      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedTopRatedMovies(),
        ).thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getTopRatedMovies();
        // assert
        verify(mockLocalDataSource.getCachedTopRatedMovies());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Up Coming Movies', () {
    group('cache up coming movies', () {
      late MovieLocalDataSourceImpl localDataSource;

      setUp(() {
        mockDatabaseHelper = MockDatabaseHelper();
        localDataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
      });

      /**
       * Menguji apakah method cacheNowPlayingMovies() menyimpan data ke local database.
       * Verifikasi bahwa clearCache dan insertCacheTransaction terpanggil.
       */
      test('should call database helper to save data', () async {
        // arrange
        when(
          mockDatabaseHelper.clearCache('up coming'),
        ).thenAnswer((_) async => 1);
        when(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'up coming'),
        ).thenAnswer((_) async => {});

        final dataSource = MovieLocalDataSourceImpl(
          databaseHelper: mockDatabaseHelper,
        );
        // act
        await dataSource.cacheUpComingMovies([testMovieCache]);

        // assert
        verify(mockDatabaseHelper.clearCache('up coming'));
        verify(
          mockDatabaseHelper.insertCacheTransaction([
            testMovieCache,
          ], 'up coming'),
        );
      });

      /// Jika cache ada → return list movie.
      test('should return list of movies from db when data exist', () async {
        // arrange
        when(
          mockDatabaseHelper.getCacheMovies('up coming'),
        ).thenAnswer((_) async => [testMovieCacheMap]);

        // act
        final result = await localDataSource.getCachedUpComingMovies();

        // assert
        expect(result, [testMovieCache]);
      });

      /// Jika cache kosong → lempar CacheException.
      test(
        'should throw CacheException when cache data is not exist',
        () async {
          // arrange
          when(
            mockDatabaseHelper.getCacheMovies('up coming'),
          ).thenAnswer((_) async => []);

          // act
          final call = localDataSource.getCachedUpComingMovies();

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
        // Arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(
          mockRemoteDataSource.getUpComingMovies(),
        ).thenAnswer((_) async => []);

        // Act
        await repository.getUpComingMovies();

        // Assert
        verify(mockNetworkInfo.isConnected);
      });

      test(
        'should return movie list when call to data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getUpComingMovies(),
          ).thenAnswer((_) async => tMovieModelList);
          // act
          final result = await repository.getUpComingMovies();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
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
            mockRemoteDataSource.getUpComingMovies(),
          ).thenAnswer((_) async => tMovieModelList);
          // act
          await repository.getUpComingMovies();
          // assert
          verify(mockRemoteDataSource.getUpComingMovies());
          verify(mockLocalDataSource.cacheUpComingMovies([testMovieCache]));
        },
      );

      test(
        'should return ServerFailure when call to data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getUpComingMovies(),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getUpComingMovies();
          // assert
          expect(result, Left(ServerFailure('')));
        },
      );
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      // test(
      //   'should return ConnectionFailure when device is not connected to the internet',
      //   () async {
      //     // arrange
      //     when(
      //       mockRemoteDataSource.getUpComingMovies(),
      //     ).thenThrow(SocketException('Failed to connect to the network'));
      //     // act
      //     final result = await repository.getUpComingMovies();
      //     // assert
      //     expect(
      //       result,
      //       Left(ConnectionFailure('Failed to connect to the network')),
      //     );
      //   },
      // );

      /// Saat offline, ambil data dari local cache.
      /// Hasil berupa Right<List<Movie>>.
      test('should return cached data when device is offline', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedUpComingMovies(),
        ).thenAnswer((_) async => [testMovieCache]);

        // act
        // panggil method yang akan di uji dan simpan nilai kembaliannya ke dalam sebuah variabel.
        final result = await repository.getUpComingMovies();

        // assert
        // masukkan ekspektasi pengujian yang diharapkan. ingin memastikan
        // localDataSource.getCachedNowPlayingMovies() dipanggil lalu nilai yang
        // dikembalikan juga sesuai.
        verify(mockLocalDataSource.getCachedUpComingMovies());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      /// ketika tidak ada data di dalam cache
      /// Jika cache kosong → return Left(CacheFailure).
      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(
          mockLocalDataSource.getCachedUpComingMovies(),
        ).thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getUpComingMovies();
        // assert
        verify(mockLocalDataSource.getCachedUpComingMovies());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
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
          mockRemoteDataSource.getMovieDetail(tId),
        ).thenAnswer((_) async => tMovieResponse);

        // Act
        await repository.getMovieDetail(tId);

        // Assert
        verify(mockNetworkInfo.isConnected);
      });

      test(
        'should return Movie data when the call to remote data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getMovieDetail(tId),
          ).thenAnswer((_) async => tMovieResponse);
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getMovieDetail(tId));
          expect(result, equals(Right(testMovieDetail)));
        },
      );

      test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getMovieDetail(tId),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getMovieDetail(tId));
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
            mockRemoteDataSource.getMovieDetail(tId),
          ).thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getMovieDetail(tId);
          // assert
          verify(mockRemoteDataSource.getMovieDetail(tId));
          expect(
            result,
            equals(Left(ConnectionFailure('Failed to connect to the network'))),
          );
        },
      );
    });
  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful', () async {
      // arrange
      when(
        mockRemoteDataSource.getMovieRecommendations(tId),
      ).thenAnswer((_) async => tMovieList);
      // act
      final result = await repository.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
      'should return server failure when call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMovieRecommendations(tId),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getMovieRecommendations(tId);
        // assertbuild runner
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getMovieRecommendations(tId),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.getMovieRecommendations(tId);
        // assert
        verify(mockRemoteDataSource.getMovieRecommendations(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('Seach Movies', () {
    final tQuery = 'spiderman';

    test(
      'should return movie list when call to data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenAnswer((_) async => tMovieModelList);
        // act
        final result = await repository.searchMovies(tQuery);
        // assert
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      },
    );

    test(
      'should return ServerFailure when call to data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenThrow(ServerException());
        // act
        final result = await repository.searchMovies(tQuery);
        // assert
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to the internet',
      () async {
        // arrange
        when(
          mockRemoteDataSource.searchMovies(tQuery),
        ).thenThrow(SocketException('Failed to connect to the network'));
        // act
        final result = await repository.searchMovies(tQuery);
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
        mockLocalDataSource.insertWatchlist(testMovieTable),
      ).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(testMovieTable),
      ).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testMovieTable),
      ).thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testMovieTable),
      ).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlistMovies(),
      ).thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });
}
