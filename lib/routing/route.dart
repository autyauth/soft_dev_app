import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/features/home/screens/page/home_page.dart';
import 'package:soft_dev_app/features/workout/screens/page/select_excercise_page.dart';
import 'package:soft_dev_app/features/workout/screens/page/workout_home_page.dart';
import 'package:soft_dev_app/routing/route_constants.dart';

class RouteConfig {
  GoRouter router = GoRouter(
    initialLocation: '/workout/select-exercise', // Set the initial location
    routes: [
      GoRoute(
        name: RouteConstants.home,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
          name: RouteConstants.workout,
          path: '/workout',
          builder: (BuildContext context, GoRouterState state) {
            return const WorkOutHomePage();
          },
          routes: <RouteBase>[
            GoRoute(
              name: RouteConstants.selectExercise,
              path: 'select-exercise',
              builder: (BuildContext context, GoRouterState state) =>
                  const SelectExercisePage(),
            )
          ]),
    ],
  );
}
