import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_popular_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularSeries getPopularSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    getPopularSeries = GetPopularSeries(mockSeriesRepository);
  });
  final tSeries = <Series>[];
  test('should get popular series from repository', () async {
    when(mockSeriesRepository.getPopularSeries())
        .thenAnswer((realInvocation) async => Right(tSeries));
    final result = await getPopularSeries.execute();
    expect(result, Right(tSeries));
  });
}
