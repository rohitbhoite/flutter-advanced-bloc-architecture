import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/actors/presentation/controllers/actor_details_bloc.dart';

import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';

import '../../../core/presentation/components/slider_card_image.dart';
import '../../domain/entities/actor.dart';

class ActorView extends StatelessWidget {
  final int actorId;

  const ActorView({super.key, required this.actorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ActorDetailsBloc>()..add(GetActorDetailsEvent(actorId)),
      child: Scaffold(
        body: BlocBuilder<ActorDetailsBloc, ActorDetailsState>(
          builder: (context, state) {
            switch (state.status) {
              case RequestStatus.loading:
                return const CircularProgressIndicator();
              case RequestStatus.loaded:
                return ActorDetailsWidget(actor: state.actor!);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

class ActorDetailsWidget extends StatelessWidget {
  final Actor actor;

  const ActorDetailsWidget({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Stack(children: [
              SliderCardImage(imageUrl: actor.profileUrl),
              Text(
                actor.name,
                style: textTheme.titleMedium,
              )
            ],),
          )
        ],
      ),
    );
  }
}
