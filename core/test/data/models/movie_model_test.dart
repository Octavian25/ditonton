import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_table.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieModel = MovieModel(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  const tMovieDetialRepsonse = MovieDetailResponse(
      adult: false,
      backdropPath: "backdropPath",
      budget: 1,
      genres: [GenreModel(id: 1, name: "name")],
      homepage: "homepage",
      id: 1,
      imdbId: "imdbId",
      originalLanguage: "originalLanguage",
      originalTitle: "originalTitle",
      overview: "overview",
      popularity: 1,
      posterPath: "posterPath",
      releaseDate: "releaseDate",
      revenue: 2,
      runtime: 120,
      status: "status",
      tagline: "tagline",
      title: "title",
      video: false,
      voteAverage: 1,
      voteCount: 1);

  test('should be a subclass of Movie entity', () async {
    final result = tMovieModel.toEntity();
    expect(result, tMovie);
  });
  test("should return JsonMap from model given", () {
    final response = tMovieDetialRepsonse.toJson();
    final result = {
      "adult": false,
      "backdrop_path": "backdropPath",
      "budget": 1,
      "genres": [const GenreModel(id: 1, name: "name").toJson()],
      "homepage": "homepage",
      "id": 1,
      "imdb_id": "imdbId",
      "original_language": "originalLanguage",
      "original_title": "originalTitle",
      "overview": "overview",
      "popularity": 1,
      "poster_path": "posterPath",
      "release_date": "releaseDate",
      "revenue": 2,
      "runtime": 120,
      "status": "status",
      "tagline": "tagline",
      "title": "title",
      "video": false,
      "vote_average": 1,
      "vote_count": 1
    };
    expect(result, response);
  });
  test("movietable to json", () {
    final response = const MovieTable(
            id: 1,
            title: "title",
            posterPath: "posterPath",
            overview: "overview")
        .toJson();
    final result = {
      "id": 1,
      "title": "title",
      "posterPath": "posterPath",
      "overview": "overview"
    };
    expect(result, response);
  });
}
