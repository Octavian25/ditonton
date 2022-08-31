import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/series/get_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetSeriesDetail getSeriesDetail;
  late MockSeriesRepository mockSeriesRepository;

  setUpAll(() {
    mockSeriesRepository = MockSeriesRepository();
    getSeriesDetail = GetSeriesDetail(mockSeriesRepository);
  });
  const tId = 1;

  test('should get series detail from the repository', () async {
    when(mockSeriesRepository.getSeriesDetail(tId))
        .thenAnswer((realInvocation) async => Right(testSeriesDetail));

    final result = await getSeriesDetail.execute(tId);
    expect(result, Right(testSeriesDetail));
  });
}
