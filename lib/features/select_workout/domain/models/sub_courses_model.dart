// import 'dart:math';

// import 'exercise_model.dart';

// class SubCoursesModel {
//   // SubCoursesModel({
//   //   required this.title,
//   //   required this.image,
//   //   required this.description,

//   //   //required this.workout,
//   //   //this.exerciseList,
//   // }) : exerciseList = [];
//   SubCoursesModel(
//       {required this.title,
//       required this.image,
//       required this.description,
//       required this.courseName})
//       : exerciseList = [];

//   final String title;
//   final String image;
//   final String description;

//   List<String> courseName;
//   List<ExerciseModel>? exerciseList;

//   void setExerciseList(List<ExerciseModel> exerciseList) {
//     for (ExerciseModel exercise in exerciseList) {
//       if (exercise.part[0] == this.title) {
//         this.exerciseList?.add(exercise);
//       }
//     }
//   }

//   List<ExerciseModel> getRandomExercises(
//       List<ExerciseModel> exercises, int countPerPart) {
//     final Random random = Random();
//     final shuffledExercises = List.of(exercises)..shuffle(random);
//     final Map<String, int> partCounts = {};

//     // สร้างรายการว่างๆ สำหรับแต่ละ "part"
//     final Map<String, List<ExerciseModel>> selectedExercisesPerPart = {};

//     // วนลูปผ่านรายการออกกำลังกายเพื่อแยกตาม "part"
//     for (final exercise in shuffledExercises) {
//       final part = exercise.part[0];

//       if (!partCounts.containsKey(part)) {
//         partCounts[part] = 0;
//         selectedExercisesPerPart[part] = [];
//       }

//       // เพิ่มออกกำลังกายลงใน "part" ที่ถูกเลือก
//       if (partCounts[part]! < countPerPart && exercise.part[0] == this.title) {
//         selectedExercisesPerPart[part]?.add(exercise);
//         partCounts[part] = partCounts[part]! + 1;
//       }
//     }

//     // รวมรายการออกกำลังกายที่เลือกไว้ทั้งหมด
//     final List<ExerciseModel> selectedExercises = [];
//     selectedExercisesPerPart.values.forEach((exercises) {
//       selectedExercises.addAll(exercises);
//     });

//     return selectedExercises;
//   }
// }
