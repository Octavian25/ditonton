part of 'detail_movies_bloc.dart';

@immutable
abstract class DetailMoviesState extends Equatable {}

class DetailMoviesInitial extends DetailMoviesState {
  @override
  List<Object?> get props => [];
}

class DetailMoviesLoading extends DetailMoviesState {
  @override
  List<Object?> get props => [];
}

class DetailMoviesError extends DetailMoviesState {
  final String error;
  DetailMoviesError(this.error);
  @override
  List<Object?> get props => [];
}

class DetailMoviesHasData extends DetailMoviesState {
  final MovieDetail result;
  DetailMoviesHasData(this.result);
  @override
  List<Object?> get props => [];
}
