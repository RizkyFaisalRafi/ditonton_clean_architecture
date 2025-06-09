import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import 'search_tv_page_test.mocks.dart';

@GenerateMocks([TvSearchNotifier])
void main() {
  late MockTvSearchNotifier mockTvSearchNotifier;
  late List<TvSeries> testTvSeries;

  // dijalankan sebelum setiap test
  setUp(() {
    mockTvSearchNotifier = MockTvSearchNotifier();
    testTvSeries = [
      TvSeries(
        id: 1,
        name: 'Lapor Pak',
        overview: 'Overview 1',
        posterPath: '/poster1.jpg',
        backdropPath: '/backdrop1.jpg',
        adult: null,
        genreIds: [],
        originCountry: [],
        originalLanguage: '',
        originalName: '',
        popularity: null,
        firstAirDate: '',
        voteAverage: null,
        voteCount: null,
      ),
      TvSeries(
        id: 2,
        name: 'Joko Widodo',
        overview: 'Overview 2',
        posterPath: '/poster2.jpg',
        backdropPath: '/backdrop2.jpg',
        adult: null,
        genreIds: [],
        originCountry: [],
        originalLanguage: '',
        originalName: '',
        popularity: null,
        firstAirDate: '',
        voteAverage: null,
        voteCount: null,
      ),
    ];
  });

  // fungsi yang dijalankan setelah setiap test case selesai
  tearDown(() {
    reset(mockTvSearchNotifier); // Reset setelah setiap test
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSearchNotifier>.value(
      value: mockTvSearchNotifier,
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  group('SearchTvPage UI Tests', () {
    testWidgets('should display initial state correctly', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Empty);

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Assert
      expect(find.text('Search Tv Series'), findsNWidgets(2));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets('should show loading indicator when loading', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Loading);

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Assert
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.byKey(Key('loading_state_lottie')), findsOneWidget);
    });

    testWidgets('should show error widget when error occurs', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Error);
      when(mockTvSearchNotifier.message).thenReturn('Error');

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Assert
      expect(find.byKey(Key('error_state')), findsOneWidget);
    });

    testWidgets('should show empty results widget', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Loaded);
      when(mockTvSearchNotifier.searchResult).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Assert
      expect(find.byKey(Key('loaded_state_empty_search')), findsOneWidget);
      expect(find.text('Tv Series Search Not Found!'), findsOneWidget);
    });

    testWidgets('should show tv cards when data is loaded', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Loaded);
      when(mockTvSearchNotifier.searchResult).thenReturn(testTvSeries);

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Assert
      expect(find.byType(TvCard), findsNWidgets(2));
      expect(find.text('Lapor Pak'), findsOneWidget);
    });
  });

  group('SearchTvPage Interaction Tests', () {
    testWidgets('should call fetchTvSearch when search submitted', (
      tester,
    ) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Empty);
      when(mockTvSearchNotifier.fetchTvSearch('joy')).thenAnswer((_) async {});

      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Act
      await tester.enterText(find.byType(TextField), 'query');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Assert
      verify(mockTvSearchNotifier.fetchTvSearch('query')).called(1);
    });

    testWidgets('should not call fetchTvSearch for empty query', (
      tester,
    ) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Empty);
      when(mockTvSearchNotifier.fetchTvSearch('joy')).thenAnswer((_) async {});

      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Act
      await tester.enterText(find.byType(TextField), '   ');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Assert
      verifyNever(mockTvSearchNotifier.fetchTvSearch('joy'));
    });
  });
}
