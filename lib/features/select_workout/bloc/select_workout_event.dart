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

class SelectSpecificClickPartEvent extends SelectWorkoutEvent {
  final PartBodyModel part;
  SelectSpecificClickPartEvent({required this.part});
}

//Detail
class DetailExerciseInitialEvent extends SelectWorkoutEvent {
  final List<ExerciseModel> exerciseList;
  DetailExerciseInitialEvent({required this.exerciseList});
}
