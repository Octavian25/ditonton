import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_on_the_air_series.dart';
import 'package:core/domain/usecases/series/get_popular_series.dart';
import 'package:core/domain/usecases/series/get_top_rated_series.dart';
import 'package:core/presentation/provider/series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirSeries, GetPopularSeries, GetTopRatedSeries])
void main() {
  late SeriesListNotifier provider;
  late MockGetOnTheAirSeries mockGetOnTheAirSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirSeries = MockGetOnTheAirSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = SeriesListNotifier(
      getOnTheAirSeries: mockGetOnTheAirSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tSeries = Series(
      backdropPath: "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
      firstAirDate: DateTime.parse("2022-08-26"),
      genreIds: const [35],
      id: 92783,
      name: "She-Hulk: Attorney at Law",
      originCountry: const ["US"],
      originalLanguage: "en",
      originalName: "She-Hulk: Attorney at Law",
      overview:
          "Jennifer Walters navigates the complicated life of a single, 30-something attorney who also happens to be a green 6-foot-7-inch superpowered hulk.",
      popularity: 7472.908,
      posterPath: "/hJfI6AGrmr4uSHRccfJuSsapvOb.jpg",
      voteAverage: 7.384,
      voteCount: 322);
  final tListSeries = <Series>[tSeries];

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(provider.onTheAirSeriesState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirSeries.execute())
          .thenAnswer((_) async => Right(tListSeries));
      // act
      provider.fetchOnTheAirSeries();
      // assert
      verify(mockGetOnTheAirSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirSeries.execute())
          .thenAnswer((_) async => Right(tListSeries));
      // act
      provider.fetchOnTheAirSeries();
      // assert
      expect(provider.onTheAirSeriesState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirSeries.execute())
          .thenAnswer((_) async => Right(tListSeries));
      // act
      await provider.fetchOnTheAirSeries();
      // assert
      expect(provider.onTheAirSeriesState, RequestState.Loaded);
      expect(provider.onTheAirSeries, tListSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirSeries();
      // assert
      expect(provider.onTheAirSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tListSeries));
      // act
      provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tListSeries));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Loaded);
      expect(provider.popularSeries, tListSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tListSeries));
      // act
      provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tListSeries));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Loaded);
      expect(provider.topRatedSeries, tListSeries);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
