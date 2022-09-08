import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/presentation/bloc/movies/detail_movies/detail_movies/detail_movies_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late DetailMoviesBloc detailMoviesBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMoviesBloc = DetailMoviesBloc(mockGetMovieDetail);
  });

  const tQuery = 1;

  test("initial state should be empty", () {
    expect(detailMoviesBloc.state, DetailMoviesInitial());
  });

  blocTest<DetailMoviesBloc, DetailMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetail.execute(tQuery))
          .thenAnswer((_) async => const Right(testMovieDetail));
      return detailMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchDetailMovies(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      DetailMoviesLoading(),
      DetailMoviesHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tQuery));
    },
  );

  blocTest<DetailMoviesBloc, DetailMoviesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockGetMovieDetail.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMoviesBloc;
    },
    act: (bloc) {
      bloc.add(FetchDetailMovies(tQuery));
    },
    setUp: () {},
    wait: const Duration(milliseconds: 500),
    expect: () => [
      DetailMoviesLoading(),
      DetailMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(tQuery));
    },
  );
}
