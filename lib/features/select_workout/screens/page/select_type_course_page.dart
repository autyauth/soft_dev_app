import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/features/select_workout/bloc/select_workout_bloc.dart';

//import 'package:soft_dev_app/features/select_workout/domain/models/part_body_model.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../routing/route_constants.dart';
import '../../domain/models/courses_model.dart';
import '../widget/select_exercise_widget.dart';

class SelectTypeCourse extends StatefulWidget {
  const SelectTypeCourse({super.key});

  @override
  State<SelectTypeCourse> createState() => _SelectTypeCourseState();
}

class _SelectTypeCourseState extends State<SelectTypeCourse> {
  //final SelectWorkoutBloc selectWorkoutBloc = SelectWorkoutBloc();
  // List<CoursesModel> workoutList = [];
  List<CourseType> courseType = [];
  late SelectWorkoutBloc selectWorkoutBloc;

  @override
  void initState() {
    super.initState();
    selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
    selectWorkoutBloc.add(SelectWorkoutInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      bloc: selectWorkoutBloc,
      listenWhen: (previous, current) {
        if (current is SelectWorkoutActionState) {
          return true;
        } else if (current is SelectCoursesState) {
          return true;
        } else if (current is SelectCoursesActionState) {
          return true;
        } else {
          return false;
        }
      },
      // buildWhen: (previous, current) => current is! SelectWorkoutActionState,
      buildWhen: (previous, current) {
        if (current is SelectCoursesState) {
          return false;
        } else if (current is SelectCoursesActionState) {
          return false;
        } else if (current is! SelectWorkoutActionState) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state is SelectWorkoutNavigateToCoursePageState) {
          selectWorkoutBloc.add(SelectCourseInitialEvent(
              courses: state.courses, courseTypeName: state.courseTypeName));
          context.pushNamed(RouteConstants.coursesRoute);
        }
      },
      builder: (context, state) {
        print(state);
        switch (state.runtimeType) {
          case SelectWorkoutLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SelectWorkoutLoadedSuccessState:
            final successState = state as SelectWorkoutLoadedSuccessState;
            Map<String, List<CoursesModel>> coursesMap = {};
            for (var course in successState.courses) {
              if (coursesMap.containsKey(course.type[0].name)) {
                coursesMap[course.type[0].name]!.add(course);
              } else {
                coursesMap[course.type[0].name] = [course];
              }
            }
            courseType = coursesMap.entries
                .map((e) => CourseType(
                      name: e.key,
                      image: e.value[0].type[0].image,
                    ))
                .toList();

            print(successState.courses.length);
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Select Your Exercise',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.whiteColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Palette.greyColor,
              ),
              backgroundColor: Palette.backgroundColor,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          SelectExerciseWidget<CourseType>(
                              onTap: () {},
                              model: CourseType(
                                name: 'Full Body',
                                image:
                                    'https://firebasestorage.googleapis.com/v0/b/soft-dev-project-23172.appspot.com/o/exerciseImage%2Ftemp_exercise.jpg?alt=media&token=a20da1ad-7f66-4c8f-ac51-d73fde23830a&_gl=1*q1fi86*_ga*MjAxNzM0OTc5NS4xNjk2NDk0ODA3*_ga_CW55HF8NVT*MTY5NzA1MTc4NS4xNC4xLjE2OTcwNTIyNTQuNTEuMC4w',
                              )),
                          Column(
                            children: List.generate(
                              // courseType.length,
                              courseType.length,
                              (index) {
                                final type = courseType[index];
                                return Column(
                                  children: [
                                    SelectExerciseWidget<CourseType>(
                                      onTap: () {
                                        selectWorkoutBloc.add(
                                            SelectWorkoutClickCourseTypeEvent(
                                                courseType: type,
                                                courses: coursesMap));
                                      },
                                      model: type,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SelectExerciseWidget<CourseType>(
                              onTap: () {},
                              model: CourseType(
                                name: 'Custom',
                                image:
                                    'https://firebasestorage.googleapis.com/v0/b/soft-dev-project-23172.appspot.com/o/exerciseImage%2Ftemp_exercise.jpg?alt=media&token=a20da1ad-7f66-4c8f-ac51-d73fde23830a&_gl=1*q1fi86*_ga*MjAxNzM0OTc5NS4xNjk2NDk0ODA3*_ga_CW55HF8NVT*MTY5NzA1MTc4NS4xNC4xLjE2OTcwNTIyNTQuNTEuMC4w',
                              )),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case SelectWorkoutLoadedFailureState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
        }
      },
    );
  }
}
