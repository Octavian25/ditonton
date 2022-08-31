import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/series/save_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistSeries saveWatchlistSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    saveWatchlistSeries = SaveWatchlistSeries(mockSeriesRepository);
  });

  test('should return string when success add to watchlist', () async {
    when(mockSeriesRepository.saveWatchlistSeries(testSeriesDetail)).thenAnswer(
        (realInvocation) async => const Right("Added to Watchlist Series"));
    final result = await saveWatchlistSeries.execute(testSeriesDetail);
    expect(result, const Right("Added to Watchlist Series"));
  });
}
