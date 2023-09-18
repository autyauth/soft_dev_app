import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';

Widget TopLabelWidget() {
  return Container(
    decoration: BoxDecoration(color: Pallete.greyColor),
    width: double.infinity,
    height: 80,
    child: const Center(
      child: Text(
        'Select Your Exercise',
        style: TextStyle(
          color: Pallete.whiteColor,
          fontSize: 35,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
