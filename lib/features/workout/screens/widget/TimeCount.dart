import 'package:flutter/material.dart';

class buildTime extends StatelessWidget {
  final int maxSeconds;

  const buildTime({Key? key, required this.maxSeconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int seconds = maxSeconds;
    return Text('$seconds',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 80,
        ));
  }
}
