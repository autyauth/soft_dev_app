import 'package:flutter/material.dart';

import '../../domain/models/courses_model.dart';
import '../../domain/models/sub_courses_model.dart';

class SelectExerciseWidget<T> extends StatelessWidget {
  const SelectExerciseWidget(
      {super.key, required this.onTap, required this.model});
  final Function onTap;
  final T model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(model is CoursesModel
                  ? (model as CoursesModel).image
                  : (model as SubCoursesModel).image),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 140,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            model is CoursesModel
                ? (model as CoursesModel).title
                : (model as SubCoursesModel).title,
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
