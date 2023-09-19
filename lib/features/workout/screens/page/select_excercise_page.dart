import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/home/workout/screens/widget/select_exercise_widget.dart';
import 'package:soft_dev_app/features/home/workout/screens/widget/top_label_widget.dart';

class SelectExercisePage extends StatelessWidget {
  const SelectExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            topLabelWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    5,
                    (index) {
                      return Column(
                        children: [
                          SelectExerciseWidget(
                            onTap: () {},
                            title: 'Exercise',
                            img: 'assets/images/temp_exercise.jpg',
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
