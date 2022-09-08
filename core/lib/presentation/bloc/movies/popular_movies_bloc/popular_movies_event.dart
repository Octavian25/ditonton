part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesEvent {}

class FetchPopularMovies extends PopularMoviesEvent {}
