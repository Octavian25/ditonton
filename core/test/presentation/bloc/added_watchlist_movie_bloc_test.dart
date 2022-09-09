import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/presentation/bloc/movies/added_wachlist_movies/added_wachlist_movies_bloc.dart';
import 'package:core/presentation/bloc/series/added_watchlist_series/added_watchlist_series_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'added_watchlist_movie_bloc_test.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

@GenerateMocks([MovieRepository, SaveWatchlist, RemoveWatchlist])
void main() {
  late AddedWachlistMoviesBloc addedWachlistMoviesBloc;
  late MockMovieRepository mockMovieRepository;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockBuildContext context;
  setUp(() {
    context = MockBuildContext();
    mockMovieRepository = MockMovieRepository();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    addedWachlistMoviesBloc = AddedWachlistMoviesBloc(
        movieRepository: mockMovieRepository,
        removeWatchlist: mockRemoveWatchlist,
        saveWatchlist: mockSaveWatchlist,
        isTestingMode: true);
  });

  const tQuery = 1;

  test("initial state should be empty", () {
    expect(addedWachlistMoviesBloc.state, AddedWachlistMoviesInitial());
  });

  blocTest<AddedWachlistMoviesBloc, AddedWachlistMoviesState>(
    'Should emit [Loading, addedwatchlist] when data is gotten successfully',
    build: () {
      when(mockMovieRepository.isAddedToWatchlist(tQuery))
          .thenAnswer((_) async => true);
      return addedWachlistMoviesBloc;
    },
    act: (bloc) => bloc.add(FetchAddedWachlistMovies(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      IsAddedWatchList(true, "Initial Message"),
    ],
    verify: (bloc) {
      verify(mockMovieRepository.isAddedToWatchlist(tQuery));
    },
  );
  blocTest<AddedWachlistMoviesBloc, AddedWachlistMoviesState>(
    'Should emit [Loading, success] when data is gotten successfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
          const Right(AddedWatchlistSeriesBloc.watchlistAddSuccessMessage));
      when(mockMovieRepository.isAddedToWatchlist(tQuery))
          .thenAnswer((_) async => true);
      return addedWachlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddToWatchListMovies(testMovieDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWachlistMoviesLoading(),
      IsAddedWatchList(
          true, AddedWachlistMoviesBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<AddedWachlistMoviesBloc, AddedWachlistMoviesState>(
    'Should emit [Loading, success] when add failed data is gotten successfully',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
          const Left(DatabaseFailure(
              AddedWachlistMoviesBloc.watchlistAddSuccessMessage)));
      when(mockMovieRepository.isAddedToWatchlist(tQuery))
          .thenAnswer((_) async => true);
      return addedWachlistMoviesBloc;
    },
    act: (bloc) => bloc.add(AddToWatchListMovies(testMovieDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWachlistMoviesLoading(),
      IsAddedWatchList(
          true, AddedWachlistMoviesBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<AddedWachlistMoviesBloc, AddedWachlistMoviesState>(
    'Should emit [Loading, failed] when data is gotten successfully',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
          const Right(AddedWachlistMoviesBloc.watchlistAddSuccessMessage));
      when(mockMovieRepository.isAddedToWatchlist(tQuery))
          .thenAnswer((_) async => true);

      return addedWachlistMoviesBloc;
    },
    act: (bloc) =>
        bloc.add(RemoveFromWatchListMovies(testMovieDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWachlistMoviesLoading(),
      IsAddedWatchList(
          true, AddedWachlistMoviesBloc.watchlistAddSuccessMessage),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<AddedWachlistMoviesBloc, AddedWachlistMoviesState>(
    'Should emit [Loading, failed] when failed data is gotten successfully',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure("Error")));
      when(mockMovieRepository.isAddedToWatchlist(tQuery))
          .thenAnswer((_) async => true);

      return addedWachlistMoviesBloc;
    },
    act: (bloc) =>
        bloc.add(RemoveFromWatchListMovies(testMovieDetail, context)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      AddedWachlistMoviesLoading(),
      IsAddedWatchList(true, "Error"),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}
