import 'package:core/domain/entities/series.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/series/get_on_the_air_series.dart';
import 'package:core/domain/usecases/series/get_popular_series.dart';
import 'package:core/domain/usecases/series/get_top_rated_series.dart';
import 'package:flutter/material.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _onTheAirSeries = <Series>[];
  List<Series> get onTheAirSeries => _onTheAirSeries;

  RequestState _onTheAirSeriesState = RequestState.Empty;
  RequestState get onTheAirSeriesState => _onTheAirSeriesState;

  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.Empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  String _message = '';
  String get message => _message;

  SeriesListNotifier(
      {required this.getPopularSeries,
      required this.getTopRatedSeries,
      required this.getOnTheAirSeries});
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;
  final GetOnTheAirSeries getOnTheAirSeries;

  Future<void> fetchPopularSeries() async {
    _popularSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
      (failure) {
        _popularSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _popularSeriesState = RequestState.Loaded;
        _popularSeries = seriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchOnTheAirSeries() async {
    _onTheAirSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirSeries.execute();
    result.fold(
      (failure) {
        _onTheAirSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _onTheAirSeriesState = RequestState.Loaded;
        _onTheAirSeries = seriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _topRatedSeriesState = RequestState.Loaded;
        _topRatedSeries = seriesData;
        notifyListeners();
      },
    );
  }
}
