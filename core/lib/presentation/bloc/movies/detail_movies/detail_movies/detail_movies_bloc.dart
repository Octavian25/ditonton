import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'detail_movies_event.dart';
part 'detail_movies_state.dart';

class DetailMoviesBloc extends Bloc<DetailMoviesEvent, DetailMoviesState> {
  final GetMovieDetail getMovieDetail;
  DetailMoviesBloc(this.getMovieDetail) : super(DetailMoviesInitial()) {
    on<FetchDetailMovies>((event, emit) async {
      emit(DetailMoviesLoading());
      final result = await getMovieDetail.execute(event.id);
      result.fold((l) {
        emit(DetailMoviesError(l.message));
      }, (r) {
        emit(DetailMoviesHasData(r));
      });
    });
  }
}
