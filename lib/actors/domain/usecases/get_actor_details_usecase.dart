import 'package:dartz/dartz.dart';
import 'package:movies_app/actors/domain/entities/actor.dart';
import 'package:movies_app/actors/domain/repository/actors_repository.dart';

import 'package:movies_app/core/data/error/failure.dart';
import 'package:movies_app/core/domain/usecase/base_use_case.dart';

class GetActorDetailsUseCase extends BaseUseCase<Actor, int> {
  final ActorsRepository _baseActorsRepository;

  GetActorDetailsUseCase(this._baseActorsRepository);

  @override
  Future<Either<Failure, Actor>> call(int p) async {
    return await _baseActorsRepository.getActorData(p);
  }
}
