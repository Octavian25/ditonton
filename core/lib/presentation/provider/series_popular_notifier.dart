import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_popular_series.dart';
import 'package:flutter/foundation.dart';

class PopularSeriesNotifier extends ChangeNotifier {
  final GetPopularSeries getPopularSeries;

  PopularSeriesNotifier(this.getPopularSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Series> _seris = [];
  List<Series> get series => _seris;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (seriesData) {
        _seris = seriesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
