part of 'watchlist_movies_bloc.dart';

@immutable
abstract class WatchlistMoviesState extends Equatable {}

class WatchlistMoviesInitial extends WatchlistMoviesState {
  @override
  List<Object?> get props => [];
}

class WatchlistMoviesLoading extends WatchlistMoviesState {
  @override
  List<Object?> get props => [];
}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String error;
  WatchlistMoviesError(this.error);
  @override
  List<Object?> get props => [];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> result;
  WatchlistMoviesHasData(this.result);
  @override
  List<Object?> get props => [];
}
