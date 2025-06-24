import 'package:ditonton_clean_architecture/presentation/bloc/tv/tv_search/tv_search_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/tv_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'search_tv_page_test.mocks.dart';

@GenerateMocks([TvSearchBloc])
void main() {
  late MockTvSearchBloc mockTvSearchBloc;

  setUp(() {
    // Inisialisasi mock object sebelum setiap tes
    mockTvSearchBloc = MockTvSearchBloc();
  });

  const tQuery = 'test query';

  // Helper function untuk membuat widget yang bisa ditest.
  // Ini membungkus SearchTvPage dengan BlocProvider dan MaterialApp.
  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvSearchBloc>.value(
      value: mockTvSearchBloc,
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  // Penting: BlocBuilder mendengarkan `stream`, jadi kita perlu mock stream dari BLoC.
  // Properti `.state` digunakan untuk state awal sebelum ada interaksi.
  void arrangeBlocState(TvSearchState state) {
    when(mockTvSearchBloc.state).thenReturn(state);
    when(mockTvSearchBloc.stream).thenAnswer((_) => Stream.value(state));
  }

  group('SearchTvPage UI Tests', () {
    /// Initial State
    testWidgets('should display initial state with animation and text', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state awal BLoC menjadi SearchEmpty
      arrangeBlocState(SearchEmpty());

      // Act: Render widget SearchTvPage
      await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));

      // Assert: Verifikasi bahwa TextField, Lottie, dan teks awal ada di layar
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.text('Search TV Series'), findsOneWidget);
    });

    /// Loading
    testWidgets('should display loading indicator when state is loading', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state BLoC menjadi SearchLoading
      arrangeBlocState(SearchLoading());

      // Act: Render widget
      await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));

      // Assert: Verifikasi bahwa Lottie loading ditampilkan
      final lottieFinder = find.byType(Lottie);
      expect(find.byKey(Key('loading_state_lottie')), findsOneWidget);
      expect(lottieFinder, findsOneWidget);
    });

    /// Loaded
    testWidgets('should display ListView when data is loaded', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state BLoC menjadi SearchHasData dengan data
      arrangeBlocState(SearchHasData(testTvList));

      // Act: Render widget
      await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));

      // Assert: Verifikasi bahwa ListView dan TvCard ditampilkan
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(TvCard), findsOneWidget);
      expect(
        find.text('Gute Zeiten, schlechte Zeiten'),
        findsOneWidget,
      ); // Periksa berdasarkan nama TV
    });

    /// Loaded - Empty Data
    testWidgets('should display error widget when search result is empty', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state BLoC menjadi SearchHasData dengan list kosong
      arrangeBlocState(SearchHasData(const []));

      // Act: Render widget
      await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));

      // Assert: Verifikasi bahwa ErrorStateWidget dengan pesan 'No results found' ditampilkan
      expect(find.byType(ErrorStateWidget), findsOneWidget);
      expect(find.byKey(Key('loaded_state_empty_search')), findsOneWidget);
      expect(find.text('TV Search Not Found!'), findsOneWidget);
    });

    /// Error
    testWidgets('should display ErrorStateWidget when state is SearchError', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state BLoC menjadi SearchError
      const errorMessage = 'TV Server Failure!';
      arrangeBlocState(const SearchError(errorMessage));

      // Act: Render widget
      await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));

      // Assert: Verifikasi bahwa ErrorStateWidget dengan pesan error yang sesuai ditampilkan
      expect(find.byType(ErrorStateWidget), findsOneWidget);
      expect(find.byKey(Key('error_state')), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });

    /// Trigger OnQueryChangedTv
    testWidgets(
      'should trigger OnQueryChangedTv event when text is entered in TextField',
      (WidgetTester tester) async {
        // Arrange: Atur state awal BLoC
        arrangeBlocState(SearchEmpty());

        // Act: Render widget, masukkan teks ke TextField
        await tester.pumpWidget(_makeTestableWidget(const SearchTvPage()));

        // Cari TextField dan masukkan teks
        final textField = find.byType(TextField);
        await tester.enterText(textField, tQuery);

        // Tunggu sebentar untuk debounce (jika ada di BLoC)
        // await tester.pump(const Duration(milliseconds: 500));
        await tester.pump();

        // Assert: Verifikasi bahwa event OnQueryChangedTv dikirim ke BLoC dengan query yang benar
        verify(mockTvSearchBloc.add(const OnQueryChangedTv(tQuery))).called(1);
      },
    );
  });
}
