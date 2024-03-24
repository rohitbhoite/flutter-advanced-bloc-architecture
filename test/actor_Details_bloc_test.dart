import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/actors/domain/entities/actor.dart';
import 'package:movies_app/actors/domain/repository/actors_repository.dart';
import 'package:movies_app/actors/domain/usecases/get_actor_details_usecase.dart';
import 'package:movies_app/actors/presentation/controllers/actor_details_bloc.dart';
import 'package:movies_app/core/data/error/failure.dart';
import 'package:movies_app/core/utils/enums.dart';

class MockActorDetailsUseCase extends Mock implements GetActorDetailsUseCase {}

class MockActorsRepository extends Mock implements ActorsRepository {}

void main() {
  group('Upcoming movies bloc', () {
    late ActorDetailsBloc actorDetailsBloc;
    late GetActorDetailsUseCase _getActorDetailsUseCase;
    late ActorsRepository _actorsRepository;
    setUp(() {
      _getActorDetailsUseCase = MockActorDetailsUseCase();
      actorDetailsBloc = ActorDetailsBloc(_getActorDetailsUseCase);
      _actorsRepository = MockActorsRepository();
    });
    Actor actor = Actor(name: "name", profileUrl: "profileUrl");

    test('inital state is correct',
        () => {expect(actorDetailsBloc.state, ActorDetailsState())});

    // test('loaded state is correct', () => {
    //   upcomingMoviesBloc..add(GetUpcomingMoviesEvent)
    //   expect(upcomingMoviesBloc.state.movies,movies)
    // });
    blocTest<ActorDetailsBloc, ActorDetailsState>('test success',
        setUp: () {
          when(() => _getActorDetailsUseCase(1))
              .thenAnswer((_) async => Right(actor));
        },
        build: () => actorDetailsBloc,
        act: (bloc) => bloc.add(GetActorDetailsEvent(1)),
        verify: (_) {
          verify(() => _getActorDetailsUseCase(1)).called(1);
        },
        expect: () => {
              ActorDetailsState(actor: null, status: RequestStatus.loading),
              ActorDetailsState(actor: actor, status: RequestStatus.loaded)
            });

    blocTest<ActorDetailsBloc, ActorDetailsState>('test failure',
        setUp: () {
          when(() => _getActorDetailsUseCase(1))
              .thenAnswer((_) async => left(const ServerFailure("error")));
        },
        build: () => actorDetailsBloc,
        act: (bloc) => bloc.add(const GetActorDetailsEvent(1)),
        verify: (_) {
          verify(() => _getActorDetailsUseCase(1)).called(1);
        },
        expect: () => {
          ActorDetailsState(actor: null, status: RequestStatus.loading),
          ActorDetailsState(actor: null, status: RequestStatus.error)
        });
  });
}
