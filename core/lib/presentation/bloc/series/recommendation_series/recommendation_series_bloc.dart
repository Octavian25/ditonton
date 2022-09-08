import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_series_recommendation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'recommendation_series_event.dart';
part 'recommendation_series_state.dart';

class RecommendationSeriesBloc
    extends Bloc<RecommendationSeriesEvent, RecommendationSeriesState> {
  final GetSeriesRecommendations getSeriesRecommendations;
  RecommendationSeriesBloc(this.getSeriesRecommendations)
      : super(RecommendationSeriesInitial()) {
    on<FetchRecommendationSeries>((event, emit) async {
      emit(RecommendationSeriesLoading());
      final result = await getSeriesRecommendations.execute(event.id);
      result.fold((l) {
        emit(RecommendationSeriesError(l.message));
      }, (r) {
        emit(RecommendationSeriesHasData(r));
      });
    });
  }
}
