import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/exercise_model.dart';

import '../domain/models/courses_model.dart';
import '../domain/services/exercise_service.dart';

part 'select_workout_event.dart';
part 'select_workout_state.dart';

class SelectWorkoutBloc extends Bloc<SelectWorkoutEvent, SelectWorkoutState> {
  SelectWorkoutBloc() : super(SelectWorkoutInitial()) {
    on<SelectWorkoutInitialEvent>(selectWorkoutInitialEvent);
    on<SelectWorkoutClickCourseTypeEvent>(selectWorkoutClickCourseTypeEvent);
    on<SelectCourseInitialEvent>(selectCourseInitialEvent);
    on<SelectCourseClickCourseEvent>(selectCourseClickCourseEvent);
    // on<SelectWorkoutClickFullBodyEvent>(selectClickFullBodyEvent);
  }

//SelectWorkout
  FutureOr<void> selectWorkoutInitialEvent(
      SelectWorkoutInitialEvent event, Emitter<SelectWorkoutState> emit) async {
    emit(SelectWorkoutLoadingState());
    try {
      final courseStream = await ExerciseService().getCourseList().first;
      List<CoursesModel> courses = [];

      // courseStream.listen((List<CoursesModel> snapshot) {
      //   courses = snapshot;
      // });
      await Future.delayed(const Duration(seconds: 1));

      // Access the first course in the list (you can iterate through the list as needed)
      emit(SelectWorkoutLoadedSuccessState(courses: courseStream));

      // Add more logic or state transitions as needed based on the results.
    } catch (error) {
      print(error);
      // Handle any errors that might occur during the process.
    }
  }

  FutureOr<void> selectWorkoutClickCourseTypeEvent(
      SelectWorkoutClickCourseTypeEvent event,
      Emitter<SelectWorkoutState> emit) {
    List<CoursesModel> courses = [];
    event.courses[event.courseType.name]!.forEach((element) {
      courses.add(element);
    });
    emit(SelectWorkoutNavigateToCoursePageState(
        courses: courses, courseTypeName: event.courseType.name));
  }

  //Course

  FutureOr<void> selectCourseInitialEvent(
      SelectCourseInitialEvent event, Emitter<SelectWorkoutState> emit) async {
    emit(SelectCourseLoadingState());
    emit(SelectCourseLoadedState(
        courses: event.courses, courseTypeName: event.courseTypeName));
  }

  // FutureOr<void> selectClickFullBodyEvent(SelectWorkoutClickFullBodyEvent event,
  //     Emitter<SelectWorkoutState> emit) async {
  //   List<ExerciseModel> exerciseList = [];
  //   var exerciseStream = await ExerciseService()
  //       .getExerciseListByUserLevelAndPriority(event.userLevel, 0);
  // }

  FutureOr<void> selectCourseClickCourseEvent(
      SelectCourseClickCourseEvent event,
      Emitter<SelectWorkoutState> emit) async {
    final List<ExerciseModel> exerciseList = await ExerciseService()
        .getExerciseByDocIdList(event.course.exerciseDocId)
        .first;
    for (var i in exerciseList) {
      print(i.name);
    }
    emit(SelectCourseNavigateToCreatePageState(
        course: event.course, exerciseList: exerciseList));
  }
}


// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';

// import '../data/exercise_data.dart';
// import '../data/list_of_part.dart';
// import '../data/list_of_workout.dart';
// import '../domain/models/courses_model.dart';
// import '../domain/models/exercise_model.dart';
// import '../domain/models/sub_courses_model.dart';

// part 'select_workout_event.dart';
// part 'select_workout_state.dart';

// class SelectWorkoutBloc extends Bloc<SelectWorkoutEvent, SelectWorkoutState> {
//   SelectWorkoutBloc() : super(SelectWorkoutInitial()) {
//     on<SelectWorkoutInitialEvent>(selectWorkoutInitialEvent);
//     on<SelectSpecificInitialEvent>(selectSpecificInitialEvent);
//     on<SelectWorkoutClickWorkoutEvent>(selectWorkoutClickWorkoutEvent);
//     on<SelectSpecificClickPartEvent>(selectSpecificClickPartEvent);
//     on<DetailExerciseInitialEvent>(selectDetailExerciseInitialEvent);
//   }

//   FutureOr<void> selectWorkoutInitialEvent(
//       SelectWorkoutInitialEvent event, Emitter<SelectWorkoutState> emit) async {
//     emit(SelectWorkoutLoadingState());
//     //await Future.delayed(Duration(seconds: 1));

//     List<CoursesModel> workoutList = [];
//     int i = 0;
//     for (CoursesModel workout in listWorkout) {
//       workoutList.add(workout);
//       if (!workout.haveSubCourse) {
//         List<ExerciseModel> temp = workout.getRandomExercises(exerciseList, 2);
//         workoutList[i].setExerciseList(temp);
//       } else {
//         // Set PartBodyList here

//         workoutList[i].setPartBodyList(all_part);
//         print(workoutList[i].subCouresList!.length);
//         int y = 0;
//         for (SubCoursesModel partBody in workoutList[i].subCouresList!) {
//           List<ExerciseModel> temp =
//               partBody.getRandomExercises(exerciseList, 2);
//           workoutList[i].subCouresList![y].setExerciseList(temp);
//           y++;
//         }
//       }
//       i++;
//     }
//     emit(SelectWorkoutLoadedSuccessState(workoutList: workoutList));
//   }

//   FutureOr<void> selectSpecificInitialEvent(SelectSpecificInitialEvent event,
//       Emitter<SelectWorkoutState> emit) async {
//     //emit(SelectSpecificLoadingState());
//     //await Future.delayed(Duration(seconds: 1));
//     emit(SelectSpecificLoadedSuccessState(partList: event.partList));
//   }

//   FutureOr<void> selectWorkoutClickWorkoutEvent(
//       SelectWorkoutClickWorkoutEvent event,
//       Emitter<SelectWorkoutState> emit) async {
//     if (event.workout.haveSubCourse) {
//       emit(SelectWorkoutNavigateToSelectSpecificPageState(
//           partBodyList: event.workout.subCouresList!));
//     } else {
//       emit(SelectWorkoutNavigateToDetailExercisePageState());
//     }
//     //await Future.delayed(Duration(seconds: 10));
//   }

//   FutureOr<void> selectSpecificClickPartEvent(
//       SelectSpecificClickPartEvent event, Emitter<SelectWorkoutState> emit) {
//     emit(SelectSpecificNavigateToDetailWorkoutPageState(
//         exerciseList: event.part.exerciseList!));
//   }

//   FutureOr<void> selectDetailExerciseInitialEvent(
//       DetailExerciseInitialEvent event, Emitter<SelectWorkoutState> emit) {
//     emit(DetailExerciseLoadedSuccessState(exerciseList: event.exerciseList));
//   }
// }
