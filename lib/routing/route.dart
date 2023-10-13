import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/home/screens/page/home_page.dart';
import '../features/select_workout/screens/page/select_courses_page.dart';
import '../features/select_workout/screens/page/select_type_course_page.dart';
import '../features/select_workout/screens/page/workout_home_page.dart';
import 'route_constants.dart';

class RouteConfig {
  GoRouter router = GoRouter(
    initialLocation: '/workout/course-type', // Set the initial location
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
              name: RouteConstants.courseTypeRoute,
              path: 'course-type',
              builder: (BuildContext context, GoRouterState state) =>
                  const SelectTypeCourse(),
              routes: <RouteBase>[
                GoRoute(
                  name: RouteConstants.coursesRoute,
                  path: 'course-page',
                  builder: (BuildContext context, GoRouterState state) =>
                      const SelectCoursesPage(),
                ),
              ],
            )
          ]),
    ],
  );
}
