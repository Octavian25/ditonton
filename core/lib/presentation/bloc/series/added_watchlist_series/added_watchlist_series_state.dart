part of 'added_watchlist_series_bloc.dart';

@immutable
abstract class AddedWatchlistSeriesState extends Equatable {}

class AddedWatchlistSeriesInitial extends AddedWatchlistSeriesState {
  @override
  List<Object?> get props => [];
}

class AddedWatchlistSeriesLoading extends AddedWatchlistSeriesState {
  @override
  List<Object?> get props => [];
}

class IsAddedWatchlistSeries extends AddedWatchlistSeriesState {
  final bool result;
  final String message;
  IsAddedWatchlistSeries(this.result, this.message);
  @override
  List<Object?> get props => [result, message];
}
