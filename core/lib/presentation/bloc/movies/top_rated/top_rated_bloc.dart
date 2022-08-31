import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedBloc(this.getTopRatedMovies) : super(TopRatedInitial()) {
    on<FetchTopRated>((event, emit) async {
      emit(TopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold((l) {
        emit(TopRatedError(l.message));
      }, (r) {
        emit(TopRatedHasData(r));
      });
    });
  }
}
