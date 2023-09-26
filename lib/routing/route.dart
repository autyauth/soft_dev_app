import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/screens/page/home_page.dart';
import '../features/select_workout/domain/models/part_body_model.dart';
import '../features/select_workout/screens/page/select_exercise_page.dart';
import '../features/select_workout/screens/page/select_specific_page.dart';
import '../features/select_workout/screens/page/workout_home_page.dart';
import 'route_constants.dart';

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
              routes: <RouteBase>[
                GoRoute(
                  name: RouteConstants.specificPage,
                  path: 'select-specific',
                  builder: (BuildContext context, GoRouterState state) =>
                      SelectSpecificPage(
                          partBodyList: state.extra as List<PartBodyModel>),
                ),
              ],
            )
          ]),
    ],
  );
}
