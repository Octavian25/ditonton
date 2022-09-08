part of 'added_watchlist_series_bloc.dart';

@immutable
abstract class AddedWatchlistSeriesEvent {}

class FetchAddedWatchlistSeries extends AddedWatchlistSeriesEvent {
  final int id;
  FetchAddedWatchlistSeries(this.id);
}

class RemoveFromWatchListSeries extends AddedWatchlistSeriesEvent {
  final SeriesDetail seriesDetail;
  final BuildContext context;
  RemoveFromWatchListSeries(this.seriesDetail, this.context);
}

class AddToWatchListSeries extends AddedWatchlistSeriesEvent {
  final SeriesDetail seriesDetail;
  final BuildContext context;
  AddToWatchListSeries(this.seriesDetail, this.context);
}
