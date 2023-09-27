import 'dart:math';

import 'exercise_model.dart';
import 'part_body_model.dart';

class WorkoutListModel {
  WorkoutListModel({
    required this.title,
    required this.image,
    required this.description,
    required this.havePart,
    required this.partList,
    //this.exerciseList,
  })  : exerciseList = [],
        partBodyList = [];
  WorkoutListModel.withExerciseList({
    required this.title,
    required this.image,
    required this.description,
    required this.havePart,
    required this.partList,
    this.exerciseList,
  });
  final String title;
  final String image;
  final String description;
  final bool havePart;
  final List<String> partList;
  List<ExerciseModel>? exerciseList;
  List<PartBodyModel>? partBodyList;

  void setExerciseList(List<ExerciseModel> exerciseList) {
    for (ExerciseModel exercise in exerciseList) {
      this.exerciseList!.add(exercise);
    }
  }

  void setPartBodyList(List<PartBodyModel> partBodyList) {
    if (!(this.partBodyList!.length == 0)) {
      return;
    }
    for (PartBodyModel partBody in partBodyList) {
      if (partBody.workout == this.title) {
        this.partBodyList!.add(partBody);
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
      if (partCounts[part]! < countPerPart) {
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
