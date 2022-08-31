part of 'search_series_bloc.dart';

@immutable
abstract class SearchSeriesState extends Equatable {
  const SearchSeriesState();

  @override
  List<Object> get props => [];
}

class SearchSeriesInitial extends SearchSeriesState {}

class SearchSeriesEmpty extends SearchSeriesState {}

class SearchSeriesLoading extends SearchSeriesState {}

class SearchSeriesError extends SearchSeriesState {
  final String error;

  const SearchSeriesError(this.error);

  @override
  List<Object> get props => [error];
}

class SearchSeriesHasData extends SearchSeriesState {
  final List<Series> result;

  const SearchSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
