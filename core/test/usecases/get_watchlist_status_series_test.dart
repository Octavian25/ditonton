import 'package:core/domain/usecases/series/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListSeriesStatus usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = GetWatchListSeriesStatus(mockSeriesRepository);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockSeriesRepository.isAddedToWatchlistSeries(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
