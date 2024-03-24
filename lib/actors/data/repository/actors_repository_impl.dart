import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/actors/domain/entities/actor.dart';
import 'package:movies_app/actors/domain/repository/actors_repository.dart';
import 'package:movies_app/core/data/error/failure.dart';
import 'package:movies_app/actors/data/datasource/actors_remote_data_source.dart';
import 'package:movies_app/core/data/error/exceptions.dart';

class ActorsRepositoryImpl implements ActorsRepository {
  final ActorsRemoteDataSource _baseActorsRemoteDataSource;

  ActorsRepositoryImpl(this._baseActorsRemoteDataSource);

  @override
  Future<Either<Failure, Actor>> getActorData(int actorId) async {
    try {
      final result = await _baseActorsRemoteDataSource.getActorData(actorId);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioError catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }
}
