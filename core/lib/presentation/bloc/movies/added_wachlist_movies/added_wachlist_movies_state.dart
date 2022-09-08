part of 'added_wachlist_movies_bloc.dart';

@immutable
abstract class AddedWachlistMoviesState extends Equatable {}

class AddedWachlistMoviesInitial extends AddedWachlistMoviesState {
  @override
  List<Object?> get props => [];
}

class AddedWachlistMoviesLoading extends AddedWachlistMoviesState {
  @override
  List<Object?> get props => [];
}

class IsAddedWatchList extends AddedWachlistMoviesState {
  final bool result;
  final String message;
  IsAddedWatchList(this.result, this.message);
  @override
  List<Object?> get props => [];
}
