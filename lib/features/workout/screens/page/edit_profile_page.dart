import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/page/background_picture_select.dart';
import 'package:soft_dev_app/features/workout/screens/page/pofile_picture_select.dart';
import 'package:soft_dev_app/features/workout/screens/widget/back_btn.dart';
import 'package:soft_dev_app/features/workout/screens/widget/gradient_button.dart';
import 'package:soft_dev_app/features/workout/screens/widget/outline_text.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final double buttonwidth = 300;
    
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
            right: screenWidth * 0.1,
            child: OutlinedText(
                text: "edits",
                textStyle: const TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Palette.orangeCreamColor2,
                ),
                outlineColor: Colors.black,
                outlineWidth: 2.0),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // Close the keyboard when tapping outside text fields
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Flexible(
                child: Align(
                  //edit form
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: screenWidth * 0.085,
                        right: screenWidth * 0.085,
                        top: screenHeight * 0.15,
                        bottom: screenHeight * 0.25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Palette.orangeColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter your First name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Enter your last name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Enter your birth date",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Enter your Height(cm)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Enter your Weight(kg)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Enter your email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.8,
            left: screenWidth * 0.5 - buttonwidth / 2,
            child: Column(
              children: [
                GradientButton(
                  height: 44,
                  width: buttonwidth,
                  colorsArray: const [
                    Palette.orangeCreamColor2,
                    Palette.orangeColor,
                    Palette.orangeColor
                  ],
                  buttonText: 'Profile Picture  Select',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePictureSelect(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                GradientButton(
                  height: 44,
                  width: buttonwidth,
                  colorsArray: const [
                    Palette.orangeCreamColor2,
                    Palette.orangeColor,
                    Palette.orangeColor
                  ],
                  buttonText: 'Background Picture',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BackgroundPictureSelect(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.04,
            left: screenWidth * 0.1,
            child: ImgBackButton(),
          ),
        ],
      ),
    );
  }
}
