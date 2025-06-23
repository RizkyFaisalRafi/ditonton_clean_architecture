# a199-flutter-expert-project

[//]: # (# Github: https://github.com/RizkyFaisalRafi/a199-flutter-expert-project)

[//]: # (# [![Codemagic build status]&#40;https://api.codemagic.io/apps/6379c4a01063f44db75df13a/6379c4a01063f44db75df139/status_badge.svg&#41;]&#40;https://codemagic.io/apps/6379c4a01063f44db75df13a/6379c4a01063f44db75df139/latest_build&#41;)

Repository ini merupakan project awal dan akhir submission kelas Flutter Expert Dicoding Indonesia 2025.

---
Negative Case:
Search

- When Loading Data Add Lottie (Movie Tv) Done TV Movie
- When Search Query Not Found (Movie, Tv) Done TV Movie
- When Search Empty Query (Movie, Tv) Done TV Movie
- When Search Invalid Characters Query (Movie, Tv) Done TV Movie
- When Search No Internet (Movie, Tv) Done TV Movie
- When Search Error All Status Code (Movie, Tv) Done TV Movie

Load Data Movie and TV Series

- Refresh Page (Done Movie, TV)
- Pagination / Infinite Scrolling (Done Movie TV)
- When Load Data Failed Error No Connection (Done Movie TV)
- When Load Data Failed Error Empty Data (Done Movie TV)
- When Load Data Failed Error API/Cached Error (Done Movie TV)

SeeMore Movies

- Refresh Page (Done Popular, Top Rated, Up Coming)
- Pagination / Infinite Scrolling (Done Popular, Top Rated, Up Coming)
- When Load Data Failed Error Empty Data (Done Popular, Top Rated, Up Coming)
- When Load Data Failed Error No Connection (Handle di Cache)
- When Load Data Failed Error API/Cached Error (Done Popular, Top Rated, Up Coming)

SeeMore TV Series

- Refresh Page (Done On The Air, Popular, Top Rated)
- Pagination / Infinite Scrolling (Done On The Air, Popular, Top Rated)
- When Load Data Failed Error Empty Data (Done On The Air, Popular, Top Rated)
- When Load Data Failed Error No Connection (Handle di Cache)
- When Load Data Failed Error API/Cached Error (Done On The Air, Popular, Top Rated)

DetailPage

- Refresh Page (Done Movie TV)
- When Load Data Failed Error No Connection (Done Movie TV)
- When Load Data Failed Error Other Status Code (Done Movie TV)

Watchlist Movie TV

- When Watchlist Data Empty Add Lottie Animation (Done Movie TV)
- When Watchlist Data Error Database (Done Movie TV)

Data Local / Cache SQFLite

- List Movie and TV (Done)
- Watchlist Movie and TV (Done)
- Detail Page Movie And TV (Movie Done, TV Done)

Run in Git Bash for Coverage
Coverage App:

- flutter clean
- flutter pub get
- dart run build_runner build --delete-conflicting-outputs
- flutter test --machine > tests.output
- flutter test --coverage
- genhtml coverage/lcov.info -o coverage/html --legend -t "Clean Architecture Submission Awal
  Expert (Faisal)" --function-coverage

## Ketentuaan Submission Awal

- Menampilkan TV series populer, top rated, dan sedang tayang pada satu halaman utama.
- Menampilkan daftar TV series populer, top rated, dan sedang tayang masing-masing pada satu halaman
  sendiri.
- Aplikasi harus menampilkan detail TV Series berdasarkan item yang dipilih
    - Halaman detail menampilkan poster, judul, rating, dan sinopsis.
    - Halaman detail menampilkan rekomendasi TV series lainnya.
- Fitur pencarian berdasarkan judul dengan memanfaatkan API
- Menambahkan daftar TV series yang ingin ditonton ke dalam suatu daftar yang disimpan secara lokal.
  Daftar watchlist harus tetap bertahan meskipun aplikasi ditutup dan dibuka kembali.
- Fitur yang dikembangkan harus memiliki unit testing dengan minimal testing coverage 70%.
- Menerapkan Clean Architecture
- Menampilkan Informasi Season & Episode
- Menambahkan Widget & Integration Test

## Ketentuaan Submission Akhir

- Menerapkan Continuous Integration (Done)
- Menggunakan Library BLoC (Done)
  - lib
    - presentation/bloc
      - Movie List (Merge) (Done)
      - Movie Search (Done)
      - TvSeries List (Done)
        - AiringTodayTv
        - OnTheAirTv
        - PopularTv
        - TopRatedTv
      - Tv Search (Done)
      - MovieDetail (Done)
      - TvDetail (Done)
      - SeeMorePopularMovieBloc (Done)
      - SeeMoreTopRatedMovieBloc (Done)
      - SeeMoreUpComingMovieBloc (Done)
      - WatchlistMovieBloc (Process)
      
    - presentation/pages
      - HomeMoviePage (Done)
      - SearchMoviePage (Done)
      - SearchTvPage (Done)
      - TvSeriesPage (Done)
      - MovieDetailPage (Done)
      - TvSeriesDetailPage (Done)
      - PopularMoviesPage (SeeMore) (Done)
      - TopRatedMoviesPage (SeeMore) (Done)
      - UpComingMoviesPage (SeeMore) (Done)
      - WatchlistMoviesPage (Process)


      - OnTheAirTvPage (SeeMore)
      - PopularTvPage (SeeMore)
      - TopRatedTvPage (SeeMore)
      - WatchlistTvPage
    
  - Testing
    - presentation/bloc
      - MovieListBloc (Merge) (Done)
      - MovieSearchBloc (Done)
      - TvSeries List (Done)
        - AiringTodayTvBlocTest
        - OnTheAirTvBlocTest
        - PopularTvBlocTest
        - TopRatedTvBlocTest
      - TvSearchBlocTest (Done)
      - MovieDetailBlocTest (Done)
      - TvDetailBlocTest (Done)
      - SeeMorePopularMovieBlocTest (Done)
      - SeeMoreTopRatedMovieBlocTest (Done)
      - SeeMoreUpComingMovieBlocTest (Done)
      - WatchlistMovieBlocTest (Process)
      
    - presentation/pages
      - HomeMoviePageTest
      - SearchMoviePageTest
      - SearchTvPageTest (Done)
      - TvSeriesPageTest (Done)
      - MovieDetailPageTest (Done)
      - TvSeriesDetailPage (Done)
      - PopularMoviesPageTest (SeeMore) (Done)
      - TopRatedMoviesPageTest (SeeMore) (Done)
      - UpComingMoviesPageTest (SeeMore) (Done)
      - WatchlistMoviesPage (Process)

      - OnTheAirTvPage (SeeMore)
      - PopularTvPage (SeeMore)
      - TopRatedTvPage (SeeMore)
      - WatchlistTvPage

- Menerapkan SSL Pinning
- Integrasi dengan Firebase Analytics & Crashlytics
- Modularisasi, Membagi aplikasi menjadi modul setidaknya untuk dua fitur movie & TV series(
  Optional)

## Tips Submission Awal

Pastikan untuk memeriksa kembali seluruh hasil testing pada submissionmu sebelum dikirimkan. Karena
kriteria pada submission ini akan diperiksa setelah seluruh berkas testing berhasil dijalankan.

## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository
ini. Berkas tersebut dapat mempermudah proses testing melalui *terminal* atau *command prompt*.
Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:

1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.
    - Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.
        ```
        sudo apt-get update -qq -y
        sudo apt-get install lcov -y
        ```

    - Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.
        ```
        brew install lcov
        ```
    - Bagi pengguna **Windows**, ikuti langkah berikut.
        - Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
        - Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan
          menjalankan perintah berikut.
            ```
            choco install lcov
            ```
        - Kemudian cek **Environtment Variabel** pada kolom **System variabels** terdapat variabel
          GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan
          nilai seperti berikut.
          | Variable | Value|
          | ----------- | ----------- |
          | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
          | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |

2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.
    ```
    git init
    ```
3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada *terminal* atau *powershell*.
    ```
    test.sh
    ```
   atau
    ```
    ./test.sh
    ```
   Proses ini akan men-*generate* berkas `lcov.info` dan folder `coverage` terkait dengan laporan
   coverage.
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.

