part of 'recommendation_movies_bloc.dart';

@immutable
abstract class RecommendationMoviesState extends Equatable {}

class RecommendationMoviesInitial extends RecommendationMoviesState {
  @override
  List<Object?> get props => [];
}

class RecommendationMoviesLoading extends RecommendationMoviesState {
  @override
  List<Object?> get props => [];
}

class RecommendationMoviesError extends RecommendationMoviesState {
  final String error;
  RecommendationMoviesError(this.error);
  @override
  List<Object?> get props => [];
}

class RecommendationMoviesHasData extends RecommendationMoviesState {
  final List<Movie> result;
  RecommendationMoviesHasData(this.result);
  @override
  List<Object?> get props => [];
}
