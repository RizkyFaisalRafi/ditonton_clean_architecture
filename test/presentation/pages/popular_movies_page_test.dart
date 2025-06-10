import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesNotifier])
void main() {
  late MockPopularMoviesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularMoviesNotifier();
    // Setup properties
    when(mockNotifier.refreshC).thenReturn(RefreshController());
    when(mockNotifier.scrollController).thenReturn(ScrollController());
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularMoviesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display app bar with title', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(find.text('Popular Movies'), findsOneWidget);
  });

  testWidgets('Page should display loading indicator when loading', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    final progressBarFinder = find.byKey(Key('loading_popular_movie'));
    expect(progressBarFinder, findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget);
  });

  testWidgets('Page should display empty widget when movies is empty', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn([]);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(find.text('No movies available.'), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(testMovieList);

    final listViewFinder = find.byKey(Key('loaded_popular'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display error message when error occurs', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    final textFinder = find.byKey(Key('error_message'));

    expect(textFinder, findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
    expect(find.byType(ErrorStateWidget2), findsOneWidget);
  });

  testWidgets('Page should trigger refresh when retry is pressed', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    when(mockNotifier.onRefresh()).thenAnswer((_) async {});

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    final errorWidgetFinder = find.byType(ErrorStateWidget2);
    final elevatedError = find.byKey(Key('elevated_button_ErrorStateWidget2'));

    await tester.tap(elevatedError);
    await tester.pump();

    expect(errorWidgetFinder, findsOneWidget);
    expect(elevatedError, findsOneWidget);
    verify(mockNotifier.onRefresh()).called(1);
  });

  testWidgets('SmartRefresher should be configured correctly', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.movies).thenReturn(testMovieList);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(find.byType(SmartRefresher), findsOneWidget);
  });
}
