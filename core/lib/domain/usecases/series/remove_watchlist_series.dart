import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:core/domain/repositories/series_repository.dart';

class RemoveWatchlistSeries {
  final SeriesRepository repository;

  RemoveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) {
    return repository.removeWatchlistSeries(series);
  }
}
