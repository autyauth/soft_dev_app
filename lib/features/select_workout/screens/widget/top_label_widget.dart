import 'package:flutter/material.dart';

import '../../../../core/theme/pallete.dart';

Widget topLabelWidget() {
  return Container(
    decoration: const BoxDecoration(color: Palette.greyColor),
    width: double.infinity,
    height: 80,
    child: const Center(
      child: Text(
        'Select Your Exercise',
        style: TextStyle(
          color: Palette.whiteColor,
          fontSize: 35,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
