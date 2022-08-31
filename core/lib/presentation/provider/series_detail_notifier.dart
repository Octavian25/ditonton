import 'package:core/domain/entities/series.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/series/get_series_detail.dart';
import 'package:core/domain/usecases/series/get_series_recommendation.dart';
import 'package:core/domain/usecases/series/get_watchlist_status.dart';
import 'package:core/domain/usecases/series/remove_watchlist_series.dart';
import 'package:core/domain/usecases/series/save_watchlist_series.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListSeriesStatus getWatchListSeriesStatus;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  SeriesDetailNotifier(
      {required this.getSeriesDetail,
      required this.getSeriesRecommendations,
      required this.getWatchListSeriesStatus,
      required this.saveWatchlistSeries,
      required this.removeWatchlistSeries});

  late SeriesDetail _series;
  SeriesDetail get series => _series;

  RequestState _seriesState = RequestState.Empty;
  RequestState get seriesState => _seriesState;

  List<Series> _seriesRecommendations = [];
  List<Series> get seriesRecommendations => _seriesRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _seriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _recommendationState = RequestState.Loading;
        _series = series;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _seriesRecommendations = movies;
          },
        );
        _seriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(SeriesDetail series) async {
    final result = await saveWatchlistSeries.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(SeriesDetail series) async {
    final result = await removeWatchlistSeries.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListSeriesStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
