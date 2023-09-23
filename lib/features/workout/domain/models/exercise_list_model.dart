import 'package:soft_dev_app/features/workout/domain/models/exercise_model.dart';

class ExerciseListModel {
  ExerciseListModel(
      {required this.title,
      required this.image,
      required this.exerciseList,
      required this.dateList});
  String title;
  String image;
  List<ExerciseModel> exerciseList;
  List<DateTime> dateList;

  String get getTitle => title;
}
