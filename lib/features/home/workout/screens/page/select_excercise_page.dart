import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/home/workout/screens/widget/select_exercise_widget.dart';
import 'package:soft_dev_app/features/home/workout/screens/widget/top_label_widget.dart';

class SelectExercisePage extends StatelessWidget {
  const SelectExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            topLabelWidget(),
            SelectExerciseWidget(
                onTap: () {}, title: 'Chest', img: 'assets/images/chest.png'),
          ]),
        ),
      ),
    );
  }
}
