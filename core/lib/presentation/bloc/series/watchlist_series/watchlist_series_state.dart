part of 'watchlist_series_bloc.dart';

@immutable
abstract class WatchlistSeriesState extends Equatable {}

class WatchlistSeriesInitial extends WatchlistSeriesState {
  @override
  List<Object?> get props => [];
}

class WatchlistSeriesLoading extends WatchlistSeriesState {
  @override
  List<Object?> get props => [];
}

class WatchlistSeriesError extends WatchlistSeriesState {
  final String error;
  WatchlistSeriesError(this.error);
  @override
  List<Object?> get props => [];
}

class WatchlistSeriesHasData extends WatchlistSeriesState {
  final List<Series> result;
  WatchlistSeriesHasData(this.result);
  @override
  List<Object?> get props => [];
}
