import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 25,
            left: 16,
            child: Text(
              'Welcome',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Palette.orangeColor,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            child: Text(
              'Kerkkaiwan Supaseab',
              style: TextStyle(
                fontSize: 30,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.black,
              ),
            ),
          ),
          const Positioned(
            top: 100,
            left: 16,
            child: Text(
              'Kerkkaiwan Supaseab',
              style: TextStyle(
                fontSize: 30,
                color: Palette.creamColor2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
