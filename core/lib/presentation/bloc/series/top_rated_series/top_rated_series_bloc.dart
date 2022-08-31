import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_top_rated_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries getTopRatedSeries;
  TopRatedSeriesBloc(this.getTopRatedSeries) : super(TopRatedSeriesInitial()) {
    on<FetchTopRatedSeries>((event, emit) async {
      emit(TopRatedSeriesLoading());
      final result = await getTopRatedSeries.execute();
      result.fold((l) {
        emit(TopRatedSeriesError(l.message));
      }, (r) {
        emit(TopRatedSeriesHasData(r));
      });
    });
  }
}
