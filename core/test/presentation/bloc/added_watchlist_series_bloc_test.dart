import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/series/remove_watchlist_series.dart';
import 'package:core/domain/usecases/series/save_watchlist_series.dart';
import 'package:core/presentation/bloc/series/added_watchlist_series/added_watchlist_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import 'added_watchlist_series_bloc_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([SaveWatchlistSeries, RemoveWatchlistSeries])
void main() {
  late AddedWatchlistSeriesBloc addedWatchlistSeriesBloc;
  late MockSeriesRepository mockSeriesRepository;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;
  late MockBuildContext context;
  setUp(() {
    context = MockBuildContext();
    mockSeriesRepository = MockSeriesRepository();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    addedWatchlistSeriesBloc = AddedWatchlistSeriesBloc(
        seriesRepository: mockSeriesRepository,
        removeWatchlistSeries: mockRemoveWatchlistSeries,
        saveWatchlistSeries: mockSaveWatchlistSeries,
        isTestingMode: true);
  });

  const tQuery = 1;

  test("initial state should be empty", () {
    expect(addedWatchlistSeriesBloc.state, AddedWatchlistSeriesInitial());
  });

  blocTest<AddedWatchlistSeriesBloc, AddedWatchlistSeriesState>(
    'Should emit [Loading, addedwatchlist] when data is gotten successfully',
    build: () {
      when(mockSeriesRepository.isAddedToWatchlistSeries(tQuery))
          .thenAnswer((_) async => true);
      return addedWatchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchAddedWatchlistSeries(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      IsAddedWatchlistSeries(true, "Initial Message"),
    ],
    verify: (bloc) {
      verify(mockSeriesRepository.isAddedToWatchlistSeries(tQuery));
    },
  );
  blocTest<AddedWatchlistSeriesBloc, AddedWatchlistSeriesState>(
    'Should emit [Loading, success] when data is gotten successfully',
    build: () {
      when(mockSaveWatchlistSeries.execute(testSeriesDetail)).thenAnswer(
          (_) async =>
              const Right(AddedWatchlistSeriesBloc.watchlistAddSuccessMessage));
      when(mockSeriesRepository.isAddedToWatchlistSeries(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      return addedWatchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(AddToWatchListSeries(testSeriesDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWatchlistSeriesLoading(),
      IsAddedWatchlistSeries(
          true, AddedWatchlistSeriesBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<AddedWatchlistSeriesBloc, AddedWatchlistSeriesState>(
    'Should emit [Loading, success] when failed data is gotten successfully',
    build: () {
      when(mockSaveWatchlistSeries.execute(testSeriesDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure(
              AddedWatchlistSeriesBloc.watchlistAddSuccessMessage)));
      when(mockSeriesRepository.isAddedToWatchlistSeries(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      return addedWatchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(AddToWatchListSeries(testSeriesDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWatchlistSeriesLoading(),
      IsAddedWatchlistSeries(
          true, AddedWatchlistSeriesBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<AddedWatchlistSeriesBloc, AddedWatchlistSeriesState>(
    'Should emit [Loading, success] when data is gotten successfully',
    build: () {
      when(mockRemoveWatchlistSeries.execute(testSeriesDetail)).thenAnswer(
          (_) async =>
              const Right(AddedWatchlistSeriesBloc.watchlistAddSuccessMessage));
      when(mockSeriesRepository.isAddedToWatchlistSeries(testSeriesDetail.id))
          .thenAnswer((_) async => true);

      return addedWatchlistSeriesBloc;
    },
    act: (bloc) =>
        bloc.add(RemoveFromWatchListSeries(testSeriesDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWatchlistSeriesLoading(),
      IsAddedWatchlistSeries(
          true, AddedWatchlistSeriesBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
    },
  );

  blocTest<AddedWatchlistSeriesBloc, AddedWatchlistSeriesState>(
    'Should emit [Loading, success] when data is gotten successfully',
    build: () {
      when(mockRemoveWatchlistSeries.execute(testSeriesDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure(
              AddedWatchlistSeriesBloc.watchlistAddSuccessMessage)));
      when(mockSeriesRepository.isAddedToWatchlistSeries(testSeriesDetail.id))
          .thenAnswer((_) async => true);

      return addedWatchlistSeriesBloc;
    },
    act: (bloc) =>
        bloc.add(RemoveFromWatchListSeries(testSeriesDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWatchlistSeriesLoading(),
      IsAddedWatchlistSeries(
          true, AddedWatchlistSeriesBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
    },
  );
}
