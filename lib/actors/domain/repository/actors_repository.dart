import 'package:dartz/dartz.dart';
import 'package:movies_app/core/data/error/failure.dart';
import 'package:movies_app/actors/domain/entities/actor.dart';

abstract class ActorsRepository{
  Future<Either<Failure,Actor >> getActorData(int actorId);

}