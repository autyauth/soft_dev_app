import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/modal/Userprofile.dart';
import 'package:soft_dev_app/features/workout/screens/page/edit_profile_page.dart';

import '../../../select_workout/screens/widget/outline_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Future<UserProfile?> fetchUserProfileData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('userProfile')
          .doc(currentUser?.uid)
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

  @override
  void initState() {
    super.initState();
    //fetch โดย เรียก function ข้างบนมาใส่ profile
    fetchUserProfileData().then((profile) {
      if (profile != null) {
        setState(() {
          userProfile = profile;
          //ใช้ controller เพราะ initvalue ใช้ได้ครั้งเดียวแล้ว data โหลดไม่ทันเลย กลายเป็น empty string

          name = '${userProfile?.firstName} ${userProfile?.lastName}';
          imageURL = userProfile?.imageUrl ?? "";
        });
      }
    });
  }

  UserProfile? userProfile;

  String name = "";

  String imageURL = "";

  // _name() {
  @override
  Widget build(BuildContext context) {
    print(imageURL);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageURL == ""
                    ? const AssetImage('assets/images/profile_background1.png')
                        as ImageProvider
                    : NetworkImage(imageURL),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Positioned(
            top: 25,
            left: 16,
            child: OutlinedText(
                text: "Welcome",
                textStyle: TextStyle(
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
                text: name,
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
                            builder: (context) => const EditProfilePage()))
                    .then((value) {
                  setState(() {
                    fetchUserProfileData().then((profile) {
                      if (profile != null) {
                        setState(() {
                          userProfile = profile;
                          //ใช้ controller เพราะ initvalue ใช้ได้ครั้งเดียวแล้ว data โหลดไม่ทันเลย กลายเป็น empty string

                          name =
                              '${userProfile?.firstName} ${userProfile?.lastName}';
                          imageURL = userProfile?.imageUrl ?? "";
                        });
                      }
                    });
                  });
                });
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
