import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/data/exercise_data.dart';
import 'package:soft_dev_app/features/workout/data/list_of_part.dart';
import 'package:soft_dev_app/features/workout/data/list_of_workout.dart';
import 'package:soft_dev_app/features/workout/domain/models/exercise_model.dart';
import 'package:soft_dev_app/features/workout/domain/models/part_body_model.dart';
import 'package:soft_dev_app/features/workout/domain/models/workout_list_model.dart';
import 'package:soft_dev_app/features/workout/screens/widget/select_exercise_widget.dart';

class SelectExercisePage extends StatefulWidget {
  const SelectExercisePage({super.key});

  @override
  State<SelectExercisePage> createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> {
  List<WorkoutListModel> workoutList = [];
  @override
  void initState() {
    super.initState();
    loadWorkout();
  }

  void loadWorkout() {
    int i = 0;
    for (WorkoutListModel workout in listWorkout) {
      workoutList.add(workout);
      if (!workout.havePart) {
        List<ExerciseModel> temp = workout.getRandomExercises(exerciseList, 2);
        workoutList[i].setExerciseList(temp);
      } else {
        // Set PartBodyList here
        workoutList[i].setPartBodyList(all_part);

        int y = 0;
        for (PartBodyModel partBody in workoutList[i].partBodyList!) {
          List<ExerciseModel> temp =
              partBody.getRandomExercises(exerciseList, 2);
          workoutList[i].partBodyList![y].setExerciseList(temp);
          y++;
        }
      }
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Your Exercise',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Palette.whiteColor,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Palette.greyColor,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    workoutList.length,
                    (index) {
                      final workout = workoutList[index];
                      return Column(
                        children: [
                          SelectExerciseWidget(
                            onTap: () {},
                            workout: workout,
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         'Select Your Exercise',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: Palette.whiteColor,
  //           fontSize: 30,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       centerTitle: true,
  //       backgroundColor: Palette.greyColor,
  //     ),
  //     backgroundColor: Colors.black,
  //     body: SafeArea(
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: List.generate(
  //                   workoutList.length,
  //                   (index) {
  //                     final workout = workoutList[index];
  //                     return Column(
  //                       children: [
  //                         SelectExerciseWidget(
  //                           onTap: () {},
  //                           workout: workout,
  //                         ),
  //                         const SizedBox(
  //                           height: 20,
  //                         )
  //                       ],
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
