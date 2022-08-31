import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:core/domain/repositories/series_repository.dart';

class SaveWatchlistSeries {
  final SeriesRepository repository;

  SaveWatchlistSeries(this.repository);

  Future<Either<Failure, String>> execute(SeriesDetail series) {
    return repository.saveWatchlistSeries(series);
  }
}
