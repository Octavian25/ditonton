part of 'detail_series_bloc.dart';

@immutable
abstract class DetailSeriesState extends Equatable {}

class DetailSeriesInitial extends DetailSeriesState {
  @override
  List<Object?> get props => [];
}

class DetailSeriesLoading extends DetailSeriesState {
  @override
  List<Object?> get props => [];
}

class DetailSeriesError extends DetailSeriesState {
  final String error;
  DetailSeriesError(this.error);
  @override
  List<Object?> get props => [];
}

class DetailSeriesHasData extends DetailSeriesState {
  final SeriesDetail result;
  DetailSeriesHasData(this.result);
  @override
  List<Object?> get props => [];
}
