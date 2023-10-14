part of 'select_workout_bloc.dart';

@immutable
abstract class SelectWorkoutEvent {}

//SelectWorkout
class SelectWorkoutInitialEvent extends SelectWorkoutEvent {}

class SelectWorkoutClickCourseTypeEvent extends SelectWorkoutEvent {
  final CourseType courseType;
  final Map<String, List<CoursesModel>> courses;
  SelectWorkoutClickCourseTypeEvent(
      {required this.courseType, required this.courses});
}

class SelectWorkoutClickFullBodyEvent extends SelectWorkoutEvent {
  final int userLevel;
  SelectWorkoutClickFullBodyEvent({required this.userLevel});
}

class SelectWorkoutClickCustomEvent extends SelectWorkoutEvent {
  final int userLevel;
  SelectWorkoutClickCustomEvent({required this.userLevel});
}

//Course
class SelectCourseInitialEvent extends SelectWorkoutEvent {
  final List<CoursesModel> courses;
  final String courseTypeName;
  SelectCourseInitialEvent(
      {required this.courses, required this.courseTypeName});
}

class SelectCourseClickCourseEvent extends SelectWorkoutEvent {
  CoursesModel course;
  SelectCourseClickCourseEvent({required this.course});
}

//CreatePage

class CreatePageInitialEvent extends SelectWorkoutEvent {
  final CoursesModel course;
  final List<ExerciseModel> exerciseList;
  CreatePageInitialEvent({required this.course, required this.exerciseList});
}

// part of 'select_workout_bloc.dart';

// @immutable
// abstract class SelectWorkoutEvent {}

// //SelectWorkout
// class SelectWorkoutInitialEvent extends SelectWorkoutEvent {}

// class SelectWorkoutClickWorkoutEvent extends SelectWorkoutEvent {
//   final CoursesModel workout;
//   SelectWorkoutClickWorkoutEvent({required this.workout});
// }

// //SelectSpecific
// class SelectSpecificInitialEvent extends SelectWorkoutEvent {
//   final List<SubCoursesModel> partList;
//   SelectSpecificInitialEvent({required this.partList});
// }

// class SelectSpecificClickPartEvent extends SelectWorkoutEvent {
//   final SubCoursesModel part;
//   SelectSpecificClickPartEvent({required this.part});
// }

// //Detail
// class DetailExerciseInitialEvent extends SelectWorkoutEvent {
//   final List<ExerciseModel> exerciseList;
//   DetailExerciseInitialEvent({required this.exerciseList});
// }
