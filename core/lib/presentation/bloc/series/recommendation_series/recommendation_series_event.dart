part of 'recommendation_series_bloc.dart';

@immutable
abstract class RecommendationSeriesEvent {}

class FetchRecommendationSeries extends RecommendationSeriesEvent {
  final int id;
  FetchRecommendationSeries(this.id);
}
