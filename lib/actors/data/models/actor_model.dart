import 'package:movies_app/actors/domain/entities/actor.dart';
import 'package:movies_app/core/utils/functions.dart';

class ActorModel extends Actor {
  const ActorModel({required super.name, required super.profileUrl});

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(name: json['name'], profileUrl: getProfileImageUrl(json));
  }
}
