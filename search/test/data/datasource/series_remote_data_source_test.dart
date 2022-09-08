// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:core/core.dart';

import 'package:core/data/datasources/series_remote_data_source.dart';
import 'package:core/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    dataSource =
        SeriesRemoteDataSourceImpl(client: mockHttpClient, isTestingMode: true);
  });

  group('search series', () {
    final tSearchResult = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_hulk_series.json')))
        .seriesList;
    const tQuery = 'Spiderman';

    test('should return list of series when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_hulk_series.json'), 200));
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
