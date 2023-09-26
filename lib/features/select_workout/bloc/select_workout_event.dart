part of 'select_workout_bloc.dart';

@immutable
abstract class SelectWorkoutEvent {}

//SelectWorkout
class SelectWorkoutInitialEvent extends SelectWorkoutEvent {}

class SelectWorkoutClickWorkoutEvent extends SelectWorkoutEvent {
  final WorkoutListModel workout;
  SelectWorkoutClickWorkoutEvent({required this.workout});
}

//SelectSpecific
class SelectSpecificInitialEvent extends SelectWorkoutEvent {
  final List<PartBodyModel> partList;
  SelectSpecificInitialEvent({required this.partList});
}

class SelectWorkoutClickCreateWorkoutListEvent extends SelectWorkoutEvent {
  final List<WorkoutListModel> workoutList;
  SelectWorkoutClickCreateWorkoutListEvent({required this.workoutList});
}
