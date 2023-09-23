import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/data/exercise_data.dart';
import 'package:soft_dev_app/features/workout/screens/widget/select_exercise_widget.dart';

class SelectExercisePage extends StatelessWidget {
  const SelectExercisePage({super.key});

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
                    exerciseList.length,
                    (index) {
                      final exercise = exerciseList[index];
                      return Column(
                        children: [
                          SelectExerciseWidget(
                            onTap: () {},
                            title: exercise.title,
                            img: exercise.image,
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
}
