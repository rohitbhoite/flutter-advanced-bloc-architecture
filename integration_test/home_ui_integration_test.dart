import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/resources/app_router.dart';
import 'package:movies_app/core/resources/app_strings.dart';
import 'package:movies_app/core/resources/app_theme.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/watchlist/presentation/controllers/watchlist_bloc/watchlist_bloc.dart';

void main() {
  testWidgets('test home ui', (widgetTester) async {
    ServiceLocator.init();
    await Hive.initFlutter();
    Hive.registerAdapter(MediaAdapter());
    await Hive.openBox('items');
    await widgetTester.pumpWidget(
      BlocProvider(
          create: (context) => sl<WatchlistBloc>(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            theme: getApplicationTheme(),
            routerConfig: AppRouter().router,
          )),
    );
    await widgetTester.pumpAndSettle();
    var popularTitleFinder = find.text(AppStrings.popularMovies);
    expect(popularTitleFinder, findsOneWidget);
    // final fab = find.byKey(const ValueKey('list_item')).first;
    // await widgetTester.tap(fab);
    // await widgetTester.pumpAndSettle();
    // var storyTitleFinder = find.text(AppStrings.story);
    // expect(storyTitleFinder, findsOneWidget);
    // var similarFInder=find.byKey(ValueKey("similar_section")).last;
    // await widgetTester.scrollUntilVisible(similarFInder, 100);
    // expect(similarFInder, findsOneWidget);
    final bottomNavbar = find.text("Watchlist");
    widgetTester.tap(bottomNavbar);
    widgetTester.pumpAndSettle();
    final watchlistEmptyTextFinder = find.text('Watchlist is empty');
    expect(watchlistEmptyTextFinder, findsOneWidget);
  });
}
