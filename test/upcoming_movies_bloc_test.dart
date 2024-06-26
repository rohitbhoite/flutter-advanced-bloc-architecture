import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/core/data/error/failure.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/repository/movies_repository.dart';
import 'package:movies_app/movies/domain/usecases/get_all_upcoming_movies_usecase.dart';

import 'package:movies_app/movies/presentation/controllers/upcoming_movies_bloc/upcoming_movies_bloc.dart';

class MockUpcomingMoviesUseCase extends Mock
    implements GetAllUpcomingMoviesUseCase {}

class MockMoviesRepository extends Mock implements MoviesRespository {}

void main() {
  group('Upcoming movies bloc', () {
    late UpcomingMoviesBloc upcomingMoviesBloc;
    late GetAllUpcomingMoviesUseCase getAllUpcomingMoviesUseCase;
    List<Media> movies = [
      const Media(
          tmdbID: 1,
          title: 'title',
          posterUrl: 'posterUrl',
          backdropUrl: 'backdropUrl',
          voteAverage: 0.0,
          releaseDate: 'releaseDate',
          overview: 'overview',
          isMovie: true)
    ];
    setUp(() {
      getAllUpcomingMoviesUseCase = MockUpcomingMoviesUseCase();
      upcomingMoviesBloc = UpcomingMoviesBloc(getAllUpcomingMoviesUseCase);
    });

    test('inital state is correct',
        () => {expect(upcomingMoviesBloc.state, const UpcomingMoviesState())});

    // test('loaded state is correct', () => {
    //   upcomingMoviesBloc..add(GetUpcomingMoviesEvent)
    //   expect(upcomingMoviesBloc.state.movies,movies)
    // });
    blocTest<UpcomingMoviesBloc, UpcomingMoviesState>('test',
        setUp: () {
          when(() => getAllUpcomingMoviesUseCase(1))
              .thenAnswer((_) async => Right(movies));
        },
        build: () => upcomingMoviesBloc,
        act: (bloc) => bloc.add(GetUpcomingMoviesEvent()),
        verify: (_) {
          verify(() => getAllUpcomingMoviesUseCase(1)).called(1);
        },
        expect: () => {
              UpcomingMoviesState(
                  movies: movies, status: GetAllRequestStatus.loaded)
            });

    blocTest<UpcomingMoviesBloc, UpcomingMoviesState>('test failure',
        setUp: () {
          when(() => getAllUpcomingMoviesUseCase(1))
              .thenAnswer((_) async => const Left(ServerFailure('123')));
        },
        build: () => upcomingMoviesBloc,
        act: (bloc) => bloc.add(GetUpcomingMoviesEvent()),
        verify: (_) {
          verify(() => getAllUpcomingMoviesUseCase(1)).called(1);
        },
        expect: () => {
              const UpcomingMoviesState(
                  movies: [], status: GetAllRequestStatus.error)
            });
  });
}
