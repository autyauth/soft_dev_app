import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color outlineColor;
  final double outlineWidth;

  OutlinedText({
    required this.text,
    required this.textStyle,
    required this.outlineColor,
    required this.outlineWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = outlineWidth
              ..color = outlineColor,
          ),
        ),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}


