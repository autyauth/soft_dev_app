import 'dart:io';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soft_dev_app/core/theme/theme.dart';
import 'package:soft_dev_app/features/workout/screens/modal/Userprofile.dart';

import '../../../select_workout/screens/widget/back_btn.dart';
import '../../../select_workout/screens/widget/gradient_button.dart';
import '../../../select_workout/screens/widget/outline_text.dart';

class ProfilePictureSelect extends StatefulWidget {
  @override
  State<ProfilePictureSelect> createState() => _ProfilePictureSelectState();
}

class _ProfilePictureSelectState extends State<ProfilePictureSelect> {
  final buttonwidth = 300.0;

  File? _pickedImage;

  String docplace = 'cXZMVx6sIaGJnK7FgSIO';
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(currentUser?.uid) // Use the correct document ID
          .update(userProfile.toMap());
      print('User profile updated successfully');
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  UserProfile? userProfile;
  UserProfile? updatedUserProfile;

  @override
  void initState() {
    super.initState();
    fetchUserProfileData().then((profile) {
      if (profile != null) {
        setState(() {
          userProfile = profile;

          imageURL = userProfile?.imageUrl ?? "";
        });
      }
    });
  }

  String imageURL = '';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;

    Isolate.spawn(uploadTask, sendPort);
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
            child: const ImgBackButton(),
          ),
          Positioned(
            top: screenHeight * 0.04,
            right: screenWidth * 0.1,
            child: const OutlinedText(
                text: "Profile\nPicture",
                textStyle: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Palette.orangeCreamColor2,
                ),
                outlineColor: Colors.black,
                outlineWidth: 2.0),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(
                left: screenWidth * 0.085,
                top: screenHeight * 0.15,
              ),
              height: screenHeight * 0.6,
              width: 0.83 * screenWidth,
              decoration: const BoxDecoration(color: Colors.white),
              child: _pickedImage != null
                  ? Image.file(_pickedImage!)
                  : const Center(child: Text('Please select image')),
            ),
          ),
          Positioned(
            top: screenHeight * 0.85,
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
                  buttonText: 'Select Image',
                  onPress: () {
                    _pickImageFromGallery();
                  },
                ),
                const SizedBox(height: 10),
                GradientButton(
                  height: 44,
                  width: buttonwidth,
                  colorsArray: const [
                    Palette.orangeCreamColor2,
                    Palette.orangeColor,
                    Palette.orangeColor
                  ],
                  buttonText: 'Save',
                  onPress: () {
                    if (_pickedImage != null) {
                      _uploadImageToStorage(_pickedImage!);
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      _pickedImage = File(pickedImage.path);
    });
  }

  Future<void> _uploadImageToStorage(File imageFile) async {
    final storageRef = _storage.ref().child(
        'userImage/ProfilePicture_${currentUser?.uid}.png'); // Change the storage path as needed

    final receivePort = ReceivePort();
    await Isolate.spawn(uploadTask, receivePort.sendPort);

    receivePort.listen((message) async {
      if (message is SendPort) {
        message.send(imageFile.path);
      } else if (message is String) {
        try {
          await storageRef.putFile(File(message));
          final imageUrl = await storageRef.getDownloadURL();
          userProfile?.imageUrl = imageUrl;
          if (userProfile != null) {
            updateUserProfile(userProfile!);
          }
          print('Image uploaded successfully ${userProfile?.imageUrl}');
        } catch (e) {
          print('Error uploading image: $e');
        }
      }
    });
  }
}

void uploadTask(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  receivePort.listen((message) async {
    if (message is String) {
      sendPort.send(message);
    }
  });
}
