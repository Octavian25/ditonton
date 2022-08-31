import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/network_model.dart';
import 'package:core/data/models/series_detail_model.dart';
import 'package:core/data/models/series_model.dart';
import 'package:core/data/models/series_table.dart';
import 'package:core/domain/entities/series.dart';
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

  test("Should Return subclass movie entity", () async {
    final result = tSeriesModel.toEntity();
    expect(tSeries, result);
  });
  test("Should return jsonmap form model given", () {
    final response = SeriesDetailResponse(
            adult: false,
            backdropPath: "backdropPath",
            firstAirDate: DateTime.parse("2022-02-02"),
            genres: const [GenreModel(id: 1, name: "name")],
            homepage: "homepage",
            id: 1,
            inProduction: false,
            languages: const ["US"],
            lastAirDate: DateTime.parse("2022-02-02"),
            name: "name",
            networks: const [
              NetworkResponse(
                  id: 1,
                  name: "name",
                  logoPath: "logoPath",
                  originCountry: "originCountry")
            ],
            numberOfEpisodes: 1,
            numberOfSeasons: 1,
            originCountry: const ["originCountry"],
            originalLanguage: "originalLanguage",
            originalName: "originalName",
            overview: "overview",
            popularity: 1,
            posterPath: "posterPath",
            status: "status",
            tagline: "tagline",
            type: "type",
            voteAverage: 1,
            voteCount: 1)
        .toJson();
    final result = {
      "adult": false,
      "backdrop_path": "backdropPath",
      "first_air_date": "2022-02-02",
      "genres": [const GenreModel(id: 1, name: "name").toJson()],
      "homepage": "homepage",
      "id": 1,
      "in_production": false,
      "languages": ["US"],
      "last_air_date": "2022-02-02",
      "name": "name",
      "networks": [
        const NetworkResponse(
                id: 1,
                name: "name",
                logoPath: "logoPath",
                originCountry: "originCountry")
            .toJson()
      ],
      "number_of_episodes": 1,
      "number_of_seasons": 1,
      "origin_country": ["originCountry"],
      "original_language": "originalLanguage",
      "original_name": "originalName",
      "overview": "overview",
      "popularity": 1,
      "poster_path": "posterPath",
      "status": "status",
      "tagline": "tagline",
      "type": "type",
      "vote_average": 1,
      "vote_count": 1,
    };
    expect(result, response);
  });

  test("seriesTable to json", () {
    final response = const SeriesTable(
            id: 1, name: "name", posterPath: "posterPath", overview: "overview")
        .toJson();
    final result = {
      "id": 1,
      "name": "name",
      "posterPath": "posterPath",
      "overview": "overview"
    };
    expect(result, response);
  });
}
