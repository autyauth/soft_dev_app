import 'package:flutter/material.dart';

class ImgBackButton extends StatelessWidget {
  final double width;
  ImgBackButton({Key? key, this.width = 120}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Image.asset(
        'assets/ui/back.png',
        width: width,
      ),
    );
  }
}
