part of 'select_workout_bloc.dart';

@immutable
abstract class SelectWorkoutEvent {}

class SelectWorkoutInitialEvent extends SelectWorkoutEvent {}

class SelectWorkoutClickDetailExerciseEvent extends SelectWorkoutEvent {}

class SelectWorkoutClickPartBodyEvent extends SelectWorkoutEvent {}

class SelectWorkoutClickCreateWorkoutListEvent extends SelectWorkoutEvent {
  final List<WorkoutListModel> workoutList;
  SelectWorkoutClickCreateWorkoutListEvent({required this.workoutList});
}
