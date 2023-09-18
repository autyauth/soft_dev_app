import 'package:flutter/material.dart';

class SelectExerciseWidget extends StatelessWidget {
  const SelectExerciseWidget(
      {super.key, required this.onTap, required this.title, required this.img});
  final Function onTap;
  final String title;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.grey),
      width: double.infinity,
      height: 80,
      child: const Center(
        child: Text(
          'Select Your Exercise',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
