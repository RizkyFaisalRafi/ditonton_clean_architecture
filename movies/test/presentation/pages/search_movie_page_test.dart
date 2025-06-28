import 'package:core/module/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/module/movies.dart';
import '../../dummy_data/dummy_objects_movie.dart';
import '../../helpers/test_helper_movie.mocks.dart';

// @GenerateMocks([MovieSearchBloc])
void main() {
  late MockMovieSearchBloc mockMovieSearchBloc;

  setUp(() {
    // Inisialisasi mock object sebelum setiap tes
    mockMovieSearchBloc = MockMovieSearchBloc();
  });

  // Helper function untuk membuat widget yang bisa ditest.
  // Ini membungkus SearchMoviePage dengan BlocProvider dan MaterialApp.
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchBloc>.value(
      value: mockMovieSearchBloc,
      child: MaterialApp(home: Scaffold(body: body)),
    );
  }

  // Penting: BlocBuilder mendengarkan `stream`, jadi kita perlu mock stream dari BLoC.
  // Properti `.state` digunakan untuk state awal sebelum ada interaksi.
  void arrangeBlocState(MovieSearchState state) {
    when(mockMovieSearchBloc.state).thenReturn(state);
    when(mockMovieSearchBloc.stream).thenAnswer((_) => Stream.value(state));
  }

  group('SearchMoviePage UI Tests', () {
    /// Initial State
    testWidgets('should display initial state with animation and text', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state awal BLoC
      arrangeBlocState(MovieSearchEmpty());

      // Act: Render widget
      await tester.pumpWidget(makeTestableWidget(SearchMoviePage()));

      // Assert: Verifikasi bahwa widget untuk state awal ditampilkan
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      expect(find.text('Search Movie'), findsNWidgets(2));
    });

    /// Loading
    testWidgets('should display loading indicator when state is loading', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state BLoC ke Loading
      arrangeBlocState(MovieSearchLoading());

      // Act: Render widget
      await tester.pumpWidget(makeTestableWidget(SearchMoviePage()));

      // Assert: Verifikasi bahwa Lottie (sebagai loading indicator) ditampilkan
      expect(find.byKey(Key('loading_state_lottie')), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
    });

    /// Loaded
    testWidgets(
      'should display ListView when state is SearchHasData / Loaded',
      (WidgetTester tester) async {
        // Arrange: Atur state BLoC ke HasData dengan data dummy
        arrangeBlocState(MovieSearchHasData(testMovieList));

        // Act: Render widget
        await tester.pumpWidget(makeTestableWidget(SearchMoviePage()));

        // Assert: Verifikasi bahwa ListView dan MovieCard ditampilkan
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(MovieCard), findsOneWidget);

        // Anda juga bisa memverifikasi judul dari movie dummy
        expect(
          find.text('Spider-Man'),
          findsOneWidget,
        ); // Periksa berdasarkan nama Film
      },
    );

    /// Loaded - Empty Data
    testWidgets('should display error widget when search result is empty', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state BLoC ke HasData dengan list kosong
      arrangeBlocState(MovieSearchHasData(const []));

      // Act: Render widget
      await tester.pumpWidget(makeTestableWidget(SearchMoviePage()));

      // Assert: Verifikasi bahwa pesan "No results found" ditampilkan
      expect(find.byType(ErrorStateWidget), findsOneWidget);
      expect(find.byKey(Key('loaded_state_empty_search')), findsOneWidget);
      expect(find.text('Movie Search Not Found!'), findsOneWidget);
    });

    /// Error
    testWidgets('should display ErrorStateWidget when state is SearchError', (
      WidgetTester tester,
    ) async {
      // Arrange: Atur state BLoC ke Error
      const errorMessage = 'Movie Server Failure!';
      arrangeBlocState(const MovieSearchError(errorMessage));

      // Act: Render widget
      await tester.pumpWidget(makeTestableWidget(SearchMoviePage()));

      // Assert: Verifikasi bahwa ErrorStateWidget dengan pesan error yang sesuai ditampilkan
      expect(find.byType(ErrorStateWidget), findsOneWidget);
      expect(find.byKey(Key('error_state')), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);
    });

    /// Trigger OnQueryChanged
    testWidgets(
      'should trigger OnQueryChanged event when text is entered in TextField',
      (WidgetTester tester) async {
        // Arrange
        arrangeBlocState(MovieSearchEmpty());

        // Act
        await tester.pumpWidget(makeTestableWidget(SearchMoviePage()));

        // Cari TextField dan masukkan teks
        final textField = find.byType(TextField);
        await tester.enterText(textField, 'spiderman');

        // Tunggu sebentar untuk memproses event (jika ada debounce)
        await tester.pump();

        // Assert: Verifikasi bahwa event OnQueryChanged dipanggil dengan query yang benar
        verify(mockMovieSearchBloc.add(OnQueryChanged('spiderman'))).called(1);
      },
    );
  });
}
