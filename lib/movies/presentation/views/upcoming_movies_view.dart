import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/presentation/components/custom_app_bar.dart';
import 'package:movies_app/core/presentation/components/error_screen.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';
import 'package:movies_app/movies/presentation/controllers/upcoming_movies_bloc/upcoming_movies_bloc.dart';

import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/components/vertical_listview.dart';
import 'package:movies_app/core/presentation/components/vertical_listview_card.dart';

class UpcomingMoviesView extends StatelessWidget {
  const UpcomingMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<UpcomingMoviesBloc>()..add(GetUpcomingMoviesEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.upcomingMovies,
        ),
        body: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
            builder: (context, state) {
          switch (state.status) {
            case GetAllRequestStatus.loading:
              return const LoadingIndicator();
            case GetAllRequestStatus.loaded:
              return UpcomingMoviesWidget(movies: state.movies);
            case GetAllRequestStatus.error:
              return ErrorScreen(onTryAgainPressed: () {
                context
                    .read<UpcomingMoviesBloc>()
                    .add(FetchMoreUpcomingMoviesEvent());
              });
            case GetAllRequestStatus.fetchMoreError:
              return const LoadingIndicator();
          }
        }),
      ),
    );
  }
}

class UpcomingMoviesWidget extends StatelessWidget {
  const UpcomingMoviesWidget({
    required this.movies,
    super.key,
  });

  final List<Media> movies;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
      builder: (context, state) {
        return VerticalListView(
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index < movies.length) {
              return VerticalListViewCard(media: movies[index]);
            } else {
              return const LoadingIndicator();
            }
          },
          addEvent: () {
            context
                .read<UpcomingMoviesBloc>()
                .add(FetchMoreUpcomingMoviesEvent());
          },
        );
      },
    );
  }
}
