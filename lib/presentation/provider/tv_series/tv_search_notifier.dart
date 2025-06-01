import 'package:ditonton_clean_architecture/domain/entities/tv/tv_series.dart';
import 'package:ditonton_clean_architecture/domain/usecases/tv_series/search_tv_series.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/state_enum.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSearchNotifier({required this.searchTvSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _searchResult = [];

  List<TvSeries> get searchResult => _searchResult;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    // Validasi Empty
    if (query.isEmpty) {
      _state = RequestState.Error;
      _message = 'Query cannot be empty';
      notifyListeners();
      return;
    }
    // Validasi karakter khusus
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(query)) {
      _state = RequestState.Error;
      _message = 'Query contains invalid characters';
      notifyListeners();
      return;
    }

    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
