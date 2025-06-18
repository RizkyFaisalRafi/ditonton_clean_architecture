import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/airing_today/airing_today_tv_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/on_the_air/on_the_air_tv_bloc.dart'
    as on_the_air_bloc;
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/popular/popular_tv_bloc.dart'
    as popular_bloc;
import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_list/top_rated/top_rated_tv_bloc.dart'
    as top_rated_bloc;
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'tv_series_page_test.mocks.dart';

@GenerateMocks([
  TvSeriesPage,
  AiringTodayTvBloc,
  on_the_air_bloc.OnTheAirTvBloc,
  popular_bloc.PopularTvBloc,
  top_rated_bloc.TopRatedTvBloc,
])
void main() {
  late MockAiringTodayTvBloc mockAiringTodayTvBloc;
  late MockOnTheAirTvBloc mockOnTheAirTvBloc;
  late MockPopularTvBloc mockPopularTvBloc;
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  // --- PERBAIKAN: Mock untuk path_provider ---
  // Dilakukan sekali untuk semua tes dalam file ini
  // setUpAll(() {
  //   TestWidgetsFlutterBinding.ensureInitialized();
  //   // Mock untuk MethodChannel dari path_provider
  //   const MethodChannel channel = MethodChannel(
  //     'plugins.flutter.io/path_provider',
  //   );
  //   TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
  //       .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
  //         // Jika ada panggilan ke method-method ini, kembalikan path palsu
  //         if (methodCall.method == 'getTemporaryDirectory' ||
  //             methodCall.method == 'getApplicationSupportDirectory') {
  //           return '.'; // Path ini tidak harus ada, hanya untuk menghindari error
  //         }
  //         return null;
  //       });
  // });

  setUp(() {
    mockAiringTodayTvBloc = MockAiringTodayTvBloc();
    mockOnTheAirTvBloc = MockOnTheAirTvBloc();
    mockPopularTvBloc = MockPopularTvBloc();
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  // Data dummy untuk digunakan dalam state 'Loaded'
  final tTvSeries = TvSeries(
    id: 1,
    name: 'Good Mythical Morning',
    overview: 'Overview 1',
    posterPath: '/jMpBQr2aNOFAI6wsC47zsOG6qOh.jpg',
    backdropPath: '/hvFCS0dMeC3ffiF4uYTKzUAkvYL.jpg',
    adult: false,
    genreIds: [35],
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: 'Good Mythical Morning',
    popularity: 329.7681,
    firstAirDate: "2012-01-09",
    voteAverage: 7.0,
    voteCount: 78,
  );

  final tTvList = <TvSeries>[tTvSeries];

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
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (
    WidgetTester tester,
  ) async {
    // Atur state awal semua BLoC menjadi Loading
    arrangeBlocsState(
      const AiringTodayTvState.loading(),
      const on_the_air_bloc.OnTheAirTvState.loading(),
      const popular_bloc.PopularTvState.loading(),
      const top_rated_bloc.TopRatedTvState.loading(),
    );

    await mockNetworkImages(() async {
      // Bangun widget
      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));
    });

    // Verifikasi
    expect(find.byKey(Key('loading_bar_lottie')), findsNWidgets(4));
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    // Arrange
    arrangeBlocsState(
      AiringTodayTvState.loaded(
        airingToday: tTvList,
        hasMoreAiringToday: false,
        airingTodayPage: 1,
      ),
      on_the_air_bloc.OnTheAirTvState.loaded(
        onTheAir: tTvList,
        hasMoreOnTheAir: false,
        onTheAirPage: 1,
      ),
      popular_bloc.PopularTvState.loaded(
        popular: tTvList,
        hasMorePopular: false,
        popularPage: 1,
      ),
      top_rated_bloc.TopRatedTvState.loaded(
        topRated: tTvList,
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

    // --- PERBAIKAN: Menggunakan Key yang unik untuk setiap list ---
    // Assert: Verifikasi bahwa setiap list ditemukan berdasarkan Key yang unik.
    expect(find.byKey(const Key('airing_today_list')), findsOneWidget);
    expect(find.byKey(const Key('on_the_air_list')), findsOneWidget);
    expect(find.byKey(const Key('popular_list')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_list')), findsOneWidget);

    // Verifikasi
    expect(find.byType(TvSeriesList), findsNWidgets(4));
    expect(find.byType(ListView), findsNWidgets(4));
  });

  testWidgets('Page should display error message when data failed to load', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      // Atur state semua BLoC menjadi Error
      const errorMessage = 'Server Failure';
      arrangeBlocsState(
        const AiringTodayTvState.error(errorMessage),
        const on_the_air_bloc.OnTheAirTvState.error(errorMessage),
        const popular_bloc.PopularTvState.error(errorMessage),
        const top_rated_bloc.TopRatedTvState.error(errorMessage),
      );

      // Bangun widget
      await tester.pumpWidget(makeTestableWidget(const TvSeriesPage()));

      // Verifikasi
      expect(find.text(errorMessage), findsNWidgets(4));
    });
  });
}
