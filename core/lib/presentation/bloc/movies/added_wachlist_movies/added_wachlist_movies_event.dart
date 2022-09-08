part of 'added_wachlist_movies_bloc.dart';

@immutable
abstract class AddedWachlistMoviesEvent {}

class FetchAddedWachlistMovies extends AddedWachlistMoviesEvent {
  final int id;

  FetchAddedWachlistMovies(this.id);
}

class RemoveFromWatchListMovies extends AddedWachlistMoviesEvent {
  final MovieDetail movieDetail;
  final BuildContext context;
  RemoveFromWatchListMovies(this.movieDetail, this.context);
}

class AddToWatchListMovies extends AddedWachlistMoviesEvent {
  final MovieDetail movieDetail;
  final BuildContext context;
  AddToWatchListMovies(this.movieDetail, this.context);
}
