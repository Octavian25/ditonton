part of 'on_the_air_series_bloc.dart';

@immutable
abstract class OnTheAirSeriesState extends Equatable {}

class OnTheAirSeriesInitial extends OnTheAirSeriesState {
  @override
  List<Object?> get props => [];
}

class OnTheAirSeriesLoading extends OnTheAirSeriesState {
  @override
  List<Object?> get props => [];
}

class OnTheAirSeriesError extends OnTheAirSeriesState {
  final String error;
  OnTheAirSeriesError(this.error);
  @override
  List<Object?> get props => [];
}

class OnTheAirSeriesHasData extends OnTheAirSeriesState {
  final List<Series> result;
  OnTheAirSeriesHasData(this.result);
  @override
  List<Object?> get props => [];
}
