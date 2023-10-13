import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/courses_model.dart';

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
              // image: AssetImage(model is CoursesModel
              //     ? (model as CoursesModel).image
              //     : (model as SubCoursesModel).image),
              image: NetworkImage(model is CourseType
                  ? (model as CourseType).image
                  : (model as CoursesModel).image),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        height: 140,
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            model is CourseType
                ? (model as CourseType).name
                : (model as CoursesModel).name,
            style: const TextStyle(
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
