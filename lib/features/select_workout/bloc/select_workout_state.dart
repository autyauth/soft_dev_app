part of 'select_workout_bloc.dart';

@immutable
abstract class SelectWorkoutState {}

abstract class SelectWorkoutActionState extends SelectWorkoutState {}

//SelectWorkout
class SelectWorkoutInitial extends SelectWorkoutState {}

class SelectWorkoutLoadingState extends SelectWorkoutState {}

class SelectWorkoutLoadedSuccessState extends SelectWorkoutState {
  // ดึงข้อมูล database exercise , part body, workout list มาใช้งาน
  // ตอนนี้ใช้ data ไปก่อน
  final List<WorkoutListModel> workoutList;
  SelectWorkoutLoadedSuccessState({required this.workoutList});
}

class SelectWorkoutLoadedFailureState extends SelectWorkoutState {}

class SelectWorkoutNavigateToDetailExercisePageState
    extends SelectWorkoutActionState {}

class SelectWorkoutNavigateToSelectSpecificPageState
    extends SelectWorkoutActionState {
  final List<PartBodyModel> partBodyList;
  SelectWorkoutNavigateToSelectSpecificPageState({required this.partBodyList});
}

//selectworkout

//SelectSpecific
class SelectSpecificInitial extends SelectWorkoutState {}

class SelectSpecificLoadingState extends SelectWorkoutState {}

class SelectSpecificLoadedSuccessState extends SelectWorkoutState {
  final List<PartBodyModel> partList;
  SelectSpecificLoadedSuccessState({required this.partList});
}

class CreateWorkoutListState extends SelectWorkoutActionState {
  final List<WorkoutListModel> workoutList;
  CreateWorkoutListState({required this.workoutList});
}
