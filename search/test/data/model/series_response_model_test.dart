import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/models/series_model.dart';
import 'package:core/data/models/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
  final tSeriesResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSeriesModel]);

  group("fromJson", () {
    test('should return valid model from json', () {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/search_hulk_series.json'));
      final result = SeriesResponse.fromJson(jsonMap);
      expect(result, tSeriesResponseModel);
    });
  });

  group("toJson", () {
    test('"should return Json map from model given"', () {
      final result = tSeriesResponseModel.toJson();

      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
            "first_air_date": "2022-08-26",
            "genre_ids": [35, 10759, 10765],
            "id": 92783,
            "name": "She-Hulk: Attorney at Law",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "She-Hulk: Attorney at Law",
            "overview":
                "Jennifer Walters navigates the complicated life of a single, 30-something attorney who also happens to be a green 6-foot-7-inch superpowered hulk.",
            "popularity": 7472.908,
            "poster_path": "/hJfI6AGrmr4uSHRccfJuSsapvOb.jpg",
            "vote_average": 7.4,
            "vote_count": 308
          }
        ]
      };
      expect(expectedJsonMap, result);
    });
  });
}
