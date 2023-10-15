import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/theme.dart';

import '../../../select_workout/screens/widget/back_btn.dart';
import '../../../select_workout/screens/widget/outline_text.dart';

class BackgroundPictureSelect extends StatefulWidget {
  @override
  State<BackgroundPictureSelect> createState() =>
      _BackgroundPictureSelectState();
}

class _BackgroundPictureSelectState extends State<BackgroundPictureSelect> {
  int count = 0;

  void increase() {
    setState(() {
      count += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.04,
            left: screenWidth * 0.1,
            child: ImgBackButton(
              width: 80,
            ),
          ),
          Positioned(
            top: screenHeight * 0.04,
            right: screenWidth * 0.1,
            child: OutlinedText(
                text: "Background\nPicture",
                textStyle: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Palette.orangeCreamColor2,
                ),
                outlineColor: Colors.black,
                outlineWidth: 2.0),
          ),
          Center(
            child: Text(
              count.toString(),
              style: TextStyle(fontSize: 50),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(onPressed: increase))
        ],
      ),
    );
  }
}
