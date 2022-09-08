part of 'recommendation_series_bloc.dart';

@immutable
abstract class RecommendationSeriesState extends Equatable {}

class RecommendationSeriesInitial extends RecommendationSeriesState {
  @override
  List<Object?> get props => [];
}

class RecommendationSeriesLoading extends RecommendationSeriesState {
  @override
  List<Object?> get props => [];
}

class RecommendationSeriesError extends RecommendationSeriesState {
  final String error;
  RecommendationSeriesError(this.error);
  @override
  List<Object?> get props => [];
}

class RecommendationSeriesHasData extends RecommendationSeriesState {
  final List<Series> result;
  RecommendationSeriesHasData(this.result);
  @override
  List<Object?> get props => [];
}
