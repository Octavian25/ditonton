part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesEvent extends Equatable {}

class FetchPopularMovies extends PopularMoviesEvent {
  @override
  List<Object?> get props => [];
}
