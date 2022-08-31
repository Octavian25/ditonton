part of 'top_rated_series_bloc.dart';

@immutable
abstract class TopRatedSeriesEvent extends Equatable {}

class FetchTopRatedSeries extends TopRatedSeriesEvent {
  @override
  List<Object?> get props => [];
}
