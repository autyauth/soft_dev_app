import 'package:flutter/material.dart';

import '../../../../core/theme/ColorSet.dart';

class TimeCountButton extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const TimeCountButton(
      {super.key, required this.text, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 129,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorSet.mainColor1),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: onClicked,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          )),
    );
  }
}
