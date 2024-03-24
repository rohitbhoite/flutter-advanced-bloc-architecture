import 'package:dio/dio.dart';
import 'package:movies_app/actors/data/models/actor_model.dart';
import 'package:movies_app/actors/domain/entities/actor.dart';
import 'package:movies_app/core/data/network/api_constants.dart';
import 'package:movies_app/core/data/error/exceptions.dart';
import 'package:movies_app/core/data/network/error_message_model.dart';

abstract class ActorsRemoteDataSource {
  Future<Actor> getActorData(int actorId);
}

class ActorsRemoteDataSourceImpl implements  ActorsRemoteDataSource{
  @override
  Future<Actor> getActorData(int actorId) async{
    // TODO: implement getActorData
    final response = await Dio().get(ApiConstants.getActorDetailsPath(actorId));
    if (response.statusCode == 200) {
      return ActorModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

}