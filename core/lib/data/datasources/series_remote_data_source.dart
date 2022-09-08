import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/series_detail_model.dart';
import 'package:core/data/models/series_model.dart';
import 'package:core/data/models/series_response.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getOnTheAirSeries();
  Future<List<SeriesModel>> getPopularSeries();
  Future<List<SeriesModel>> getTopRatedSeries();
  Future<SeriesDetailResponse> getSeriesDetail(int id);
  Future<List<SeriesModel>> getSeriesRecommendations(int id);
  Future<List<SeriesModel>> searchSeries(String query);
}

class SeriesRemoteDataSourceImpl implements SeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  bool isTestingMode;
  SeriesRemoteDataSourceImpl(
      {required this.client, this.isTestingMode = false});

  @override
  Future<SeriesDetailResponse> getSeriesDetail(int id) async {
    try {
      final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

      if (response.statusCode == 200) {
        return SeriesDetailResponse.fromJson(json.decode(response.body));
      } else {
        if (!isTestingMode) {
          FirebaseCrashlytics.instance.crash();
        }
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Search Series API", fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getSeriesRecommendations(int id) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

      if (response.statusCode == 200) {
        return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
      } else {
        if (!isTestingMode) {
          FirebaseCrashlytics.instance.crash();
        }
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Series Recommendations Series API",
            fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getOnTheAirSeries() async {
    try {
      final response =
          await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

      if (response.statusCode == 200) {
        return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
      } else {
        if (!isTestingMode) {
          FirebaseCrashlytics.instance.crash();
        }
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access on The Air Series API", fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularSeries() async {
    try {
      final response =
          await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

      if (response.statusCode == 200) {
        return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
      } else {
        if (!isTestingMode) {
          FirebaseCrashlytics.instance.crash();
        }
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access popular Series API", fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedSeries() async {
    try {
      final response =
          await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));

      if (response.statusCode == 200) {
        return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
      } else {
        if (!isTestingMode) {
          FirebaseCrashlytics.instance.crash();
        }
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Top Rated Series Series API",
            fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchSeries(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

      if (response.statusCode == 200) {
        return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
      } else {
        if (!isTestingMode) {
          FirebaseCrashlytics.instance.crash();
        }
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Search Series API", fatal: true);
      }
      throw ServerException();
    }
  }
}
