import 'package:equatable/equatable.dart';
import 'package:movies_app/actors/domain/entities/actor.dart';
import 'package:movies_app/actors/domain/usecases/get_actor_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_app/core/utils/enums.dart';

part 'actor_details_event.dart';

part 'actor_details_state.dart';

class ActorDetailsBloc extends Bloc<ActorDetailsEvent, ActorDetailsState> {
  final GetActorDetailsUseCase _getActorDetailsUseCase;

  ActorDetailsBloc(this._getActorDetailsUseCase)
      : super(const ActorDetailsState()) {
    on<GetActorDetailsEvent>(_getActorDetails);
  }

  Future<void> _getActorDetails(
      GetActorDetailsEvent event, Emitter<ActorDetailsState> emit) async {
    emit(
      state.copyWith(
        status: RequestStatus.loading,
      ),
    );
    final result = await _getActorDetailsUseCase(event.actorId);
    result.fold(
      (l) => emit(
        state.copyWith(
          status: RequestStatus.error,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: RequestStatus.loaded,
          actor: r,
        ),
      ),
    );
  }
}
