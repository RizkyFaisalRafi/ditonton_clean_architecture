import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/tv_series/tv_search_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  group('SearchTvPage Widget Tests', () {
    testWidgets('should show initial empty state', (tester) async {
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Empty);
      when(mockTvSearchNotifier.searchResult).thenReturn([]);
      when(mockTvSearchNotifier.message).thenReturn('');

      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      expect(find.text('Enter a TV series title to search'), findsOneWidget);
      verifyNever(mockTvSearchNotifier.fetchTvSearch(any));
    });

    testWidgets('should show loading indicator', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Loading);
      when(mockTvSearchNotifier.searchResult).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show search results', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Loaded);
      when(mockTvSearchNotifier.searchResult).thenReturn(testTvSeries);

      // Act & Assert
      await mockNetworkImages(() async {
        await tester.pumpWidget(makeTestableWidget(SearchTvPage()));
        expect(find.byType(TvCard), findsNWidgets(testTvSeries.length));
      });
    });

    testWidgets('should show error message when state is Error', (
      tester,
    ) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Error);
      when(mockTvSearchNotifier.message).thenReturn('Error occurred');

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));

      // Assert
      expect(find.text('Error occurred'), findsOneWidget);
    });

    testWidgets('should trigger search when text submitted', (tester) async {
      // Arrange
      when(mockTvSearchNotifier.state).thenReturn(RequestState.Empty);
      when(mockTvSearchNotifier.searchResult).thenReturn([]);

      // Act
      await tester.pumpWidget(makeTestableWidget(SearchTvPage()));
      await tester.enterText(find.byType(TextField), 'naruto');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Assert
      verify(mockTvSearchNotifier.fetchTvSearch('naruto')).called(1);
    });
  });
}
