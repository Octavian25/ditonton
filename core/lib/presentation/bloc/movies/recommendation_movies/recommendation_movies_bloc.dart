import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'recommendation_movies_event.dart';
part 'recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations getMovieRecommendations;
  RecommendationMoviesBloc(this.getMovieRecommendations)
      : super(RecommendationMoviesInitial()) {
    on<FetchRecommendationMovies>((event, emit) async {
      emit(RecommendationMoviesLoading());
      final result = await getMovieRecommendations.execute(event.id);
      result.fold((l) {
        emit(RecommendationMoviesError(l.message));
      }, (r) {
        emit(RecommendationMoviesHasData(r));
      });
    });
  }
}
