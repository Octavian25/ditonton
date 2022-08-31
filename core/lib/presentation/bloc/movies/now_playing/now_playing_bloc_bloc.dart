import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'now_playing_bloc_event.dart';
part 'now_playing_bloc_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingBlocEvent, NowPlayingBlocState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingBloc(this.getNowPlayingMovies) : super(NowPlayingBlocInitial()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold((l) {
        emit(NowPlayingError(l.message));
      }, (r) {
        emit(NowPlayingHasData(r));
      });
    });
  }
}
