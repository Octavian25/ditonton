import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
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
}
