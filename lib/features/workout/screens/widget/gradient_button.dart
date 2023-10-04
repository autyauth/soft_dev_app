import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double height;
  final double width;
  final List<Color> colorsArray;
  final String buttonText;
  final VoidCallback onPress;
  GradientButton({
    required this.height,
    required this.width,
    required this.colorsArray,
     required this.buttonText,
     required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(20),
         gradient: LinearGradient(
          colors: colorsArray,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(buttonText,),
        
      ),
    );
  }
}
