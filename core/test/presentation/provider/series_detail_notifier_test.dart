import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/usecases/series/get_series_detail.dart';
import 'package:core/domain/usecases/series/get_series_recommendation.dart';
import 'package:core/domain/usecases/series/get_watchlist_status.dart';
import 'package:core/domain/usecases/series/remove_watchlist_series.dart';
import 'package:core/domain/usecases/series/save_watchlist_series.dart';
import 'package:core/core.dart';
import 'package:core/presentation/provider/series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListSeriesStatus,
  SaveWatchlistSeries,
  RemoveWatchlistSeries,
])
void main() {
  late SeriesDetailNotifier provider;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListSeriesStatus mockGetWatchListSeriesStatus;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchListSeriesStatus = MockGetWatchListSeriesStatus();
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    provider = SeriesDetailNotifier(
      getSeriesDetail: mockGetSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListSeriesStatus: mockGetWatchListSeriesStatus,
      saveWatchlistSeries: mockSaveWatchlistSeries,
      removeWatchlistSeries: mockRemoveWatchlistSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

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

  void _arrangeUsecase() {
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testSeriesDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tListSeries));
  }

  group('Get Movie Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.series, testSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tListSeries);
    });
  });

  group('Get Movie Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesRecommendations.execute(tId));
      expect(provider.seriesRecommendations, tListSeries);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tListSeries);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListSeriesStatus.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
    });

    test('should error remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure("")));
      when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistSeries.execute(testSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tListSeries));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
