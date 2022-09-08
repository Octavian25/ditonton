import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:core/domain/usecases/series/get_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'detail_series_event.dart';
part 'detail_series_state.dart';

class DetailSeriesBloc extends Bloc<DetailSeriesEvent, DetailSeriesState> {
  final GetSeriesDetail getSeriesDetail;
  DetailSeriesBloc(this.getSeriesDetail) : super(DetailSeriesInitial()) {
    on<FetchDetailSeries>((event, emit) async {
      emit(DetailSeriesLoading());
      final result = await getSeriesDetail.execute(event.id);
      result.fold((l) {
        emit(DetailSeriesError(l.message));
      }, (r) {
        emit(DetailSeriesHasData(r));
      });
    });
  }
}
