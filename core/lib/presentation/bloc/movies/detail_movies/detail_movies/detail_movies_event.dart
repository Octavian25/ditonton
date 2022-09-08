part of 'detail_movies_bloc.dart';

@immutable
abstract class DetailMoviesEvent {}

class FetchDetailMovies extends DetailMoviesEvent {
  int id;
  FetchDetailMovies(this.id);
}
