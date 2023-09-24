import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/workout/domain/models/workout_list_model.dart';

class SelectExerciseWidget extends StatelessWidget {
  const SelectExerciseWidget(
      {super.key, required this.onTap, required this.workout});
  final Function onTap;
  final WorkoutListModel workout;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(workout.image), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 140,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            workout.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
