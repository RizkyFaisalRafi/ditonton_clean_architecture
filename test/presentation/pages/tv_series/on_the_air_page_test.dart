import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/on_the_air_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/on_the_air_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'on_the_air_page_test.mocks.dart';

@GenerateMocks([OnTheAirNotifier])
void main() {
  late MockOnTheAirNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockOnTheAirNotifier();

    // Setup properties
    when(mockNotifier.refreshC).thenReturn(RefreshController());
    when(mockNotifier.scrollController).thenReturn(ScrollController());
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnTheAirNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display app bar with title', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(find.text('On The Air Tv Series'), findsOneWidget);
  });

  testWidgets('Page should display loading indicator when loading', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    final progressBarFinder = find.byKey(Key('loading_on_the_air_tv'));
    expect(progressBarFinder, findsOneWidget);
    expect(find.byType(Lottie), findsOneWidget);
  });

  testWidgets('Page should display empty widget when movies is empty', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesList).thenReturn([]);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(find.text('No tv series available.'), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tvSeriesList).thenReturn(testTvList);

    final listViewFinder = find.byKey(Key('loaded_on_the_air'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(find.byType(TvCard), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display error message when error occurs', (
    WidgetTester tester,
  ) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

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

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

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
    when(mockNotifier.tvSeriesList).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(find.byType(SmartRefresher), findsOneWidget);
  });
}
