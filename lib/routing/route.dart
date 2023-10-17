import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/app_view.dart';
import 'package:soft_dev_app/features/select_workout/screens/page/create_page.dart';
import 'package:soft_dev_app/features/select_workout/screens/page/detail_exercise.dart';

import '../features/select_workout/screens/page/home_select.dart';
import '../features/select_workout/screens/page/select_courses_page.dart';
import '../features/select_workout/screens/page/select_type_course_page.dart';
import 'route_constants.dart';

class RouteConfig {
  GoRouter router = GoRouter(
    initialLocation: '/', // Set the initial location
    routes: [
      GoRoute(
        name: RouteConstants.home,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MyAppView();
        },
      ),
      GoRoute(
          name: RouteConstants.workout,
          path: '/workout',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeSelect();
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
                    routes: <RouteBase>[
                      GoRoute(
                          name: RouteConstants.createCoursePage,
                          path: 'create-course-page',
                          builder:
                              (BuildContext context, GoRouterState state) =>
                                  const CreatePage(),
                          routes: <RouteBase>[
                            GoRoute(
                              name: RouteConstants.detailExercise,
                              path: 'exercise-detail',
                              builder:
                                  (BuildContext context, GoRouterState state) =>
                                      const DetailExercise(),
                            )
                          ]),
                    ]),
              ],
            )
          ]),
    ],
  );
}
