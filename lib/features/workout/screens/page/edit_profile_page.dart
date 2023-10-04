import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/widget/back.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
              image: AssetImage('assets/images/profile_background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.05,
          left: screenWidth * 0.03,
          child: ImgBackButton(),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                top: screenHeight * 0.15,
                bottom: screenHeight * 0.25),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Palette.orangeColor, 
                width: 2.0, 
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
