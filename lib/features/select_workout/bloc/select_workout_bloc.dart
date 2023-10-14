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
    // on<SelectWorkoutClickFullBodyEvent>(selectWorkoutClickFullBodyEvent);
    on<SelectWorkoutClickCustomEvent>(selectWorkoutClickCustomEvent);
    on<SelectWorkoutClickCourseTypeEvent>(selectWorkoutClickCourseTypeEvent);
    on<SelectCourseInitialEvent>(selectCourseInitialEvent);
    on<SelectCourseClickCourseEvent>(selectCourseClickCourseEvent);
    on<CreatePageInitialEvent>(createPageInitialEvent);
    // on<SelectWorkoutClickFullBodyEvent>(selectClickFullBodyEvent);
  }

//SelectWorkout
  FutureOr<void> selectWorkoutInitialEvent(
      SelectWorkoutInitialEvent event, Emitter<SelectWorkoutState> emit) async {
    emit(SelectWorkoutLoadingState());
    try {
      final courseStream = await ExerciseService().getCourseList().first;

      // courseStream.listen((List<CoursesModel> snapshot) {
      //   courses = snapshot;
      // });

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

  FutureOr<void> selectWorkoutClickCustomEvent(
      SelectWorkoutClickCustomEvent event,
      Emitter<SelectWorkoutState> emit) async {
    final courses = await ExerciseService().getCourseCustom().first;

    emit(SelectWorkoutNavigateToCoursePageState(
        courses: courses, courseTypeName: "Custom"));
  }
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

FutureOr<void> selectCourseClickCourseEvent(SelectCourseClickCourseEvent event,
    Emitter<SelectWorkoutState> emit) async {
  if (event.course.type[0].name == "Custom") {
    print('okey');
    List<ExerciseModel> exerciseWarmUp = await ExerciseService()
        .getExerciseListByUserLevelAndPriorityAndPartFocus(0, event.course.name)
        .first;
    List<ExerciseModel> exerciseDo = await ExerciseService()
        .getExerciseListByUserLevelAndPriorityAndPartFocus(1, event.course.name)
        .first;
    List<ExerciseModel> exerciseCoolDown = await ExerciseService()
        .getExerciseListByUserLevelAndPriorityAndPartFocus(2, event.course.name)
        .first;
    List<ExerciseModel> warmUpTemp = List.from(exerciseWarmUp);
    warmUpTemp.shuffle();
    warmUpTemp = warmUpTemp.take(2).toList();

    List<ExerciseModel> doTemp = List.from(exerciseDo);
    doTemp.shuffle();
    doTemp = doTemp.take(5).toList();

    List<ExerciseModel> coolDownTemp = List.from(exerciseCoolDown);
    coolDownTemp.shuffle();
    coolDownTemp = coolDownTemp.take(2).toList();

    List<ExerciseModel> newExercise = [];
    newExercise.addAll(warmUpTemp);
    newExercise.addAll(doTemp);
    newExercise.addAll(coolDownTemp);

    emit(SelectCourseNavigateToCreatePageState(
        course: event.course, exerciseList: newExercise));
  } else {
    final List<ExerciseModel> exerciseList = await ExerciseService()
        .getExerciseByDocIdList(event.course.exerciseDocId)
        .first;
    print("Loaded");
    print(event.course.exerciseDocId[0]);
    print(event.course.exerciseDocId[1]);
    for (var i in exerciseList) {
      print(i.name);
    }
    emit(SelectCourseNavigateToCreatePageState(
        course: event.course, exerciseList: exerciseList));
  }
}

FutureOr<void> createPageInitialEvent(
    CreatePageInitialEvent event, Emitter<SelectWorkoutState> emit) async {
  emit(CreatePageLoading());
  List<ExerciseModel> exerciseList = event.exerciseList;
  int i = 0;
  for (var exercise in exerciseList) {
    final exerciseMedia = await ExerciseService()
        .getExerciseMediaByDocIdList(exercise.mediaDocId)
        .first;
    exerciseList[i].setMedia(exerciseMedia);
    i++;
  }
  emit(CreatePageInitial(
      course: event.course, exerciseList: event.exerciseList));
}
