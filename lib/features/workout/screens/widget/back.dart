import 'package:flutter/material.dart';

class ImgBackButton extends StatelessWidget {
  const ImgBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Image.asset(
        'assets/ui/back.png',
        width: 120,
      ),
    );
  }
}
