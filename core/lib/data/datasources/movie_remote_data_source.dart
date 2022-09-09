import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;
  bool isTestingMode;
  MovieRemoteDataSourceImpl({required this.client, this.isTestingMode = false});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      final response =
          await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Now Playing Movies API", fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    try {
      final response =
          await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

      if (response.statusCode == 200) {
        return MovieDetailResponse.fromJson(json.decode(response.body));
      } else {
        throw SSLException();
      }
    } on TlsException {
      throw ServerException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Detail Movies API", fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw SSLException();
      }
    } on TlsException {
      throw ServerException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Recommendations Movies API",
            fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response =
          await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
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
            reason: "Error When Access Popular Movies API", fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response =
          await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
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
            reason: "Error When Access Top Rated Movies API", fatal: true);
      }
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

      if (response.statusCode == 200) {
        return MovieResponse.fromJson(json.decode(response.body)).movieList;
      } else {
        throw ServerException();
      }
    } on TlsException {
      throw SSLException();
    } catch (e, s) {
      if (!isTestingMode) {
        FirebaseCrashlytics.instance.recordError(e, s,
            reason: "Error When Access Search Movies API", fatal: true);
      }
      throw ServerException();
    }
  }
}
