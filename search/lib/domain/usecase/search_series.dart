import 'package:core/core.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/domain/repositories/series_repository.dart';
import 'package:dartz/dartz.dart';

class SearchSeries {
  final SeriesRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
