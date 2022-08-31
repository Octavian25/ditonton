import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/series/remove_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistSeries removeWatchlistSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    removeWatchlistSeries = RemoveWatchlistSeries(mockSeriesRepository);
  });

  test('should return message string from repository', () async {
    when(mockSeriesRepository.removeWatchlistSeries(testSeriesDetail))
        .thenAnswer((realInvocation) async =>
            const Right("Series Removed From Watchlist"));
    final result = await removeWatchlistSeries.execute(testSeriesDetail);
    expect(result, const Right("Series Removed From Watchlist"));
  });
}
