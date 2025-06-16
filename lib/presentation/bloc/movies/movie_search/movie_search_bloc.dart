import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton_clean_architecture/domain/usecases/movies/search_movies.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../domain/entities/movies/movie.dart';

part 'movie_search_event.dart';

part 'movie_search_state.dart';

part 'movie_search_bloc.freezed.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc({required this.searchMovies}) : super(SearchEmpty()) {
    // EventTransformer<T> debounce<T>(Duration duration) {
    //   return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    // }

    // on<OnQueryChanged>((event, emit) async {
    //   final query = event.query;
    //
    //   emit(SearchLoading());
    //   final result = await searchMovies.execute(query);
    //
    //   result.fold(
    //     (failure) {
    //       emit(SearchError(failure.message));
    //     },
    //     (data) {
    //       emit(SearchHasData(data));
    //     },
    //   );
    // }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnQueryChanged>(
      _onQueryChanged,
      // Transformer untuk debounce: mencegah API call pada setiap ketikan
      // transformer: debounce(const Duration(milliseconds: 500)),

      // membatalkan proses sebelumnya jika ada event baru yang masuk. Ini perilaku paling efisien.
      transformer: restartable(), // From bloc_concurrency
    );
  }

  // Helper untuk transformer debounce
  // EventTransformer<T> debounce<T>(Duration duration) {
  //   return (events, mapper) =>
  //       events.debounceTime(duration).asyncExpand(mapper);
  // }

  // Handler utama untuk event OnQueryChanged
  Future<void> _onQueryChanged(
    OnQueryChanged event,
    Emitter<MovieSearchState> emit,
  ) async {
    final query = event.query;

    // --- LOGIKA VALIDASI ---
    // 1. Jika query kosong setelah di-trim, kembalikan ke state Empty.
    if (query.trim().isEmpty) {
      emit(const MovieSearchState.searchEmpty());
      return;
    }
    // 2. Jika query mengandung karakter tidak valid, emit state Error.
    if (RegExp(r'[!@#$%^&*(),.?"{}|<>]').hasMatch(query)) {
      emit(
        const MovieSearchState.searchError('Query contains invalid characters'),
      );
      return;
    }
    // --- AKHIR LOGIKA VALIDASI ---

    // Jika validasi lolos, emit state Loading
    emit(const MovieSearchState.searchLoading());

    final result = await searchMovies.execute(query);

    result.fold(
      (failure) {
        // Jika gagal, emit state Error dengan pesan dari failure
        emit(MovieSearchState.searchError(failure.message));
      },
      (data) {
        // Jika berhasil, emit state HasData dengan hasil pencarian
        // UI akan menampilkan data atau pesan "Not Found" jika list kosong.
        emit(MovieSearchState.searchHasData(data));
      },
    );
  }
}
