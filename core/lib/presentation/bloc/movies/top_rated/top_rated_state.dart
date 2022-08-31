part of 'top_rated_bloc.dart';

@immutable
abstract class TopRatedState extends Equatable {}

class TopRatedInitial extends TopRatedState {
  @override
  List<Object?> get props => [];
}

class TopRatedLoading extends TopRatedState {
  @override
  List<Object?> get props => [];
}

class TopRatedError extends TopRatedState {
  final String error;
  TopRatedError(this.error);
  @override
  List<Object?> get props => [];
}

class TopRatedHasData extends TopRatedState {
  final List<Movie> result;
  TopRatedHasData(this.result);
  @override
  List<Object?> get props => [];
}
