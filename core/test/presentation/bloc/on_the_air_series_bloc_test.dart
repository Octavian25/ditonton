import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/series/get_on_the_air_series.dart';
import 'package:core/presentation/bloc/series/on_the_air_series/on_the_air_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'on_the_air_series_bloc_test.mocks.dart';

@GenerateMocks([GetOnTheAirSeries])
void main() {
  late OnTheAirSeriesBloc onTheAirSeriesBloc;
  late MockGetOnTheAirSeries mockGetOnTheAirSeries;

  setUp(() {
    mockGetOnTheAirSeries = MockGetOnTheAirSeries();
    onTheAirSeriesBloc = OnTheAirSeriesBloc(mockGetOnTheAirSeries);
  });

  const tQuery = 1;

  test("initial state should be empty", () {
    expect(onTheAirSeriesBloc.state, OnTheAirSeriesInitial());
  });

  blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return onTheAirSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirSeries()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      OnTheAirSeriesLoading(),
      OnTheAirSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirSeries.execute());
    },
  );

  blocTest<OnTheAirSeriesBloc, OnTheAirSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetOnTheAirSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return onTheAirSeriesBloc;
    },
    act: (bloc) {
      bloc.add(FetchOnTheAirSeries());
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () => [
      OnTheAirSeriesLoading(),
      OnTheAirSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirSeries.execute());
    },
  );
}
