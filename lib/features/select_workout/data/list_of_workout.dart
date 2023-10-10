import '../domain/models/courses_model.dart';

List<CoursesModel> listWorkout = [
  CoursesModel.withExerciseList(
    title: 'Full Body',
    image: 'assets/images/temp_exercise.jpg',
    description: 'description',
    haveSubCourse: false,
    subCoursesNameList: [],
    exerciseList: [],
  ),
  CoursesModel(
    title: 'Specific',
    image: 'assets/images/temp_exercise.jpg',
    description: 'description',
    haveSubCourse: true,
    subCoursesNameList: ['Arm', 'Shoulder', 'Leg', 'Chest'],
  ),
];
