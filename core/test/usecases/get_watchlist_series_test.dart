import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/series/get_watchlist_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistSeries getWatchlistSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    getWatchlistSeries = GetWatchlistSeries(mockSeriesRepository);
  });

  test('should get watchlist series from repository', () async {
    when(mockSeriesRepository.getWatchlistSeries())
        .thenAnswer((realInvocation) async => Right(testSeriesList));
    final result = await getWatchlistSeries.execute();
    expect(result, Right(testSeriesList));
  });
}
