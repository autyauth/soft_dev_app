import 'dart:math';

import 'package:soft_dev_app/features/workout/domain/models/exercise_model.dart';

class PartBodyModel {
  PartBodyModel({
    required this.title,
    required this.image,
    required this.description,
    //required this.workout,
    //this.exerciseList,
  }) : exerciseList = [];
  PartBodyModel.withWorkout(
      {required this.title,
      required this.image,
      required this.description,
      this.workout})
      : exerciseList = [];

  final String title;
  final String image;
  final String description;
  String? workout;
  List<ExerciseModel>? exerciseList;

  void setExerciseList(List<ExerciseModel> exerciseList) {
    for (ExerciseModel exercise in exerciseList) {
      if (exercise.part == this.title) {
        this.exerciseList?.add(exercise);
      }
    }
  }

  List<ExerciseModel> getRandomExercises(
      List<ExerciseModel> exercises, int countPerPart) {
    final Random random = Random();
    final shuffledExercises = List.of(exercises)..shuffle(random);
    final Map<String, int> partCounts = {};

    // สร้างรายการว่างๆ สำหรับแต่ละ "part"
    final Map<String, List<ExerciseModel>> selectedExercisesPerPart = {};

    // วนลูปผ่านรายการออกกำลังกายเพื่อแยกตาม "part"
    for (final exercise in shuffledExercises) {
      final part = exercise.part;

      if (!partCounts.containsKey(part)) {
        partCounts[part] = 0;
        selectedExercisesPerPart[part] = [];
      }

      // เพิ่มออกกำลังกายลงใน "part" ที่ถูกเลือก
      if (partCounts[part]! < countPerPart && exercise.part == this.title) {
        selectedExercisesPerPart[part]?.add(exercise);
        partCounts[part] = partCounts[part]! + 1;
      }
    }

    // รวมรายการออกกำลังกายที่เลือกไว้ทั้งหมด
    final List<ExerciseModel> selectedExercises = [];
    selectedExercisesPerPart.values.forEach((exercises) {
      selectedExercises.addAll(exercises);
    });

    return selectedExercises;
  }
}
