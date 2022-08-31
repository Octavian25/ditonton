part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState extends Equatable {}

class PopularMoviesInitial extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

class PopularMoviesLoading extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

class PopularMoviesError extends PopularMoviesState {
  final String error;

  PopularMoviesError(this.error);
  @override
  List<Object?> get props => [error];
}

class PopularMoviesHasData extends PopularMoviesState {
  final List<Movie> result;

  PopularMoviesHasData(this.result);
  @override
  List<Object?> get props => [result];
}
