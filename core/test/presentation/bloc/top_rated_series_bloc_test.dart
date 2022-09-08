import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/series/get_top_rated_series.dart';
import 'package:core/presentation/bloc/series/top_rated_series/top_rated_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late TopRatedSeriesBloc topRatedSeriesBloc;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    topRatedSeriesBloc = TopRatedSeriesBloc(mockGetTopRatedSeries);
  });
  const tQuery = 'spiderman';

  test("initial state should be empty", () {
    expect(topRatedSeriesBloc.state, TopRatedSeriesInitial());
  });

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return topRatedSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedSeries()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );

  blocTest<TopRatedSeriesBloc, TopRatedSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedSeriesBloc;
    },
    act: (bloc) {
      bloc.add(FetchTopRatedSeries());
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedSeriesLoading(),
      TopRatedSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedSeries.execute());
    },
  );
}
