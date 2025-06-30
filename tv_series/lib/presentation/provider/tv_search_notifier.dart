import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/search_tv_series.dart';
import 'package:flutter/cupertino.dart';
import 'package:core/module/core.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSearchNotifier({required this.searchTvSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TvSeries> _searchResult = [];

  List<TvSeries> get searchResult => _searchResult;

  String _message = '';

  String get message => _message;

  bool _isQueryValid(String query) {
    // Validasi Empty
    if (query.trim().isEmpty) {
      _message = 'Query cannot be empty';
      return false;
    }
    // Validasi karakter khusus
    if (RegExp(r'[!@#$%^&*(),.?"{}|<>]').hasMatch(query)) {
      _message = 'Query contains invalid characters';
      return false;
    }

    return true;
  }

  Future<void> fetchTvSearch(String query) async {
    // Validasi
    if (!_isQueryValid(query)) {
      _state = RequestState.Error;
      notifyListeners();
      return;
    }

    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
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
