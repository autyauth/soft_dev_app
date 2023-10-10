import 'dart:math';

import 'exercise_model.dart';
import 'sub_courses_model.dart';

class CoursesModel {
  CoursesModel({
    required this.title,
    required this.image,
    required this.description,
    required this.haveSubCourse,
    required this.subCoursesNameList,
    //this.exerciseList,
  })  : exerciseList = [],
        subCouresList = [];
  CoursesModel.withExerciseList({
    required this.title,
    required this.image,
    required this.description,
    required this.haveSubCourse,
    required this.subCoursesNameList,
    this.exerciseList,
  });
  final String title;
  final String image;
  final String description;
  final bool haveSubCourse;
  final List<String> subCoursesNameList;
  List<ExerciseModel>? exerciseList;
  List<SubCoursesModel>? subCouresList;

  void setExerciseList(List<ExerciseModel> exerciseList) {
    for (ExerciseModel exercise in exerciseList) {
      this.exerciseList!.add(exercise);
    }
  }

  void setPartBodyList(List<SubCoursesModel> partBodyList) {
    if (!(this.subCouresList!.length == 0)) {
      return;
    }
    for (SubCoursesModel partBody in partBodyList) {
      if (partBody.courseName[0] == this.title) {
        this.subCouresList!.add(partBody);
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
      final part = exercise.part[0];

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
