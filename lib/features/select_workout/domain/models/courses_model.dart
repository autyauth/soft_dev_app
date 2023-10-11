import 'exercise_model.dart';

class CourseType {
  CourseType(this.name, this.image);
  final String name;
  final String image;
}

class CoursesModel {
  CoursesModel({
    required this.name,
    required this.image,
    required this.type,
    required this.description,
    //this.exerciseList,
  }) : exerciseList = [];

  final String name;
  final String image;
  final CourseType type;
  final String description;
  List<ExerciseModel>? exerciseList;

  void setExerciseList(List<ExerciseModel> exerciseList) {
    for (ExerciseModel exercise in exerciseList) {
      this.exerciseList!.add(exercise);
    }
  }

  // void setPartBodyList(List<SubCoursesModel> partBodyList) {
  //   if (!(this.subCouresList!.length == 0)) {
  //     return;
  //   }
  //   for (SubCoursesModel partBody in partBodyList) {
  //     if (partBody.courseName[0] == this.name) {
  //       this.subCouresList!.add(partBody);
  //     }
  //   }
  // }

  // List<ExerciseModel> getRandomExercises(
  //     List<ExerciseModel> exercises, int countPerPart) {
  //   final Random random = Random();
  //   final shuffledExercises = List.of(exercises)..shuffle(random);
  //   final Map<String, int> partCounts = {};

  //   // สร้างรายการว่างๆ สำหรับแต่ละ "part"
  //   final Map<String, List<ExerciseModel>> selectedExercisesPerPart = {};

  //   // วนลูปผ่านรายการออกกำลังกายเพื่อแยกตาม "part"
  //   for (final exercise in shuffledExercises) {
  //     final part = exercise.part[0];

  //     if (!partCounts.containsKey(part)) {
  //       partCounts[part] = 0;
  //       selectedExercisesPerPart[part] = [];
  //     }

  //     // เพิ่มออกกำลังกายลงใน "part" ที่ถูกเลือก
  //     if (partCounts[part]! < countPerPart) {
  //       selectedExercisesPerPart[part]?.add(exercise);
  //       partCounts[part] = partCounts[part]! + 1;
  //     }
  //   }

  //   // รวมรายการออกกำลังกายที่เลือกไว้ทั้งหมด
  //   final List<ExerciseModel> selectedExercises = [];
  //   selectedExercisesPerPart.values.forEach((exercises) {
  //     selectedExercises.addAll(exercises);
  //   });

  //   return selectedExercises;
  // }
}
