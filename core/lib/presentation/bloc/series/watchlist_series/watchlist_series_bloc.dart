import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_watchlist_series.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'watchlist_series_event.dart';
part 'watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchlistSeries getWatchlistSeries;
  WatchlistSeriesBloc(this.getWatchlistSeries)
      : super(WatchlistSeriesInitial()) {
    on<FetchWatchlistSeries>((event, emit) async {
      emit(WatchlistSeriesLoading());
      final result = await getWatchlistSeries.execute();
      result.fold((l) {
        emit(WatchlistSeriesError(l.message));
      }, (r) {
        emit(WatchlistSeriesHasData(r));
      });
    });
  }
}
