import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/repositories/series_repository.dart';

class GetTopRatedSeries {
  final SeriesRepository repository;

  GetTopRatedSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getTopRatedSeries();
  }
}
