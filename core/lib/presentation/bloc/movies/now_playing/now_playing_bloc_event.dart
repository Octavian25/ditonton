part of 'now_playing_bloc_bloc.dart';

@immutable
abstract class NowPlayingBlocEvent extends Equatable {}

class FetchNowPlayingMovies extends NowPlayingBlocEvent {
  @override
  List<Object?> get props => [];
}
