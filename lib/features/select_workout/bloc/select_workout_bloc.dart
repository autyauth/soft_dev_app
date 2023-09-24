import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/exercise_data.dart';
import '../data/list_of_part.dart';
import '../data/list_of_workout.dart';
import '../domain/models/exercise_model.dart';
import '../domain/models/part_body_model.dart';
import '../domain/models/workout_list_model.dart';

part 'select_workout_event.dart';
part 'select_workout_state.dart';

class SelectWorkoutBloc extends Bloc<SelectWorkoutEvent, SelectWorkoutState> {
  SelectWorkoutBloc() : super(SelectWorkoutInitial()) {
    on<SelectWorkoutInitialEvent>(selectWorkoutInitialEvent);
  }

  FutureOr<void> selectWorkoutInitialEvent(
      SelectWorkoutInitialEvent event, Emitter<SelectWorkoutState> emit) async {
    emit(SelectWorkoutLoadingState());
    await Future.delayed(Duration(seconds: 1));

    List<WorkoutListModel> workoutList = [];
    int i = 0;
    for (WorkoutListModel workout in listWorkout) {
      workoutList.add(workout);
      if (!workout.havePart) {
        List<ExerciseModel> temp = workout.getRandomExercises(exerciseList, 2);
        workoutList[i].setExerciseList(temp);
      } else {
        // Set PartBodyList here
        workoutList[i].setPartBodyList(all_part);

        int y = 0;
        for (PartBodyModel partBody in workoutList[i].partBodyList!) {
          List<ExerciseModel> temp =
              partBody.getRandomExercises(exerciseList, 2);
          workoutList[i].partBodyList![y].setExerciseList(temp);
          y++;
        }
      }
      i++;
    }
    emit(SelectWorkoutLoadedSuccessState(workoutList: workoutList));
  }
}
