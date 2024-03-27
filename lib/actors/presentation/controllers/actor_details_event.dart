part of 'actor_details_bloc.dart';

abstract class ActorDetailsEvent extends Equatable {
  const ActorDetailsEvent();
}

class GetActorDetailsEvent extends ActorDetailsEvent {
  final int actorId;

  const GetActorDetailsEvent(this.actorId);
  @override
  List<Object?> get props => [actorId];
}
