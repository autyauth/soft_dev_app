part of 'select_workout_bloc.dart';

@immutable
abstract class SelectWorkoutState {}

abstract class SelectWorkoutActionState extends SelectWorkoutState {}

abstract class SelectCoursesState extends SelectWorkoutState {}

abstract class SelectCoursesActionState extends SelectCoursesState {}

abstract class CreatePageState extends SelectWorkoutState {}

abstract class CreatePageActionState extends CreatePageState {}

//SelectWorkout
class SelectWorkoutInitial extends SelectWorkoutState {}

class SelectWorkoutLoadingState extends SelectWorkoutState {}

class SelectWorkoutLoadedSuccessState extends SelectWorkoutState {
  List<CoursesModel> courses;
  SelectWorkoutLoadedSuccessState({required this.courses});
}

class SelectWorkoutLoadedFailureState extends SelectWorkoutState {}

class SelectWorkoutNavigateToCoursePageState extends SelectWorkoutActionState {
  final List<CoursesModel> courses;
  final String courseTypeName;
  SelectWorkoutNavigateToCoursePageState(
      {required this.courses, required this.courseTypeName});
}

//Course
class SelectCourseInitial extends SelectCoursesState {
  final List<CoursesModel> courses;
  final String courseTypeName;
  SelectCourseInitial({required this.courses, required this.courseTypeName});
}

class SelectCourseLoadingState extends SelectCoursesState {}

class SelectCourseLoadedState extends SelectCoursesState {
  final List<CoursesModel> courses;
  final String courseTypeName;
  SelectCourseLoadedState(
      {required this.courses, required this.courseTypeName});
}

class SelectCourseNavigateToCreatePageState extends SelectCoursesActionState {
  final CoursesModel course;
  final List<ExerciseModel> exerciseList;
  SelectCourseNavigateToCreatePageState(
      {required this.course, required this.exerciseList});
}

//createPage
class CreatePageLoading extends CreatePageState {}

class CreatePageInitial extends CreatePageState {
  final CoursesModel course;
  final List<ExerciseModel> exerciseList;
  CreatePageInitial({required this.course, required this.exerciseList});
}
