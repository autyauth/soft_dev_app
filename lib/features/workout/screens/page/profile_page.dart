import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/page/edit_profile_page.dart';
import 'package:soft_dev_app/features/workout/screens/widget/outline_text.dart';

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
                image: AssetImage('assets/images/profile_background1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
           Positioned(
            top: 25,
            left: 16,
            child: OutlinedText(
                text: "Welcome",
                textStyle: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Palette.orangeColor,
                ),
                outlineColor: Colors.black,
                outlineWidth: 2.0),
          ),
          Positioned(
            top: 85,
            left: 16,
            child: OutlinedText(
                text: "kerkkaiwan Supaseab",
                textStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Palette.creamColor2,
                ),
                outlineColor: Colors.black,
                outlineWidth: 2.0),
          ),
          
          Positioned(
            top: 30,
            right: 16,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ),
                  );
                },
                icon: SizedBox(
                height: 50,
                child: Image.asset("assets/icons/setting.png"),
              ),),
          ),
        ],
      ),
    );
  }
}
