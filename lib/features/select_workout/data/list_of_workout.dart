import '../domain/models/workout_list_model.dart';

List<WorkoutListModel> listWorkout = [
  WorkoutListModel.withExerciseList(
    title: 'Full Body',
    image: 'assets/images/temp_exercise.jpg',
    description: 'description',
    havePart: false,
    partList: [],
    exerciseList: [],
  ),
  WorkoutListModel(
    title: 'Specific',
    image: 'assets/images/temp_exercise.jpg',
    description: 'description',
    havePart: true,
    partList: ['Arm', 'Shoulder', 'Leg', 'Chest'],
  ),
];
