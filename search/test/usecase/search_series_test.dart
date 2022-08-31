import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/series.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_series.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late SearchSeries searchSeries;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    searchSeries = SearchSeries(mockSeriesRepository);
  });

  final tSeries = <Series>[];
  const query = "hulk";
  test('should get list series depend on query from repository', () async {
    when(mockSeriesRepository.searchSeries(query))
        .thenAnswer((realInvocation) async => Right(tSeries));
    final result = await searchSeries.execute(query);
    expect(result, Right(tSeries));
  });
}
