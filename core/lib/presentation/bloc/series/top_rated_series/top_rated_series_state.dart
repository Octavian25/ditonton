part of 'top_rated_series_bloc.dart';

@immutable
abstract class TopRatedSeriesState extends Equatable {}

class TopRatedSeriesInitial extends TopRatedSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesLoading extends TopRatedSeriesState {
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesError extends TopRatedSeriesState {
  final String error;
  TopRatedSeriesError(this.error);
  @override
  List<Object?> get props => [];
}

class TopRatedSeriesHasData extends TopRatedSeriesState {
  final List<Series> result;
  TopRatedSeriesHasData(this.result);
  @override
  List<Object?> get props => [];
}
