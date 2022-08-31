import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/series_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/network.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/entities/series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testSeries = Series(
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

final testSeriesList = [testSeries];

final testMovieList = [testMovie];

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testSeriesDetail = SeriesDetail(
    adult: false,
    backdropPath: "/9GvhICFMiRQA82vS6ydkXxeEkrd.jpg",
    firstAirDate: DateTime.parse("2022-08-26"),
    genres: const [Genre(id: 35, name: "Comedy")],
    homepage:
        "https://www.disneyplus.com/series/she-hulk-attorney-at-law/gPwaYusKqRQh",
    id: 92783,
    inProduction: true,
    languages: const ["en"],
    lastAirDate: DateTime.parse("2022-08-26"),
    name: "She-Hulk: Attorney at Law",
    networks: const [
      Network(
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

final testSeriesDetail2 = SeriesDetail(
    adult: false,
    backdropPath: "backdropPath",
    firstAirDate: DateTime.parse("2022-08-26"),
    genres: const [Genre(id: 1, name: "Comedy")],
    homepage: "homepage",
    id: 1,
    inProduction: true,
    languages: const ["en"],
    lastAirDate: DateTime.parse("2022-08-26"),
    name: "name",
    networks: const [
      Network(
          id: 2739, name: "Disney+", logoPath: "logoPath", originCountry: "US")
    ],
    numberOfEpisodes: 9,
    numberOfSeasons: 1,
    originCountry: const ["US"],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 7472.908,
    posterPath: "posterPath",
    status: "status",
    tagline: "tagline",
    type: "type",
    voteAverage: 7.384,
    voteCount: 322);

final testWatchlistSeries = Series.watchlist(
    id: 1, overview: "overview", posterPath: "posterPath", name: "name");
final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testSeriesTable = SeriesTable(
    id: 1, name: "name", posterPath: "posterPath", overview: "overview");

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
