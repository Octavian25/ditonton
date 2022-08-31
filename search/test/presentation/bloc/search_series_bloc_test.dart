import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../provider/series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc searchSeriesBloc;
  late MockSearchSeries mockSearchSeries;

  setUpAll(() {
    mockSearchSeries = MockSearchSeries();
    searchSeriesBloc = SearchSeriesBloc(mockSearchSeries);
  });

  final tSeriesModel = Series(
      backdropPath: "backdropPath",
      firstAirDate: DateTime.now(),
      genreIds: const [1, 2, 3],
      id: 1,
      name: "name",
      originCountry: const ["originCountry"],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      voteAverage: 1,
      voteCount: 1);
  final tSeriesListModel = [tSeriesModel];
  const tQuery = "hulk";

  group("Testing Search Series Bloc", () {
    blocTest<SearchSeriesBloc, SearchSeriesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tSeriesListModel));
        return searchSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnQuerySeriesChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchSeriesLoading(),
        SearchSeriesHasData(tSeriesListModel),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      },
    );

    blocTest<SearchSeriesBloc, SearchSeriesState>(
      'Should emit [Loading, Error] when data is gotten unsuccess',
      build: () {
        when(mockSearchSeries.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure("Server failure")));
        return searchSeriesBloc;
      },
      act: (bloc) => bloc.add(const OnQuerySeriesChanged(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchSeriesLoading(),
        const SearchSeriesError("Server failure"),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      },
    );

    tearDown(() {
      searchSeriesBloc.close();
    });
  });
}
