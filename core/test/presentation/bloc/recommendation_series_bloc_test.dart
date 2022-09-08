import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/series/get_series_recommendation.dart';
import 'package:core/presentation/bloc/series/recommendation_series/recommendation_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recommendation_series_bloc_test.mocks.dart';

@GenerateMocks([GetSeriesRecommendations])
void main() {
  late RecommendationSeriesBloc recommendationSeriesBloc;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;

  setUp(() {
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    recommendationSeriesBloc =
        RecommendationSeriesBloc(mockGetSeriesRecommendations);
  });

  const tQuery = 1;

  test("initial state should be empty", () {
    expect(recommendationSeriesBloc.state, RecommendationSeriesInitial());
  });

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetSeriesRecommendations.execute(tQuery))
          .thenAnswer((_) async => Right(testSeriesList));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationSeries(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetSeriesRecommendations.execute(tQuery));
    },
  );

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetSeriesRecommendations.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationSeriesBloc;
    },
    act: (bloc) {
      bloc.add(FetchRecommendationSeries(tQuery));
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetSeriesRecommendations.execute(tQuery));
    },
  );
}
