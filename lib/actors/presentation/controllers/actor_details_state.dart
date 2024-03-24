part of 'actor_details_bloc.dart';

class ActorDetailsState extends Equatable {
  final Actor? actor;
  final RequestStatus status;
  final String message;

  const ActorDetailsState({
    this.actor,
    this.status = RequestStatus.loading,
    this.message = '',
  });

  ActorDetailsState copyWith({
    Actor? actor,
    RequestStatus? status,
    String? message,
  }) {
    return ActorDetailsState(
      actor: actor ?? this.actor,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    actor,
    status,
    message,
  ];
}
