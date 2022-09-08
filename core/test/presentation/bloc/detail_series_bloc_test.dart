import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/series/detail_series/detail_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../provider/series_detail_notifier_test.mocks.dart';

void main() {
  late DetailSeriesBloc detailSeriesBloc;
  late MockGetSeriesDetail mockGetSeriesDetail;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    detailSeriesBloc = DetailSeriesBloc(mockGetSeriesDetail);
  });

  const tQuery = 1;

  test("initial state should be empty", () {
    expect(detailSeriesBloc.state, DetailSeriesInitial());
  });

  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeriesDetail.execute(tQuery))
          .thenAnswer((_) async => Right(testSeriesDetail));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchDetailSeries(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      DetailSeriesLoading(),
      DetailSeriesHasData(testSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tQuery));
    },
  );

  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetSeriesDetail.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) {
      bloc.add(FetchDetailSeries(tQuery));
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () => [
      DetailSeriesLoading(),
      DetailSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(tQuery));
    },
  );
}
