part of 'select_workout_bloc.dart';

@immutable
abstract class SelectWorkoutEvent {}

//Type
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

class SelectWorkoutClickCustomEvent extends SelectWorkoutEvent {}

//Course
class SelectCourseInitialEvent extends SelectWorkoutEvent {
  final List<CoursesModel> courses;
  final String courseTypeName;
  SelectCourseInitialEvent(
      {required this.courses, required this.courseTypeName});
}

class SelectCourseClickCourseEvent extends SelectWorkoutEvent {
  final CoursesModel course;
  SelectCourseClickCourseEvent({required this.course});
}

//CreatePage

class CreatePageInitialEvent extends SelectWorkoutEvent {
  final CoursesModel course;
  final List<ExerciseModel> exerciseList;

  CreatePageInitialEvent({
    required this.course,
    required this.exerciseList,
  });
}

class CreatePageClickCreateEvent extends SelectWorkoutEvent {
  final CoursesModel course;
  final List<ExerciseModel> exerciseList;
  final String username;
  CreatePageClickCreateEvent(
      {required this.course,
      required this.exerciseList,
      required this.username});
}
