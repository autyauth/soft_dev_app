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
  final List<CoursesModel> workoutList;
  SelectWorkoutLoadedSuccessState({required this.workoutList});
}

class SelectWorkoutLoadedFailureState extends SelectWorkoutState {}

class SelectWorkoutNavigateToDetailExercisePageState
    extends SelectWorkoutActionState {}

class SelectWorkoutNavigateToSelectSpecificPageState
    extends SelectWorkoutActionState {
  final List<SubCoursesModel> partBodyList;
  SelectWorkoutNavigateToSelectSpecificPageState({required this.partBodyList});
}

//selectworkout

//SelectSpecific
class SelectSpecificInitial extends SelectWorkoutState {}

class SelectSpecificLoadingState extends SelectWorkoutState {}

class SelectSpecificLoadedSuccessState extends SelectWorkoutActionState {
  final List<SubCoursesModel> partList;
  SelectSpecificLoadedSuccessState({required this.partList});
}

class SelectSpecificNavigateToDetailWorkoutPageState
    extends SelectWorkoutActionState {
  final List<ExerciseModel> exerciseList;
  SelectSpecificNavigateToDetailWorkoutPageState({required this.exerciseList});
}
//Detail

class DetailExerciseInitial extends SelectWorkoutState {}

class DetailExerciseLoadingState extends SelectWorkoutState {}

class DetailExerciseLoadedSuccessState extends SelectWorkoutActionState {
  final List<ExerciseModel> exerciseList;
  DetailExerciseLoadedSuccessState({required this.exerciseList});
}
