import 'package:soft_dev_app/features/workout/domain/models/workout_list_model.dart';

List<WorkoutListModel> listWorkout = [
  WorkoutListModel(
    title: 'Full Body',
    image: 'assets/images/temp_exercise.jpg',
    description: 'description',
    havePart: false,
    partList: [],
  ),
  WorkoutListModel(
    title: 'Specific',
    image: 'assets/images/temp_exercise.jpg',
    description: 'description',
    havePart: true,
    partList: ['Arm', 'Shoulder', 'Leg', 'Chest'],
  ),
];
