import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/airing_today/airing_today_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/on_the_air/on_the_air_tv_bloc.dart'
    as on_the_air_bloc;
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/popular/popular_tv_bloc.dart'
    as popular_bloc;
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/top_rated/top_rated_tv_bloc.dart'
    as top_rated_bloc;
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/on_the_air_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/popular_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/top_rated_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_page.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'tv_series_page_test.mocks.dart';

@GenerateMocks([
  AiringTodayTvBloc,
  on_the_air_bloc.OnTheAirTvBloc,
  popular_bloc.PopularTvBloc,
  top_rated_bloc.TopRatedTvBloc,
  NavigatorObserver,
])
void main() {
  late MockAiringTodayTvBloc mockAiringTodayTvBloc;
  late MockOnTheAirTvBloc mockOnTheAirTvBloc;
  late MockPopularTvBloc mockPopularTvBloc;
  late MockTopRatedTvBloc mockTopRatedTvBloc;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockAiringTodayTvBloc = MockAiringTodayTvBloc();
    mockOnTheAirTvBloc = MockOnTheAirTvBloc();
    mockPopularTvBloc = MockPopularTvBloc();
    mockTopRatedTvBloc = MockTopRatedTvBloc();
    mockNavigatorObserver = MockNavigatorObserver();

    // Memberikan respons null ketika getter 'navigator' dipanggil
    when(mockNavigatorObserver.navigator).thenReturn(null);
  });

  // Fungsi helper untuk stub state dan stream dari BLoC
  void arrangeBlocsState(
    AiringTodayTvState airingTodayState,
    on_the_air_bloc.OnTheAirTvState onTheAirState,
    popular_bloc.PopularTvState popularState,
    top_rated_bloc.TopRatedTvState topRatedState,
  ) {
    // Stub stream (diperlukan agar BlocBuilder tidak error)
    when(
      mockAiringTodayTvBloc.stream,
    ).thenAnswer((_) => Stream.value(airingTodayState));
    when(
      mockOnTheAirTvBloc.stream,
    ).thenAnswer((_) => Stream.value(onTheAirState));
    when(
      mockPopularTvBloc.stream,
    ).thenAnswer((_) => Stream.value(popularState));
    when(
      mockTopRatedTvBloc.stream,
    ).thenAnswer((_) => Stream.value(topRatedState));

    // Stub state awal
    when(mockAiringTodayTvBloc.state).thenReturn(airingTodayState);
    when(mockOnTheAirTvBloc.state).thenReturn(onTheAirState);
    when(mockPopularTvBloc.state).thenReturn(popularState);
    when(mockTopRatedTvBloc.state).thenReturn(topRatedState);
  }

  // Widget wrapper untuk menyediakan semua BLoC yang dibutuhkan oleh TvSeriesPage
  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AiringTodayTvBloc>.value(value: mockAiringTodayTvBloc),
        BlocProvider<on_the_air_bloc.OnTheAirTvBloc>.value(
          value: mockOnTheAirTvBloc,
        ),
        BlocProvider<popular_bloc.PopularTvBloc>.value(
          value: mockPopularTvBloc,
        ),
        BlocProvider<top_rated_bloc.TopRatedTvBloc>.value(
          value: mockTopRatedTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
        // Daftarkan route yang akan dituju untuk verifikasi navigasi
        routes: {
          SearchTvPage.ROUTE_NAME:
              (_) => const Scaffold(body: Text('Search Tv Series')),
          OnTheAirTvPage.ROUTE_NAME:
              (_) => const Scaffold(body: Text('On The Air Tv Series')),
          PopularTvPage.ROUTE_NAME:
              (_) => const Scaffold(body: Text('Popular Tv Series')),
          TopRatedTvPage.ROUTE_NAME:
              (_) => const Scaffold(body: Text('Top Rated Tv Series')),
          TvSeriesDetailPage.ROUTE_NAME:
              (context) => const Scaffold(body: Text('Overview')),
        },
        // Gunakan mockNavigatorObserver untuk melacak event navigasi
        navigatorObservers: [mockNavigatorObserver],
      ),
    );
  }

  group('Tv Series Page', () {
    /// Loading
    testWidgets('Page should display loading indicator when state is Loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Atur state awal semua BLoC menjadi Loading
      arrangeBlocsState(
        const AiringTodayTvState.loading(),
        const on_the_air_bloc.OnTheAirTvState.loading(),
        const popular_bloc.PopularTvState.loading(),
        const top_rated_bloc.TopRatedTvState.loading(),
      );

      // Act
      // Render widget
      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      // Assert
      // Verifikasi
      expect(find.byKey(Key('loading_bar_lottie')), findsNWidgets(4));
      expect(find.byType(Lottie), findsNWidgets(4));
    });

    /// Loaded
    testWidgets('Page should display ListView when data is loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      arrangeBlocsState(
        AiringTodayTvState.loaded(
          airingToday: testTvList,
          hasMoreAiringToday: false,
          airingTodayPage: 1,
        ),
        on_the_air_bloc.OnTheAirTvState.loaded(
          onTheAir: testTvList,
          hasMoreOnTheAir: false,
          onTheAirPage: 1,
        ),
        popular_bloc.PopularTvState.loaded(
          popular: testTvList,
          hasMorePopular: false,
          popularPage: 1,
        ),
        top_rated_bloc.TopRatedTvState.loaded(
          topRated: testTvList,
          hasMoreTopRated: false,
          topRatedPage: 1,
        ),
      );

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
        await tester.pump();
        // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
        // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
        await tester.pump(const Duration(seconds: 1));
      });

      // Assert: Verifikasi bahwa setiap list ditemukan berdasarkan Key yang unik.
      expect(find.byKey(const Key('airing_today_list')), findsOneWidget);
      expect(find.byKey(const Key('on_the_air_list')), findsOneWidget);
      expect(find.byKey(const Key('popular_list')), findsOneWidget);
      expect(find.byKey(const Key('top_rated_list')), findsOneWidget);

      // Verifikasi
      expect(find.byType(TvSeriesList), findsNWidgets(4));
      expect(find.byType(ListView), findsNWidgets(4));
    });

    /// Error
    testWidgets('Page should display error widget when state is Error', (
      WidgetTester tester,
    ) async {
      await tester.runAsync(() async {
        // Arrange
        // Atur state semua BLoC menjadi Error
        const errorMessage = 'Server Failure';
        arrangeBlocsState(
          const AiringTodayTvState.error(errorMessage),
          const on_the_air_bloc.OnTheAirTvState.error(errorMessage),
          const popular_bloc.PopularTvState.error(errorMessage),
          const top_rated_bloc.TopRatedTvState.error(errorMessage),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

        // Assert
        // Verifikasi
        expect(find.byType(ErrorStateWidget2), findsNWidgets(4));
        expect(find.text(errorMessage), findsNWidgets(4));
      });
    });

    /// Error - No Connection (Already Data Local)
    testWidgets(
      'Page should display no connection widget for specific error message',
      (WidgetTester tester) async {
        // Arrange
        // Atur state BLoC ke Error dengan pesan koneksi
        const errorMessage = 'Failed to connect to the network';

        arrangeBlocsState(
          const AiringTodayTvState.error(errorMessage),
          const on_the_air_bloc.OnTheAirTvState.error(errorMessage),
          const popular_bloc.PopularTvState.error(errorMessage),
          const top_rated_bloc.TopRatedTvState.error(errorMessage),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
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
      arrangeBlocsState(
        AiringTodayTvState.loaded(
          airingToday: [],
          hasMoreAiringToday: false,
          airingTodayPage: 1,
        ),
        on_the_air_bloc.OnTheAirTvState.loaded(
          onTheAir: [],
          hasMoreOnTheAir: false,
          onTheAirPage: 1,
        ),
        popular_bloc.PopularTvState.loaded(
          popular: [],
          hasMorePopular: false,
          popularPage: 1,
        ),
        top_rated_bloc.TopRatedTvState.loaded(
          topRated: [],
          hasMoreTopRated: false,
          topRatedPage: 1,
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle(); // Tunggu animasi transisi selesai

      // Assert
      // Verifikasi bahwa metode push dipanggil pada navigator observer
      verify(mockNavigatorObserver.didPush(any, any));
      // Verifikasi bahwa route yang dituju adalah SearchMoviePage
      expect(find.text('Search Tv Series'), findsOneWidget);
    });

    /// Tap See More - Navigate to On The Air Page
    testWidgets(
      'Tapping "See More" on Popular should navigate to the on the air page',
      (WidgetTester tester) async {
        // Arrange
        arrangeBlocsState(
          AiringTodayTvState.loaded(
            airingToday: [],
            hasMoreAiringToday: false,
            airingTodayPage: 1,
          ),
          on_the_air_bloc.OnTheAirTvState.loaded(
            onTheAir: [],
            hasMoreOnTheAir: false,
            onTheAirPage: 1,
          ),
          popular_bloc.PopularTvState.loaded(
            popular: [],
            hasMorePopular: false,
            popularPage: 1,
          ),
          top_rated_bloc.TopRatedTvState.loaded(
            topRated: [],
            hasMoreTopRated: false,
            topRatedPage: 1,
          ),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
        // Cari InkWell dengan teks 'See More' dan tap
        await tester.tap(find.widgetWithText(InkWell, 'See More On The Air'));
        await tester.pumpAndSettle();

        // Assert
        verify(mockNavigatorObserver.didPush(any, any));
        expect(find.text('On The Air Tv Series'), findsOneWidget);
      },
    );

    /// Tap See More - Navigate to Popular Page
    testWidgets(
      'Tapping "See More" on Popular should navigate to the popular page',
      (WidgetTester tester) async {
        // Arrange
        arrangeBlocsState(
          AiringTodayTvState.loaded(
            airingToday: [],
            hasMoreAiringToday: false,
            airingTodayPage: 1,
          ),
          on_the_air_bloc.OnTheAirTvState.loaded(
            onTheAir: [],
            hasMoreOnTheAir: false,
            onTheAirPage: 1,
          ),
          popular_bloc.PopularTvState.loaded(
            popular: [],
            hasMorePopular: false,
            popularPage: 1,
          ),
          top_rated_bloc.TopRatedTvState.loaded(
            topRated: [],
            hasMoreTopRated: false,
            topRatedPage: 1,
          ),
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
        // Cari InkWell dengan teks 'See More' dan tap
        await tester.tap(find.widgetWithText(InkWell, 'See More Popular'));
        await tester.pumpAndSettle();

        // Assert
        verify(mockNavigatorObserver.didPush(any, any));
        expect(find.text('Popular Tv Series'), findsOneWidget);
      },
    );

    /// Tap See More - Navigate to Top Rated Page
    testWidgets(
      'Tapping "See More" on Popular should navigate to the top rated page',
      (WidgetTester tester) async {
        // Arrange
        arrangeBlocsState(
          AiringTodayTvState.loaded(
            airingToday: [],
            hasMoreAiringToday: false,
            airingTodayPage: 1,
          ),
          on_the_air_bloc.OnTheAirTvState.loaded(
            onTheAir: [],
            hasMoreOnTheAir: false,
            onTheAirPage: 1,
          ),
          popular_bloc.PopularTvState.loaded(
            popular: [],
            hasMorePopular: false,
            popularPage: 1,
          ),
          top_rated_bloc.TopRatedTvState.loaded(
            topRated: [],
            hasMoreTopRated: false,
            topRatedPage: 1,
          ),
        );
        final seeMoreButtonFinder = find.widgetWithText(
          InkWell,
          'See More Top Rated',
        );

        // Act
        await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

        // Scroll agar widget terlihat di layar
        await tester.ensureVisible(seeMoreButtonFinder);
        // await tester.pumpAndSettle();
        // 1. Mulai Beri waktu untuk scroll selesai
        await tester.pump();
        // 2. Beri waktu yang cukup agar animasi transisi halaman selesai.
        await tester.pump(const Duration(seconds: 1));

        // Cari InkWell dengan teks 'See More' dan tap
        await tester.tap(seeMoreButtonFinder);
        await tester.pumpAndSettle();

        // Assert
        verify(mockNavigatorObserver.didPush(any, any));
        expect(find.text('Top Rated Tv Series'), findsOneWidget);
      },
    );

    /// Tap Tv Item - Navigate to Detail Page
    testWidgets('Tapping a tv item should navigate to the detail page', (
      WidgetTester tester,
    ) async {
      // Arrange
      arrangeBlocsState(
        AiringTodayTvState.loaded(
          airingToday: testTvList,
          hasMoreAiringToday: false,
          airingTodayPage: 1,
        ),
        on_the_air_bloc.OnTheAirTvState.loaded(
          onTheAir: [],
          hasMoreOnTheAir: false,
          onTheAirPage: 1,
        ),
        popular_bloc.PopularTvState.loaded(
          popular: [],
          hasMorePopular: false,
          popularPage: 1,
        ),
        top_rated_bloc.TopRatedTvState.loaded(
          topRated: [],
          hasMoreTopRated: false,
          topRatedPage: 1,
        ),
      );

      // Act
      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
      // Find the first movie poster (ClipRRect) and tap it
      await tester.tap(find.byType(ClipRRect).first);
      await tester.pumpAndSettle();

      // Assert
      verify(mockNavigatorObserver.didPush(any, any));
      expect(find.text('Overview'), findsOneWidget);
    });

    /// Refresh Tv Series
    testWidgets('Pull to refresh should call refreshTvSeries event', (
      WidgetTester tester,
    ) async {
      // Arrange
      arrangeBlocsState(
        AiringTodayTvState.loaded(
          airingToday: testTvList,
          hasMoreAiringToday: false,
          airingTodayPage: 1,
        ),
        on_the_air_bloc.OnTheAirTvState.loaded(
          onTheAir: testTvList,
          hasMoreOnTheAir: false,
          onTheAirPage: 1,
        ),
        popular_bloc.PopularTvState.loaded(
          popular: testTvList,
          hasMorePopular: false,
          popularPage: 1,
        ),
        top_rated_bloc.TopRatedTvState.loaded(
          topRated: testTvList,
          hasMoreTopRated: false,
          topRatedPage: 1,
        ),
      );

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
        await tester.pump();
        // PERBAIKAN: Pump lagi dengan durasi untuk menyelesaikan timer dari pull_to_refresh.
        // Log error menunjukkan timer 600ms, jadi 1 detik sudah aman.
        await tester.pump(const Duration(seconds: 1));
      });

      clearInteractions(mockAiringTodayTvBloc);
      clearInteractions(mockOnTheAirTvBloc);
      clearInteractions(mockPopularTvBloc);
      clearInteractions(mockTopRatedTvBloc);

      // Panggil callback onRefresh secara manual. Ini lebih stabil daripada
      // menyimulasikan gestur drag, dan secara langsung menguji logika.
      final SmartRefresher refresher = tester.widget(
        find.byType(SmartRefresher),
      );
      refresher.onRefresh!();

      // Pump sekali untuk memproses pemanggilan `add`
      await tester.pump();

      // Assert
      // Verifikasi bahwa event refreshTvSeries telah ditambahkan ke BLoC.
      verify(
        mockAiringTodayTvBloc.add(const AiringTodayTvEvent.refreshTv()),
      ).called(1);

      verify(
        mockOnTheAirTvBloc.add(on_the_air_bloc.OnTheAirTvEvent.refreshTvOTA()),
      ).called(1);

      verify(
        mockPopularTvBloc.add(popular_bloc.PopularTvEvent.refreshTv()),
      ).called(1);

      verify(
        mockTopRatedTvBloc.add(top_rated_bloc.TopRatedTvEvent.refreshTv()),
      ).called(1);
    });
  });
}
