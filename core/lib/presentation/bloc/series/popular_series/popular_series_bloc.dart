import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_popular_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'popular_series_event.dart';
part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries getPopularSeries;
  PopularSeriesBloc(this.getPopularSeries) : super(PopularSeriesInitial()) {
    on<FetchPopularSeries>((event, emit) async {
      emit(PopularSeriesLoading());
      final result = await getPopularSeries.execute();
      result.fold((l) {
        emit(PopularSeriesError(l.message));
      }, (r) {
        emit(PopularSeriesHasData(r));
      });
    });
  }
}
