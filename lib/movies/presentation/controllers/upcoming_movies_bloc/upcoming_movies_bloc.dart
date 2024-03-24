import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/domain/usecases/get_all_upcoming_movies_usecase.dart';

part 'upcoming_movies_state.dart';

part 'upcoming_movies_event.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final GetAllUpcomingMoviesUseCase _getAllUpcomingMoviesUseCase;
  int page = 1;
  UpcomingMoviesBloc(this._getAllUpcomingMoviesUseCase)
      : super(const UpcomingMoviesState()) {


    on<GetUpcomingMoviesEvent>(_getAllUpcomingMovies);

    on<FetchMoreUpcomingMoviesEvent>(_fetchMoreMovies);
  }

  Future<void> _getAllUpcomingMovies(
      UpcomingMoviesEvent event, Emitter<UpcomingMoviesState> emit) async {
    if (state.status == GetAllRequestStatus.loading) {
      await _getMovies(emit);
    } else if (state.status == GetAllRequestStatus.loaded) {
      await _getMovies(emit);
    } else if (state.status == GetAllRequestStatus.error) {
      emit(
        state.copyWith(
          status: GetAllRequestStatus.loading,
        ),
      );
      await _getMovies(emit);
    }
  }

  Future<void> _getMovies(Emitter<UpcomingMoviesState> emit) async {
    final result = await _getAllUpcomingMoviesUseCase(page);
    result.fold(
          (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.error,
        ),
      ),
          (r) {
        page++;
        emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            movies: state.movies + r,
          ),
        );
      },
    );
  }

  Future<void> _fetchMoreMovies(FetchMoreUpcomingMoviesEvent event,
      Emitter<UpcomingMoviesState> emit) async {
    final result = await _getAllUpcomingMoviesUseCase(page);
    result.fold(
          (l) => emit(
        state.copyWith(
          status: GetAllRequestStatus.fetchMoreError,
        ),
      ),
          (r) {
        page++;
        return emit(
          state.copyWith(
            status: GetAllRequestStatus.loaded,
            movies: state.movies + r,
          ),
        );
      },
    );
  }
}
