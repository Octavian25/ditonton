import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/series/watchlist_series/watchlist_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../provider/watchlist_series_notifier_test.mocks.dart';

void main() {
  late WatchlistSeriesBloc watchlistSeriesBloc;
  late MockGetWatchlistSeries mockGetWatchlistSeries;

  setUp(() {
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    watchlistSeriesBloc = WatchlistSeriesBloc(mockGetWatchlistSeries);
  });

  const tQuery = 1;

  test("initial state should be empty", () {
    expect(watchlistSeriesBloc.state, WatchlistSeriesInitial());
  });

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return watchlistSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistSeries()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistSeriesLoading(),
      WatchlistSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistSeries.execute());
    },
  );

  blocTest<WatchlistSeriesBloc, WatchlistSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetWatchlistSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistSeriesBloc;
    },
    act: (bloc) {
      bloc.add(FetchWatchlistSeries());
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () =>
        [WatchlistSeriesLoading(), WatchlistSeriesError('Server Failure')],
    verify: (bloc) {
      verify(mockGetWatchlistSeries.execute());
    },
  );
}
