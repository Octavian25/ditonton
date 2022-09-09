part of 'search_movie_bloc.dart';

@immutable
abstract class SearchMovieEvent {
  const SearchMovieEvent();
}

class OnQueryChanged extends SearchMovieEvent {
  final String query;

  const OnQueryChanged(this.query);
}
