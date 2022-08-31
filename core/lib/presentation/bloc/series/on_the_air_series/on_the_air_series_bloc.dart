import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_on_the_air_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'on_the_air_series_event.dart';
part 'on_the_air_series_state.dart';

class OnTheAirSeriesBloc
    extends Bloc<OnTheAirSeriesEvent, OnTheAirSeriesState> {
  final GetOnTheAirSeries getOnTheAirSeries;
  OnTheAirSeriesBloc(this.getOnTheAirSeries) : super(OnTheAirSeriesInitial()) {
    on<FetchOnTheAirSeries>((event, emit) async {
      emit(OnTheAirSeriesLoading());
      final result = await getOnTheAirSeries.execute();
      result.fold((l) {
        emit(OnTheAirSeriesError(l.message));
      }, (r) {
        emit(OnTheAirSeriesHasData(r));
      });
    });
  }
}
