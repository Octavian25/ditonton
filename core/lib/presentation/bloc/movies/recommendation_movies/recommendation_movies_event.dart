part of 'recommendation_movies_bloc.dart';

@immutable
abstract class RecommendationMoviesEvent {}

class FetchRecommendationMovies extends RecommendationMoviesEvent {
  final int id;

  FetchRecommendationMovies(this.id);
}
