part of 'now_playing_bloc_bloc.dart';

@immutable
abstract class NowPlayingBlocState extends Equatable {}

class NowPlayingBlocInitial extends NowPlayingBlocState {
  @override
  List<Object?> get props => [];
}

class NowPlayingLoading extends NowPlayingBlocState {
  @override
  List<Object?> get props => [];
}

class NowPlayingError extends NowPlayingBlocState {
  final String error;
  NowPlayingError(this.error);
  @override
  List<Object?> get props => [];
}

class NowPlayingHasData extends NowPlayingBlocState {
  final List<Movie> result;
  NowPlayingHasData(this.result);
  @override
  List<Object?> get props => [];
}
