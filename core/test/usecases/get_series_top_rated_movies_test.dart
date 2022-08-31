import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_top_rated_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedSeries getTopRatedSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    getTopRatedSeries = GetTopRatedSeries(mockSeriesRepository);
  });
  final tSeries = <Series>[];
  test('should get top rated series from repository', () async {
    when(mockSeriesRepository.getTopRatedSeries())
        .thenAnswer((realInvocation) async => Right(tSeries));

    final result = await getTopRatedSeries.execute();
    expect(result, Right(tSeries));
  });
}
