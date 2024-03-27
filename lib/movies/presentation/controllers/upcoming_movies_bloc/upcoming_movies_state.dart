part of 'upcoming_movies_bloc.dart';

class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState({
    this.movies = const [],
    this.status = GetAllRequestStatus.loading,
    this.message = '',
  });
  final List<Media> movies;
  final GetAllRequestStatus status;
  final String message;

  UpcomingMoviesState copyWith({
    List<Media>? movies,
    GetAllRequestStatus? status,
    String? message,
  }) {
    return UpcomingMoviesState(
      movies: movies ?? this.movies,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        movies,
        status,
        message,
      ];
}
