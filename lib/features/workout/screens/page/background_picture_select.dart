import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/theme.dart';
import 'package:soft_dev_app/features/workout/screens/widget/back_btn.dart';
import 'package:soft_dev_app/features/workout/screens/widget/outline_text.dart';

class BackgroundPictureSelect extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_background1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.04,
            left: screenWidth * 0.1,
            child:  ImgBackButton(width: 80,),
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
        ],
      ),
    );
  }
}