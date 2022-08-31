import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_on_the_air_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late GetOnTheAirSeries getOnTheAirSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    getOnTheAirSeries = GetOnTheAirSeries(mockSeriesRepository);
  });
  final tSeries = <Series>[];
  test('should get top rated series from repository', () async {
    when(mockSeriesRepository.getOnTheAirSeries())
        .thenAnswer((realInvocation) async => Right(tSeries));

    final result = await getOnTheAirSeries.execute();
    expect(result, Right(tSeries));
  });
}
