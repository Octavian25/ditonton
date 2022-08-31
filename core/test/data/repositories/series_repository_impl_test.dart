import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/network_model.dart';
import 'package:core/data/models/series_detail_model.dart';
import 'package:core/data/models/series_model.dart';
import 'package:core/data/repositories/series_repository_impl.dart';
import 'package:core/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSeriesLocalDataSource mockSeriesLocalDataSource;
  late MockSeriesRemoteDataSource mockSeriesRemoteDataSource;
  late SeriesRepositoryImpl seriesRepositoryImpl;

  setUpAll(() {
    mockSeriesLocalDataSource = MockSeriesLocalDataSource();
    mockSeriesRemoteDataSource = MockSeriesRemoteDataSource();
    seriesRepositoryImpl = SeriesRepositoryImpl(
        localDataSource: mockSeriesLocalDataSource,
        remoteDataSource: mockSeriesRemoteDataSource);
  });

  final tSeriesModel = SeriesModel(
      backdropPath: "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
      firstAirDate: DateTime.parse("2022-08-26"),
      genreIds: const [35, 10759, 10765],
      id: 92783,
      name: "She-Hulk: Attorney at Law",
      originCountry: const ['US'],
      originalLanguage: "en",
      originalName: "She-Hulk: Attorney at Law",
      overview:
          "Jennifer Walters navigates the complicated life of a single, 30-something attorney who also happens to be a green 6-foot-7-inch superpowered hulk.",
      popularity: 7472.908,
      posterPath: "/hJfI6AGrmr4uSHRccfJuSsapvOb.jpg",
      voteAverage: 7.4,
      voteCount: 308);

  final tSeries = Series(
      backdropPath: "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
      firstAirDate: DateTime.parse("2022-08-26"),
      genreIds: const [35, 10759, 10765],
      id: 92783,
      name: "She-Hulk: Attorney at Law",
      originCountry: const ['US'],
      originalLanguage: "en",
      originalName: "She-Hulk: Attorney at Law",
      overview:
          "Jennifer Walters navigates the complicated life of a single, 30-something attorney who also happens to be a green 6-foot-7-inch superpowered hulk.",
      popularity: 7472.908,
      posterPath: "/hJfI6AGrmr4uSHRccfJuSsapvOb.jpg",
      voteAverage: 7.4,
      voteCount: 308);

  final tSeriesModelList = <SeriesModel>[tSeriesModel];
  final tSeriesList = <Series>[tSeries];

  group('Popular Series', () {
    test("should return list series when call to remote database when success",
        () async {
      when(mockSeriesRemoteDataSource.getPopularSeries())
          .thenAnswer((_) async => tSeriesModelList);
      final result = await seriesRepositoryImpl.getPopularSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });
    test('should return server failure when call to remote datbaase is failed',
        () async {
      when(mockSeriesRemoteDataSource.getPopularSeries())
          .thenThrow(ServerException());
      final result = await seriesRepositoryImpl.getPopularSeries();
      expect(result, const Left(ServerFailure("")));
    });
    test('should return connection failure when no internet on device',
        () async {
      when(mockSeriesRemoteDataSource.getPopularSeries())
          .thenThrow(const SocketException("Failed to connect to the network"));
      final result = await seriesRepositoryImpl.getPopularSeries();
      expect(result,
          const Left(ConnectionFailure("Failed to connect to the network")));
    });
  });
  group("Top Rated Series", () {
    test("should return list series when call to remote database when success ",
        () async {
      when(mockSeriesRemoteDataSource.getTopRatedSeries())
          .thenAnswer((realInvocation) async => tSeriesModelList);
      final result = await seriesRepositoryImpl.getTopRatedSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });
    test('should return server failure when call to remote datbaase is failed',
        () async {
      when(mockSeriesRemoteDataSource.getTopRatedSeries())
          .thenThrow(ServerException());
      final result = await seriesRepositoryImpl.getTopRatedSeries();
      expect(result, const Left(ServerFailure("")));
    });
    test('should return connection failure when no internet on device',
        () async {
      when(mockSeriesRemoteDataSource.getTopRatedSeries())
          .thenThrow(const SocketException("Failed to connect to the network"));
      final result = await seriesRepositoryImpl.getTopRatedSeries();
      expect(result,
          const Left(ConnectionFailure("Failed to connect to the network")));
    });
  });

  group("Recommendation Series", () {
    const tId = 1;
    test("should return list series when call to remote database when success ",
        () async {
      when(mockSeriesRemoteDataSource.getSeriesRecommendations(tId))
          .thenAnswer((realInvocation) async => tSeriesModelList);
      final result = await seriesRepositoryImpl.getSeriesRecommendations(tId);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });
    test('should return server failure when call to remote datbaase is failed',
        () async {
      when(mockSeriesRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(ServerException());
      final result = await seriesRepositoryImpl.getSeriesRecommendations(tId);
      expect(result, const Left(ServerFailure("")));
    });
    test('should return connection failure when no internet on device',
        () async {
      when(mockSeriesRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(const SocketException("Failed to connect to the network"));
      final result = await seriesRepositoryImpl.getSeriesRecommendations(tId);
      expect(result,
          const Left(ConnectionFailure("Failed to connect to the network")));
    });
  });

  group("On The Air Series", () {
    test("should return list series when call to remote database when success ",
        () async {
      when(mockSeriesRemoteDataSource.getOnTheAirSeries())
          .thenAnswer((realInvocation) async => tSeriesModelList);
      final result = await seriesRepositoryImpl.getOnTheAirSeries();
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });
    test('should return server failure when call to remote datbaase is failed',
        () async {
      when(mockSeriesRemoteDataSource.getOnTheAirSeries())
          .thenThrow(ServerException());
      final result = await seriesRepositoryImpl.getOnTheAirSeries();
      expect(result, const Left(ServerFailure("")));
    });
    test('should return connection failure when no internet on device',
        () async {
      when(mockSeriesRemoteDataSource.getOnTheAirSeries())
          .thenThrow(const SocketException("Failed to connect to the network"));
      final result = await seriesRepositoryImpl.getOnTheAirSeries();
      expect(result,
          const Left(ConnectionFailure("Failed to connect to the network")));
    });
  });

  group("Get Series Detail", () {
    const tId = 1;
    final tSeriesDetail = SeriesDetailResponse(
        adult: false,
        backdropPath: "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
        firstAirDate: DateTime.parse("2022-08-26"),
        genres: const [GenreModel(id: 35, name: "Comedy")],
        homepage:
            "https://www.disneyplus.com/series/she-hulk-attorney-at-law/gPwaYusKqRQh",
        id: 92783,
        inProduction: true,
        languages: const ["en"],
        lastAirDate: DateTime.parse("2022-08-26"),
        name: "She-Hulk: Attorney at Law",
        networks: const [
          NetworkResponse(
              id: 2739,
              name: "Disney+",
              logoPath: "/uzKjVDmQ1WRMvGBb7UNRE0wTn1H.png",
              originCountry: "US")
        ],
        numberOfEpisodes: 9,
        numberOfSeasons: 1,
        originCountry: const ["US"],
        originalLanguage: "en",
        originalName: "She-Hulk: Attorney at Law",
        overview:
            "Jennifer Walters navigates the complicated life of a single, 30-something attorney who also happens to be a green 6-foot-7-inch superpowered hulk.",
        popularity: 7472.908,
        posterPath: "/hJfI6AGrmr4uSHRccfJuSsapvOb.jpg",
        status: "Returning Series",
        tagline: "You'll like her when she's angry.",
        type: "Miniseries",
        voteAverage: 7.384,
        voteCount: 322);
    test("should return series detail from repository", () async {
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId))
          .thenAnswer((realInvocation) async => tSeriesDetail);
      final result = await seriesRepositoryImpl.getSeriesDetail(tId);
      verify(mockSeriesRemoteDataSource.getSeriesDetail(tId));
      expect(result, Right(testSeriesDetail));
    });
    test('should return server failure when call to remote datbaase is failed',
        () async {
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(ServerException());
      final result = await seriesRepositoryImpl.getSeriesDetail(tId);
      expect(result, const Left(ServerFailure("")));
    });
    test('should return connection failure when no internet on device',
        () async {
      when(mockSeriesRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(const SocketException("Failed to connect to the network"));
      final result = await seriesRepositoryImpl.getSeriesDetail(tId);
      expect(result,
          const Left(ConnectionFailure("Failed to connect to the network")));
    });
  });

  group('Seach Series', () {
    const tQuery = 'hulk';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery))
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await seriesRepositoryImpl.searchSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await seriesRepositoryImpl.searchSeries(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockSeriesRemoteDataSource.searchSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await seriesRepositoryImpl.searchSeries(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockSeriesLocalDataSource.insertWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result =
          await seriesRepositoryImpl.saveWatchlistSeries(testSeriesDetail2);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockSeriesLocalDataSource.insertWatchlistSeries(testSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result =
          await seriesRepositoryImpl.saveWatchlistSeries(testSeriesDetail2);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockSeriesLocalDataSource.removeWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result =
          await seriesRepositoryImpl.removeWatchlistSeries(testSeriesDetail2);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockSeriesLocalDataSource.removeWatchlistSeries(testSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result =
          await seriesRepositoryImpl.removeWatchlistSeries(testSeriesDetail2);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockSeriesLocalDataSource.getSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await seriesRepositoryImpl.isAddedToWatchlistSeries(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of Series', () async {
      // arrange
      when(mockSeriesLocalDataSource.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesTable]);
      // act
      final result = await seriesRepositoryImpl.getWatchlistSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeries]);
    });
  });
}
