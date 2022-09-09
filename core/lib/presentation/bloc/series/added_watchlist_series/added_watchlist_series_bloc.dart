import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:core/domain/repositories/series_repository.dart';
import 'package:core/domain/usecases/series/remove_watchlist_series.dart';
import 'package:core/domain/usecases/series/save_watchlist_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'added_watchlist_series_event.dart';
part 'added_watchlist_series_state.dart';

class AddedWatchlistSeriesBloc
    extends Bloc<AddedWatchlistSeriesEvent, AddedWatchlistSeriesState> {
  final SeriesRepository seriesRepository;
  final RemoveWatchlistSeries removeWatchlistSeries;
  final SaveWatchlistSeries saveWatchlistSeries;
  final bool isTestingMode;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  static const watchlistInitialMessage = 'Initial Message';
  AddedWatchlistSeriesBloc(
      {required this.seriesRepository,
      required this.removeWatchlistSeries,
      required this.saveWatchlistSeries,
      this.isTestingMode = false})
      : super(AddedWatchlistSeriesInitial()) {
    on<FetchAddedWatchlistSeries>((event, emit) async {
      final result = await seriesRepository.isAddedToWatchlistSeries(event.id);
      emit(IsAddedWatchlistSeries(result, watchlistInitialMessage));
    });
    on<RemoveFromWatchListSeries>(
      (event, emit) async {
        emit(AddedWatchlistSeriesLoading());
        final result = await removeWatchlistSeries.execute(event.seriesDetail);
        await result.fold((l) async {
          final result = await seriesRepository
              .isAddedToWatchlistSeries(event.seriesDetail.id);
          emit(IsAddedWatchlistSeries(result, l.message));
        }, (r) async {
          final result = await seriesRepository
              .isAddedToWatchlistSeries(event.seriesDetail.id);
          emit(IsAddedWatchlistSeries(result, r));
        });
      },
    );
    on<AddToWatchListSeries>(
      (event, emit) async {
        emit(AddedWatchlistSeriesLoading());
        final result = await saveWatchlistSeries.execute(event.seriesDetail);
        await result.fold((l) async {
          final result = await seriesRepository
              .isAddedToWatchlistSeries(event.seriesDetail.id);
          emit(IsAddedWatchlistSeries(result, l.message));
        }, (r) async {
          final result = await seriesRepository
              .isAddedToWatchlistSeries(event.seriesDetail.id);
          emit(IsAddedWatchlistSeries(result, r));
        });
      },
    );
  }
}
