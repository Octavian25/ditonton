import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/entities/series_detail.dart';

abstract class SeriesRepository {
  Future<Either<Failure, List<Series>>> getOnTheAirSeries();
  Future<Either<Failure, List<Series>>> getPopularSeries();
  Future<Either<Failure, List<Series>>> getTopRatedSeries();
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id);
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id);
  Future<Either<Failure, List<Series>>> searchSeries(String query);
  Future<Either<Failure, String>> saveWatchlistSeries(SeriesDetail movie);
  Future<Either<Failure, String>> removeWatchlistSeries(SeriesDetail movie);
  Future<bool> isAddedToWatchlistSeries(int id);
  Future<Either<Failure, List<Series>>> getWatchlistSeries();
}
