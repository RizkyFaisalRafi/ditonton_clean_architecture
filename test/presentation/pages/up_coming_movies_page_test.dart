import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/movie.dart';
import 'package:ditonton_clean_architecture/presentation/pages/up_coming_movies_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/up_coming_movies_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../providers/up_coming_movies_notifier_test.mocks.dart';

@GenerateMocks([UpComingMoviesNotifier])
void main() {
  late MockUpComingMoviesNotifier mockUpComingMoviesNotifier;

  setUp(() {
    mockUpComingMoviesNotifier = MockUpComingMoviesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<UpComingMoviesNotifier>.value(
      value: mockUpComingMoviesNotifier,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(mockUpComingMoviesNotifier.state).thenReturn(RequestState.Loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(UpComingMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded', (
    WidgetTester tester,
  ) async {
    when(mockUpComingMoviesNotifier.state).thenReturn(RequestState.Loaded);
    when(mockUpComingMoviesNotifier.movies).thenReturn(<Movie>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(UpComingMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(mockUpComingMoviesNotifier.state).thenReturn(RequestState.Error);
    when(mockUpComingMoviesNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(UpComingMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
