import 'package:ditonton_clean_architecture/common/state_enum.dart';
import 'package:ditonton_clean_architecture/domain/entities/movies/movie.dart';
import 'package:ditonton_clean_architecture/presentation/bloc/movies/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton_clean_architecture/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton_clean_architecture/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:ditonton_clean_architecture/presentation/widgets/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:provider/provider.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier, MovieDetailBloc])
void main() {
  late MockMovieDetailNotifier mockNotifier;
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(home: body),
    );
  }

  // Helper untuk membuat widget yang bisa diuji
  Widget _makeTestableWidget2(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(home: body),
    );
  }

  // Helper untuk stub state dan stream dari BLoC menggunakan Mockito
  void _arrangeBlocState(MovieDetailState state) {
    when(mockMovieDetailBloc.state).thenReturn(state);
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.value(state));
  }

  const tId = 1;

  group('Movie Detail Page', () {
    testWidgets('should display progress indicator when state is initial', (
      WidgetTester tester,
    ) async {
      // Arrange
      _arrangeBlocState(const MovieDetailState.initial());

      // Act
      await tester.pumpWidget(
        _makeTestableWidget2(const MovieDetailPage(id: tId)),
      );

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should display Lottie loading when state is loading', (
      WidgetTester tester,
    ) async {
      // Arrange
      _arrangeBlocState(const MovieDetailState.loading());

      // Act
      await tester.pumpWidget(
        _makeTestableWidget2(const MovieDetailPage(id: tId)),
      );

      // Assert
      expect(find.byType(Lottie), findsOneWidget);
    });

    testWidgets('should display DetailContent when state is loaded', (
      WidgetTester tester,
    ) async {
      // Arrange
      _arrangeBlocState(
        MovieDetailState.loaded(
          movieDetail: testMovieDetail,
          movieRecommendations: [testMovie],
          recommendationState: RequestState.Loaded,
          isAddedToWatchlist: false,
        ),
      );

      // Act
      await mockNetworkImages(() async {
        await tester.pumpWidget(
          _makeTestableWidget2(const MovieDetailPage(id: tId)),
        );
      });

      // Assert
      expect(find.byType(DetailContent), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.text('Overview'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should display ErrorStateWidget when state is error', (
      WidgetTester tester,
    ) async {
      // Arrange
      _arrangeBlocState(const MovieDetailState.error('Failed to load data'));

      // Act
      await tester.pumpWidget(
        _makeTestableWidget2(const MovieDetailPage(id: tId)),
      );

      // Assert
      expect(find.byType(ErrorStateWidget2), findsOneWidget);
      expect(find.text('Failed to load data'), findsOneWidget);
    });

    testWidgets(
      'should call AddToWatchlist event when watchlist button is tapped and not in watchlist',
      (WidgetTester tester) async {
        // Arrange
        _arrangeBlocState(
          MovieDetailState.loaded(
            movieDetail: testMovieDetail,
            movieRecommendations: const [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: false,
          ),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            _makeTestableWidget2(const MovieDetailPage(id: tId)),
          );
        });

        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        // Assert
        verify(
          mockMovieDetailBloc.add(
            MovieDetailEvent.addToWatchlist(testMovieDetail),
          ),
        );
      },
    );

    testWidgets(
      'should call RemoveFromWatchlist event when watchlist button is tapped and already in watchlist',
      (WidgetTester tester) async {
        // Arrange
        _arrangeBlocState(
          MovieDetailState.loaded(
            movieDetail: testMovieDetail,
            movieRecommendations: [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: true,
          ),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            _makeTestableWidget2(const MovieDetailPage(id: tId)),
          );
        });

        expect(find.byIcon(Icons.check), findsOneWidget);
        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        // Assert
        verify(
          mockMovieDetailBloc.add(
            MovieDetailEvent.removeFromWatchlist(testMovieDetail),
          ),
        );
      },
    );

    testWidgets(
      'should show SnackBar when watchlist message is a success message',
      (WidgetTester tester) async {
        // Arrange
        // Simulasikan state awal
        when(mockMovieDetailBloc.state).thenReturn(
          MovieDetailState.loaded(
            movieDetail: testMovieDetail,
            movieRecommendations: const [],
            recommendationState: RequestState.Loaded,
            isAddedToWatchlist: false,
          ),
        );

        // Simulasikan stream state yang berubah
        when(mockMovieDetailBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([
            MovieDetailState.loaded(
              movieDetail: testMovieDetail,
              movieRecommendations: [],
              recommendationState: RequestState.Loaded,
              isAddedToWatchlist: true,
              watchlistMessage: 'Added to Watchlist',
            ),
          ]),
        );

        // Act
        await mockNetworkImages(() async {
          await tester.pumpWidget(
            _makeTestableWidget2(const MovieDetailPage(id: tId)),
          );
          // Pump frame tambahan untuk memproses state dari stream
          await tester.pump();
        });

        // Assert
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      },
    );
  });
  //
  // testWidgets('Should display loading indicator when state is Loading', (
  //   widgetTester,
  // ) async {
  //   /// Arrange
  //   when(mockNotifier.movieState).thenReturn(RequestState.Loading);
  //
  //   /// Act
  //   await widgetTester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //   /// Assert
  //   expect(find.byKey(Key('loading_movie_detail')), findsOneWidget);
  // });
  //
  // testWidgets('Should display error message when state is Error', (
  //   WidgetTester tester,
  // ) async {
  //   /// Arrange
  //   when(mockNotifier.movieState).thenReturn(RequestState.Error);
  //   when(mockNotifier.message).thenReturn('Error');
  //
  //   /// Act
  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //   /// Assert
  //   expect(find.text('Error'), findsOneWidget);
  // });
  //
  // testWidgets(
  //   'Watchlist button should display add icon when movie not added to watchlist',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //
  //     final watchlistButtonIcon = find.byIcon(Icons.add);
  //
  //     await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //     expect(watchlistButtonIcon, findsOneWidget);
  //   },
  // );
  //
  // testWidgets(
  //   'Watchlist button should dispay check icon when movie is added to wathclist',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(true);
  //
  //     final watchlistButtonIcon = find.byIcon(Icons.check);
  //
  //     await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //     expect(watchlistButtonIcon, findsOneWidget);
  //   },
  // );
  //
  // testWidgets(
  //   'Watchlist button should display Snackbar when added to watchlist',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //     when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');
  //
  //     final watchlistButton = find.byType(FilledButton);
  //
  //     await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //     expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //     await tester.tap(watchlistButton);
  //     await tester.pump();
  //
  //     expect(find.byType(SnackBar), findsOneWidget);
  //     expect(find.text('Added to Watchlist'), findsOneWidget);
  //   },
  // );

  // testWidgets(
  //   'Watchlist button should display AlertDialog when add to watchlist failed',
  //   (WidgetTester tester) async {
  //     when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movie).thenReturn(testMovieDetail);
  //     when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
  //     when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
  //     when(mockNotifier.isAddedToWatchlist).thenReturn(false);
  //     when(mockNotifier.watchlistMessage).thenReturn('Failed');
  //
  //     final watchlistButton = find.byType(FilledButton);
  //
  //     await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
  //
  //     expect(find.byIcon(Icons.add), findsOneWidget);
  //
  //     await tester.tap(watchlistButton);
  //     await tester.pump();
  //
  //     expect(find.byType(AlertDialog), findsOneWidget);
  //     expect(find.text('Failed'), findsOneWidget);
  //   },
  // );
}
