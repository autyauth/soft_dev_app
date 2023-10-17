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
    on<CreatePageClickCreateEvent>(createPageClickCreateEvent);
    on<CreatePageClickCardDetailEvent>(createPageClickCardDetailEvent);
    on<CardDetailInitialEvent>(cardDetailInitialEvent);
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
    try {
      final courses = await ExerciseService().getCourseCustom().first;

      emit(SelectWorkoutNavigateToCoursePageState(
          courses: courses, courseTypeName: "เลือกเอง"));
    } catch (e) {
      // TODO
      print(e);
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

  FutureOr<void> selectCourseClickCourseEvent(
      SelectCourseClickCourseEvent event,
      Emitter<SelectWorkoutState> emit) async {
    try {
      if (event.course.type[0].name == "เลือกเอง") {
        print('okey');
        List<ExerciseModel> exerciseWarmUp = await ExerciseService()
            .getExerciseListByUserLevelAndPriorityAndPartFocus(
                0, event.course.name)
            .first;
        List<ExerciseModel> exerciseDo = await ExerciseService()
            .getExerciseListByUserLevelAndPriorityAndPartFocus(
                1, event.course.name)
            .first;
        List<ExerciseModel> exerciseCoolDown = await ExerciseService()
            .getExerciseListByUserLevelAndPriorityAndPartFocus(
                2, event.course.name)
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

        //final newCourse = event.course;

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
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> createPageInitialEvent(
      CreatePageInitialEvent event, Emitter<SelectWorkoutState> emit) async {
    emit(CreatePageLoading());
    try {
      List<ExerciseModel> exerciseList = event.exerciseList;
      int i = 0;
      int time = 0;
      int amout = 0;
      for (ExerciseModel exercise in exerciseList) {
        final exerciseMedia = await ExerciseService()
            .getExerciseMediaByDocIdList(exercise.mediaDocId)
            .first;
        exerciseList[i].setMedia(exerciseMedia);
        amout += exercise.amout;
        time += exercise.time;
        i++;
      }
      time += ((amout / 20.0) * 60).ceil();
      emit(CreatePageInitial(
          course: event.course, exerciseList: event.exerciseList, time: time));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> createPageClickCreateEvent(CreatePageClickCreateEvent event,
      Emitter<SelectWorkoutState> emit) async {
    print(event.course.type[0].name);
    try {
      if (event.course.type[0].name == "เลือกเอง") {
        List<String> docIdList = [];
        for (ExerciseModel exercise in event.exerciseList) {
          docIdList.add(exercise.name);
        }
        final List<String>? exerciseDocIdList =
            await ExerciseService().getExerciseDocIdByName(docIdList);
        for (var name in exerciseDocIdList!) {
          print(name);
        }
        CoursesModel course = event.course;
        course.setCourseId(exerciseDocIdList);
        String newCourseDocId = await ExerciseService().addCourse(course);
        String msg = await ExerciseService()
            .addUserCourse(newCourseDocId, event.username);
        print(msg);
      } else {
        String newCourseDocId = await ExerciseService().addCourse(event.course);
        String msg = await ExerciseService()
            .addUserCourse(newCourseDocId!, event.username);
        print(msg);
      }
      emit(CreatePageNavigateToHome());
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> createPageClickCardDetailEvent(
      CreatePageClickCardDetailEvent event, Emitter<SelectWorkoutState> emit) {
    emit(CreatePageNavigateToCardDetail(exercise: event.exercise));
  }

  FutureOr<void> cardDetailInitialEvent(
      CardDetailInitialEvent event, Emitter<SelectWorkoutState> emit) {
    emit(CardDetailInitial(exercise: event.exercise));
  }
}



// FutureOr<void> createPageClickCreateEvent(
//     CreatePageClickCreateEvent event, Emitter<SelectWorkoutState> emit) {
//   if (event.course.name == "Custom") {
//   } else {}
// }
