import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc(this.getPopularMovies) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await getPopularMovies.execute();
      result.fold((l) {
        emit(PopularMoviesError(l.message));
      }, (r) {
        emit(PopularMoviesHasData(r));
      });
    });
  }
}
