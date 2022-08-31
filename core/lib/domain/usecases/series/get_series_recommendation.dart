import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/repositories/series_repository.dart';

class GetSeriesRecommendations {
  final SeriesRepository repository;

  GetSeriesRecommendations(this.repository);

  Future<Either<Failure, List<Series>>> execute(id) {
    return repository.getSeriesRecommendations(id);
  }
}
