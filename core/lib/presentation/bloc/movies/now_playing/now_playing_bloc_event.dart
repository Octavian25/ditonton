part of 'now_playing_bloc_bloc.dart';

@immutable
abstract class NowPlayingBlocEvent {}

class FetchNowPlayingMovies extends NowPlayingBlocEvent {}
