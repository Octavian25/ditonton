import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/movie_detail_notifier_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMoviesBloc =
        RecommendationMoviesBloc(mockGetMovieRecommendations);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 1;

  test("initial state should be empty", () {
    expect(recommendationMoviesBloc.state, RecommendationMoviesInitial());
  });

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return recommendationMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchRecommendationMovies(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tQuery));
    },
  );

  blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationMoviesBloc;
    },
    act: (bloc) {
      bloc.add(FetchRecommendationMovies(tQuery));
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tQuery));
    },
  );
}
