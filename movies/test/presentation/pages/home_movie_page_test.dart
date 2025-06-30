import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movies/module/movies.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/test_helper_movie.mocks.dart';

void main() {
  late MockMovieListBloc mockMovieListBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    // Inisialisasi mock objects sebelum setiap tes
    mockMovieListBloc = MockMovieListBloc();
    mockNavigatorObserver = MockNavigatorObserver();

    // Memberikan respons null ketika getter 'navigator' dipanggil
    when(mockNavigatorObserver.navigator).thenReturn(null);
  });

  // Fungsi helper untuk stub state dan stream dari BLoC
  void arrangeBlocsState(MovieListState movieListState) {
    // Stub stream (diperlukan agar BlocBuilder tidak error)
    when(
      mockMovieListBloc.stream,
    ).thenAnswer((_) => Stream.value(movieListState));

    // Stub state awal
    when(mockMovieListBloc.state).thenReturn(movieListState);
  }

  // Helper function untuk membuat widget yang bisa ditest
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieListBloc>.value(
      value: mockMovieListBloc,
      child: MaterialApp(
        home: body,
        // Daftarkan route yang akan dituju untuk verifikasi navigasi
        routes: {
          searchMovieRoute: (_) => const Scaffold(body: Text('Search Movie')),
          popularMovieRoute:
              (_) => const Scaffold(body: Text('Popular Movies')),
          topRatedMovieRoute:
              (_) => const Scaffold(body: Text('Top Rated Movies')),
          upComingMovieRoute:
              (_) => const Scaffold(body: Text('Up Coming Movies')),
          movieDetailRoute: (context) => const Scaffold(body: Text('Overview')),
        },
        // Gunakan mockNavigatorObserver untuk melacak event navigasi
        navigatorObservers: [mockNavigatorObserver],
      ),
    );
  }

  group('Home Movie Page', () {
    /// Loading
    testWidgets('Page should display loading indicator when state is Loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Atur state awal BLoC ke Loading
      arrangeBlocsState(MovieListState.loadingMovieList());

      // Act
      // Render widget
      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      // Assert
      // Verifikasi
      expect(find.byKey(Key('loading_bar_lottie')), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
    });

    /// Loaded
    testWidgets('Page should display ListView when data is loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      arrangeBlocsState(
        MovieListState.loadedMovieList(
          nowPlaying: testMovieList,
          popular: testMovieList,
          topRated: testMovieList,
          upcoming: testMovieList,
          nowPlayingPage: 1,
          popularPage: 1,
          topRatedPage: 1,
          upcomingPage: 1,
          hasMoreNowPlaying: false,
          hasMorePopular: false,
          hasMoreTopRated: false,
          hasMoreUpcoming: false,
        ),
      );

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
        await tester.pump();
        // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
        // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
        await tester.pump(const Duration(seconds: 1));
      });

      // Assert
      // Verifikasi bahwa teks judul, key setiap seksi ditampilkan
      expect(find.text('Now Playing'), findsOneWidget);
      expect(find.byKey(const Key('now_playing_list')), findsOneWidget);

      expect(find.text('Popular'), findsOneWidget);
      expect(find.byKey(const Key('popular_list')), findsOneWidget);

      expect(find.text('Top Rated'), findsOneWidget);
      expect(find.byKey(const Key('top_rated_list')), findsOneWidget);

      expect(find.text('Upcoming'), findsOneWidget);
      expect(find.byKey(const Key('up_coming_list')), findsOneWidget);

      // Verifikasi bahwa semua MovieList (ada 4) ditampilkan
      expect(find.byType(MovieList), findsNWidgets(4));
      expect(find.byType(ListView), findsNWidgets(4));
    });

    /// Error
    testWidgets('Page should display error widget when state is Error', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Atur state BLoC ke Error
      const errorMessage = 'Server Failure';
      arrangeBlocsState(const MovieListState.errorMovieList(errorMessage));

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
        await tester.pump();
        // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
        // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
        await tester.pump(const Duration(seconds: 1));
      });

      // Assert
      // Verifikasi
      expect(find.byType(ErrorStateWidget2), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });

    /// Error - No Connection
    testWidgets(
      'Page should display no connection widget for specific error message',
      (WidgetTester tester) async {
        // Arrange
        // Atur state BLoC ke Error dengan pesan koneksi
        arrangeBlocsState(
          const MovieListState.errorMovieList(
            'Failed to connect to the network',
          ),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
          await tester.pump();
          // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
          // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
          await tester.pump(const Duration(seconds: 1));
        });

        // Assert
        // Verifikasi widget no connection ditampilkan
        expect(find.text('No Internet Connection!'), findsOneWidget);
        expect(find.byType(Lottie), findsOneWidget);
      },
    );

    /// Tap Search Icon - Navigate to Search Page
    testWidgets('Tapping the search icon should navigate to the search page', (
      WidgetTester tester,
    ) async {
      // Arrange
      // when(mockMovieListBloc.state).thenReturn(loadedState);
      // Stubbing untuk pemanggilan didPush
      // when(mockNavigatorObserver.didPush(any, any)).thenReturn(null);
      arrangeBlocsState(
        MovieListState.loadedMovieList(
          nowPlaying: [],
          popular: [],
          topRated: [],
          upcoming: [],
          nowPlayingPage: 1,
          popularPage: 1,
          topRatedPage: 1,
          upcomingPage: 1,
          hasMoreNowPlaying: false,
          hasMorePopular: false,
          hasMoreTopRated: false,
          hasMoreUpcoming: false,
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle(); // Tunggu animasi transisi selesai

      // Assert
      // Verifikasi bahwa metode push dipanggil pada navigator observer
      verify(mockNavigatorObserver.didPush(any, any));
      // Verifikasi bahwa route yang dituju adalah SearchMoviePage
      expect(find.text('Search Movie'), findsOneWidget);
    });

    /// Tap See More - Navigate to Popular Page
    testWidgets(
      'Tapping "See More" on Popular should navigate to the popular page',
      (WidgetTester tester) async {
        // Arrange
        // when(mockMovieListBloc.state).thenReturn(loadedState);
        // when(mockNavigatorObserver.didPush(any, any)).thenReturn(null);
        arrangeBlocsState(
          MovieListState.loadedMovieList(
            nowPlaying: [],
            popular: [],
            topRated: [],
            upcoming: [],
            nowPlayingPage: 1,
            popularPage: 1,
            topRatedPage: 1,
            upcomingPage: 1,
            hasMoreNowPlaying: false,
            hasMorePopular: false,
            hasMoreTopRated: false,
            hasMoreUpcoming: false,
          ),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
        // Cari InkWell dengan teks 'See More' dan tap
        await tester.tap(
          find.widgetWithText(InkWell, 'See More').at(0),
        ); // at(0) untuk Popular
        await tester.pumpAndSettle();

        // Assert
        verify(mockNavigatorObserver.didPush(any, any));
        expect(find.text('Popular Movies'), findsOneWidget);
      },
    );

    /// Tap See More - Navigate to Top Rated Page
    testWidgets(
      'Tapping "See More" on Top Rated should navigate to the top rated page',
      (WidgetTester tester) async {
        // Arrange
        // when(mockMovieListBloc.state).thenReturn(loadedState);
        // when(mockNavigatorObserver.didPush(any, any)).thenReturn(null);
        arrangeBlocsState(
          MovieListState.loadedMovieList(
            nowPlaying: [],
            popular: [],
            topRated: [],
            upcoming: [],
            nowPlayingPage: 1,
            popularPage: 1,
            topRatedPage: 1,
            upcomingPage: 1,
            hasMoreNowPlaying: false,
            hasMorePopular: false,
            hasMoreTopRated: false,
            hasMoreUpcoming: false,
          ),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
        // Cari InkWell dengan teks 'See More' dan tap
        await tester.tap(
          find.widgetWithText(InkWell, 'See More').at(1),
        ); // at(0) untuk Top Rated
        await tester.pumpAndSettle();

        // Assert
        verify(mockNavigatorObserver.didPush(any, any));
        expect(find.text('Top Rated Movies'), findsOneWidget);
      },
    );

    /// Tap See More - Navigate to Up Coming Page
    testWidgets(
      'Tapping "See More" on Up Coming should navigate to the up coming page',
      (WidgetTester tester) async {
        // Arrange
        // when(mockMovieListBloc.state).thenReturn(loadedState);
        // when(mockNavigatorObserver.didPush(any, any)).thenReturn(null);
        arrangeBlocsState(
          MovieListState.loadedMovieList(
            nowPlaying: [],
            popular: [],
            topRated: [],
            upcoming: [],
            nowPlayingPage: 1,
            popularPage: 1,
            topRatedPage: 1,
            upcomingPage: 1,
            hasMoreNowPlaying: false,
            hasMorePopular: false,
            hasMoreTopRated: false,
            hasMoreUpcoming: false,
          ),
        );

        final seeMoreButtonFinder = find
            .widgetWithText(InkWell, 'See More')
            .at(2);

        // Act
        await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

        // Scroll agar widget terlihat di layar
        await tester.ensureVisible(seeMoreButtonFinder);
        // await tester.pumpAndSettle();
        // 1. Mulai Beri waktu untuk scroll selesai
        await tester.pump();
        // 2. Beri waktu yang cukup agar animasi transisi halaman selesai.
        await tester.pump(const Duration(seconds: 1));

        // Cari InkWell dengan teks 'See More' dan tap
        await tester.tap(seeMoreButtonFinder); // at(2) untuk Up Coming
        await tester.pumpAndSettle();

        // Assert
        verify(mockNavigatorObserver.didPush(any, any));
        expect(find.text('Up Coming Movies'), findsOneWidget);
      },
    );

    /// Tap Movie Item - Navigate to Detail Page nowPlaying
    testWidgets('Tapping a movie item should navigate to the detail page', (
      WidgetTester tester,
    ) async {
      // Arrange
      // when(mockMovieListBloc.state).thenReturn(loadedState);
      arrangeBlocsState(
        MovieListState.loadedMovieList(
          nowPlaying: testMovieList,
          popular: [],
          topRated: [],
          upcoming: [],
          nowPlayingPage: 1,
          popularPage: 1,
          topRatedPage: 1,
          upcomingPage: 1,
          hasMoreNowPlaying: false,
          hasMorePopular: false,
          hasMoreTopRated: false,
          hasMoreUpcoming: false,
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
      // Find the first movie poster (ClipRRect) and tap it
      await tester.tap(find.byType(ClipRRect).first);
      await tester.pumpAndSettle();

      // Assert
      verify(mockNavigatorObserver.didPush(any, any));
      expect(find.text('Overview'), findsOneWidget);
    });

    /// Refresh Movies
    testWidgets('Pull to refresh should call refreshMovies event', (
      WidgetTester tester,
    ) async {
      // Arrange
      // when(mockMovieListBloc.state).thenReturn(loadedState);
      // when(mockMovieListBloc.add(any)).thenReturn(null);
      arrangeBlocsState(
        MovieListState.loadedMovieList(
          nowPlaying: testMovieList,
          popular: testMovieList,
          topRated: testMovieList,
          upcoming: testMovieList,
          nowPlayingPage: 1,
          popularPage: 1,
          topRatedPage: 1,
          upcomingPage: 1,
          hasMoreNowPlaying: false,
          hasMorePopular: false,
          hasMoreTopRated: false,
          hasMoreUpcoming: false,
        ),
      );

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));
        await tester.pump();
        // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
        // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
        await tester.pump(const Duration(seconds: 1));
      });

      // Hapus interaksi dari pemanggilan `add` di initState agar verifikasi bersih.
      clearInteractions(mockMovieListBloc);

      // Panggil callback onRefresh secara manual. Ini lebih stabil daripada
      // menyimulasikan gestur drag, dan secara langsung menguji logika.
      final SmartRefresher refresher = tester.widget(
        find.byType(SmartRefresher),
      );
      refresher.onRefresh!();

      // Pump sekali untuk memproses pemanggilan `add`
      await tester.pump();

      // Assert
      // Verifikasi bahwa event refreshMovies telah ditambahkan ke BLoC.
      verify(
        mockMovieListBloc.add(const MovieListEvent.refreshMovies()),
      ).called(1);
    });
  });
}
