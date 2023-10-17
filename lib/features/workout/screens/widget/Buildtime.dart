import 'package:flutter/material.dart';

class BuildTime extends StatelessWidget {
  final int minutes;
  final int seconds;

  BuildTime(this.minutes, this.seconds);

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    if (seconds == 0) {
      return const Icon(
        Icons.done,
        color: Colors.greenAccent,
        size: 112,
      );
    }
    return Text(
      '${twoDigits(minutes)} : ${twoDigits(seconds)}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 40,
      ),
    );
  }
}
