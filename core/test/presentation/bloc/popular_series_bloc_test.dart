import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/series/get_popular_series.dart';
import 'package:core/presentation/bloc/series/popular_series/popular_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late PopularSeriesBloc popularSeriesBloc;
  late MockGetPopularSeries mockGetPopularSeries;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeriesBloc = PopularSeriesBloc(mockGetPopularSeries);
  });

  test("initial state should be empty", () {
    expect(popularSeriesBloc.state, PopularSeriesInitial());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchPopularSeries()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularSeries.execute());
    },
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularSeriesBloc;
    },
    act: (bloc) {
      bloc.add(FetchPopularSeries());
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularSeries.execute());
    },
  );
}
