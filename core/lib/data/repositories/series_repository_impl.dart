import 'dart:io';

import 'package:core/data/datasources/series_local_data_source.dart';
import 'package:core/data/datasources/series_remote_data_source.dart';
import 'package:core/data/models/series_table.dart';
import 'package:core/domain/entities/series_detail.dart';
import 'package:core/domain/entities/series.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/repositories/series_repository.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final SeriesRemoteDataSource remoteDataSource;
  final SeriesLocalDataSource localDataSource;

  SeriesRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Series>>> getPopularSeries() async {
    try {
      final result = await remoteDataSource.getPopularSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(CommonFailure('Certificated not valid'));
    } on SSLException {
      return const Left(CommonFailure('Certificated not valid'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SeriesDetail>> getSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(CommonFailure('Certificated not valid'));
    } on SSLException {
      return const Left(CommonFailure('Certificated not valid'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getSeriesRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(CommonFailure('Certificated not valid'));
    } on SSLException {
      return const Left(CommonFailure('Certificated not valid'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getTopRatedSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(CommonFailure('Certificated not valid'));
    } on SSLException {
      return const Left(CommonFailure('Certificated not valid'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getWatchlistSeries() async {
    final result = await localDataSource.getWatchlistSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlistSeries(int id) async {
    final result = await localDataSource.getSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistSeries(
      SeriesDetail series) async {
    try {
      final result = await localDataSource
          .removeWatchlistSeries(SeriesTable.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistSeries(
      SeriesDetail movie) async {
    try {
      final result = await localDataSource
          .insertWatchlistSeries(SeriesTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<Series>>> searchSeries(String query) async {
    try {
      final result = await remoteDataSource.searchSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(CommonFailure('Certificated not valid'));
    } on SSLException {
      return const Left(CommonFailure('Certificated not valid'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Series>>> getOnTheAirSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(CommonFailure('Certificated not valid'));
    } on SSLException {
      return const Left(CommonFailure('Certificated not valid'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
