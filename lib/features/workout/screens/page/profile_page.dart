import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/modal/Userprofile.dart';
import 'package:soft_dev_app/features/workout/screens/page/edit_profile_page.dart';
import 'package:soft_dev_app/features/workout/screens/widget/outline_text.dart';

class ProfilePage extends StatelessWidget {
    Future<UserProfile?> fetchUserProfileData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('userProfile')
          .doc('/cXZMVx6sIaGJnK7FgSIO')
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data()!;
        return UserProfile.fromMap(userData);
      } else {
        print('User document does not exist.');
        return null;
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
      return null;
    }
  }

  
  String name ="";
  String imageURL = "";
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
              ),
            ),
          ),
                 
        ],
      ),
    );
  }
}
