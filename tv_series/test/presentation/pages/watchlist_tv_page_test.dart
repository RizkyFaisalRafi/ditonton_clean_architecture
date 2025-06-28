import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/module/tv_series.dart';
import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper_tv.mocks.dart';

// @GenerateNiceMocks([MockSpec<WatchlistTvBloc>(), MockSpec<NavigatorObserver>()])
void main() {
  late MockNavigatorObserver mockObserver;
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUp(() {
    mockObserver = MockNavigatorObserver();
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  // Widget helper untuk membungkus halaman (tidak ada perubahan)
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistTvBloc,
      child: MaterialApp(
        home: body,
        // Menyediakan navigator observer agar tes navigasi bisa berjalan
        navigatorObservers: [mockObserver],
        // Menambahkan onGenerateRoute untuk menangani navigasi bernama
        onGenerateRoute: (settings) {
          if (settings.name == tvSeriesDetailRoute) {
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
      mockWatchlistTvBloc.state,
    ).thenReturn(const WatchlistTvState.loadingWatchlistTv());
    when(mockWatchlistTvBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    // Assert
    final lottieFinder = find.byKey(const Key('loading_watchlist_tv'));
    expect(lottieFinder, findsOneWidget);
  });

  /// Loaded
  testWidgets('Page should display ListView when state is Loaded with data', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(
      mockWatchlistTvBloc.state,
    ).thenReturn(WatchlistTvState.loadedWatchlistTv(watchlistTv: testTvList));
    when(mockWatchlistTvBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    // Assert
    final listViewFinder = find.byType(ListView);
    final movieCardFinder = find.byType(TvCard);
    expect(listViewFinder, findsOneWidget);
    expect(movieCardFinder, findsOneWidget);
  });

  /// Loaded - Empty Data
  testWidgets(
    'Page should display EmptyStateWidget when state is Loaded but data is empty',
    (WidgetTester tester) async {
      // Arrange
      when(
        mockWatchlistTvBloc.state,
      ).thenReturn(const WatchlistTvState.loadedWatchlistTv(watchlistTv: []));
      when(mockWatchlistTvBloc.stream).thenAnswer((_) => Stream.empty());

      // Act
      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

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
        mockWatchlistTvBloc.state,
      ).thenReturn(const WatchlistTvState.errorWatchlistTv(errorMessage));
      when(mockWatchlistTvBloc.stream).thenAnswer((_) => Stream.empty());

      // Act
      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      // Assert
      final emptyWidgetFinder = find.byType(EmptyStateWidget);
      final textFinder = find.text(errorMessage);
      expect(emptyWidgetFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    },
  );

  /// Navigation Test
  testWidgets('should navigate to detail page when tv series card is tapped', (
    WidgetTester tester,
  ) async {
    // Arrange
    when(
      mockWatchlistTvBloc.state,
    ).thenReturn(WatchlistTvState.loadedWatchlistTv(watchlistTv: testTvList));
    when(mockWatchlistTvBloc.stream).thenAnswer((_) => Stream.empty());

    // Act
    await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

    // ===================================================================
    // PERBAIKAN KUNCI: Reset riwayat panggilan pada mock observer
    // setelah halaman awal selesai di-render, tapi sebelum aksi tap.
    clearInteractions(mockObserver);
    // ===================================================================

    await tester.tap(find.byType(TvCard).first);
    await tester.pumpAndSettle();

    // Assert: Sekarang verify HANYA akan menghitung push yang terjadi
    // setelah clearInteractions, yaitu push dari aksi tap.
    verify(mockObserver.didPush(any, any)).called(1);
  });
}
