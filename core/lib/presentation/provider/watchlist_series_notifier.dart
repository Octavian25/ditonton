import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_watchlist_series.dart';
import 'package:flutter/foundation.dart';

class WatchlistSeriesNotifier extends ChangeNotifier {
  final GetWatchlistSeries getWatchlistSeries;
  WatchlistSeriesNotifier({required this.getWatchlistSeries});

  var _watchlistSeries = <Series>[];
  List<Series> get watchlistSeries => _watchlistSeries;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;
  Future<void> fetchWatchlistSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistSeries = seriesData;
        notifyListeners();
      },
    );
  }
}
