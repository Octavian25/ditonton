import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/series_local_data_source.dart';
import 'package:core/data/datasources/series_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/series_repository.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/series/get_on_the_air_series.dart';
import 'package:core/domain/usecases/series/get_popular_series.dart';
import 'package:core/domain/usecases/series/get_series_detail.dart';
import 'package:core/domain/usecases/series/get_series_recommendation.dart';
import 'package:core/domain/usecases/series/get_top_rated_series.dart';
import 'package:core/domain/usecases/series/get_watchlist_series.dart';
import 'package:core/domain/usecases/series/get_watchlist_status.dart';
import 'package:core/domain/usecases/series/remove_watchlist_series.dart';
import 'package:core/domain/usecases/series/save_watchlist_series.dart';
import 'package:core/presentation/bloc/movies/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/now_playing/now_playing_bloc_bloc.dart';
import 'package:core/presentation/bloc/movies/top_rated/top_rated_bloc.dart';
import 'package:core/presentation/bloc/movies/added_wachlist_movies/added_wachlist_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/recommendation_movies/recommendation_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/detail_movies/detail_movies/detail_movies_bloc.dart';
import 'package:core/presentation/bloc/movies/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:core/presentation/bloc/series/on_the_air_series/on_the_air_series_bloc.dart';
import 'package:core/presentation/bloc/series/popular_series/popular_series_bloc.dart';
import 'package:core/presentation/bloc/series/top_rated_series/top_rated_series_bloc.dart';
import 'package:core/presentation/bloc/series/added_watchlist_series/added_watchlist_series_bloc.dart';
import 'package:core/presentation/bloc/series/recommendation_series/recommendation_series_bloc.dart';
import 'package:core/presentation/bloc/series/detail_series/detail_series_bloc.dart';
import 'package:core/presentation/bloc/series/watchlist_series/watchlist_series_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/domain/usecase/search_series.dart';
import 'package:search/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:search/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => SearchSeriesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(() => NowPlayingBloc(locator()));
  locator.registerFactory(() => TopRatedBloc(locator()));
  locator.registerFactory(() => OnTheAirSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedSeriesBloc(locator()));
  locator.registerFactory(() => PopularSeriesBloc(locator()));
  locator.registerFactory(() => RecommendationMoviesBloc(locator()));
  locator.registerFactory(() => DetailMoviesBloc(locator()));
  locator.registerFactory(() => RecommendationSeriesBloc(locator()));
  locator.registerFactory(() => DetailSeriesBloc(locator()));
  locator.registerFactory(() => WatchlistMoviesBloc(locator()));
  locator.registerFactory(() => WatchlistSeriesBloc(locator()));
  locator.registerFactory(() => AddedWatchlistSeriesBloc(
      removeWatchlistSeries: locator(),
      saveWatchlistSeries: locator(),
      seriesRepository: locator()));
  locator.registerFactory(() => AddedWachlistMoviesBloc(
      movieRepository: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
      isTestingMode: false));

  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );

  // use case
  //movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //series
  locator.registerLazySingleton(() => GetOnTheAirSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  //end use case

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SeriesRepository>(() => SeriesRepositoryImpl(
      localDataSource: locator(), remoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => SSLPinning.client);
}
