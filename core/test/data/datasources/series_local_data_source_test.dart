import 'package:core/core.dart';

import 'package:core/data/datasources/series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl seriesLocalDataSourceImpl;
  late MockDatabaseHelper mockDatabaseHelper;

  setUpAll(() {
    mockDatabaseHelper = MockDatabaseHelper();
    seriesLocalDataSourceImpl =
        SeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group("Insert Watch List Series", () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelper.insertWatchlistSeries(testSeriesTable))
          .thenAnswer((realInvocation) async => 1);
      final result = await seriesLocalDataSourceImpl
          .insertWatchlistSeries(testSeriesTable);

      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelper.insertWatchlistSeries(testSeriesTable))
          .thenThrow(Exception());

      final call =
          seriesLocalDataSourceImpl.insertWatchlistSeries(testSeriesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group("Remove Watch List Series", () {
    test(
        'should return success message when removed data on database is success',
        () async {
      when(mockDatabaseHelper.removeWatchlistSeries(testSeriesTable))
          .thenAnswer((realInvocation) async => 1);
      final result = await seriesLocalDataSourceImpl
          .removeWatchlistSeries(testSeriesTable);

      expect(result, 'Removed from Watchlist');
    });

    test(
        'should throw DatabaseException when remove data on database is failed',
        () async {
      when(mockDatabaseHelper.removeWatchlistSeries(testSeriesTable))
          .thenThrow(Exception());

      final call =
          seriesLocalDataSourceImpl.removeWatchlistSeries(testSeriesTable);

      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Series Detail By Id', () {
    const tId = 1;

    test('should return Series Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId))
          .thenAnswer((_) async => testSeriesMap);
      // act
      final result = await seriesLocalDataSourceImpl.getSeriesById(tId);
      // assert
      expect(result, testSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await seriesLocalDataSourceImpl.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist Series', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await seriesLocalDataSourceImpl.getWatchlistSeries();
      // assert
      expect(result, [testSeriesTable]);
    });
  });
}
