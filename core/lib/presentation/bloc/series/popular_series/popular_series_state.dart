part of 'popular_series_bloc.dart';

@immutable
abstract class PopularSeriesState extends Equatable {}

class PopularSeriesInitial extends PopularSeriesState {
  @override
  List<Object?> get props => [];
}

class PopularSeriesLoading extends PopularSeriesState {
  @override
  List<Object?> get props => [];
}

class PopularSeriesError extends PopularSeriesState {
  final String error;
  PopularSeriesError(this.error);
  @override
  List<Object?> get props => [];
}

class PopularSeriesHasData extends PopularSeriesState {
  final List<Series> result;
  PopularSeriesHasData(this.result);
  @override
  List<Object?> get props => [];
}
