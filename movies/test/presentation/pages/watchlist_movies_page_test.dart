import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/test_helper_movie.mocks.dart';

void main() {
  late MockNavigatorObserver mockObserver;
  // Deklarasikan mock dengan tipe dari file .mocks.dart
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  // Inisialisasi mock sebelum setiap test
  setUp(() {
    mockObserver = MockNavigatorObserver();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();

    // Memberikan respons null ketika getter 'navigator' dipanggil
    when(mockObserver.navigator).thenReturn(null);
  });

  // Widget helper untuk membungkus halaman (tidak ada perubahan)
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMovieBloc>.value(
      value: mockWatchlistMovieBloc,
      child: MaterialApp(
        home: body,
        // Menyediakan navigator observer agar tes navigasi bisa berjalan
        navigatorObservers: [mockObserver],
        // Menambahkan onGenerateRoute untuk menangani navigasi bernama
        onGenerateRoute: (settings) {
          if (settings.name == movieDetailRoute) {
            // Ketika navigasi ke halaman detail terdeteksi,
            // kembalikan halaman palsu (dummy) untuk tes.
            // Kita tidak perlu merender halaman detail yang sesungguhnya.
            return MaterialPageRoute(builder: (_) => const Scaffold());
          }
          return null;
        },
      ),
    );
  }

  /// Loading
  testWidgets('Page should display Lottie loading when state is Loading', (
    WidgetTester tester,
  ) async {
    // Arrange: Atur mock BLoC dengan Mockito
    // Kita perlu stub 'state' dan 'stream' dari BLoC
    when(
      mockWatchlistMovieBloc.state,
    ).thenReturn(const WatchlistMovieState.loadingWatchlistMovie());
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    // Assert
    final lottieFinder = find.byKey(const Key('loading_watchlist_movie'));
    expect(lottieFinder, findsOneWidget);
  });

  /// Loaded
  testWidgets('Page should display ListView when state is Loaded with data', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockWatchlistMovieBloc.state).thenReturn(
      WatchlistMovieState.loadedWatchlistMovie(watchlistMovie: testMovieList),
    );
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    // Assert
    final listViewFinder = find.byType(ListView);
    final movieCardFinder = find.byType(MovieCard);
    expect(listViewFinder, findsOneWidget);
    expect(movieCardFinder, findsOneWidget);
  });

  /// Loaded - Empty Data
  testWidgets(
    'Page should display EmptyStateWidget when state is Loaded but data is empty',
    (WidgetTester tester) async {
      // Arrange
      when(mockWatchlistMovieBloc.state).thenReturn(
        const WatchlistMovieState.loadedWatchlistMovie(watchlistMovie: []),
      );
      when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

      // Act
      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      // Assert
      final emptyWidgetFinder = find.byType(EmptyStateWidget);
      final textFinder = find.text('No Watchlist Available.');
      expect(emptyWidgetFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    },
  );

  /// Error
  testWidgets(
    'Page should display EmptyStateWidget with error message when state is Error',
    (WidgetTester tester) async {
      const errorMessage = 'Failed to fetch data';
      // Arrange
      when(
        mockWatchlistMovieBloc.state,
      ).thenReturn(const WatchlistMovieState.errorWatchlistMovie(errorMessage));
      when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

      // Act
      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      // Assert
      final emptyWidgetFinder = find.byType(EmptyStateWidget);
      final textFinder = find.text(errorMessage);
      expect(emptyWidgetFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    },
  );

  /// Navigation Test
  testWidgets('should navigate to detail page when movie card is tapped', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(mockWatchlistMovieBloc.state).thenReturn(
      WatchlistMovieState.loadedWatchlistMovie(watchlistMovie: testMovieList),
    );
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

    // ===================================================================
    // PERBAIKAN KUNCI: Reset riwayat panggilan pada mock observer
    // setelah halaman awal selesai di-render, tapi sebelum aksi tap.
    clearInteractions(mockObserver);
    // ===================================================================

    await tester.tap(find.byType(MovieCard).first);
    await tester.pumpAndSettle();

    // Assert: Sekarang verify HANYA akan menghitung push yang terjadi
    // setelah clearInteractions, yaitu push dari aksi tap.
    verify(mockObserver.didPush(any, any)).called(1);
  });
}
