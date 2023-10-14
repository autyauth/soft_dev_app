import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/modal/Userprofile.dart';
import 'package:soft_dev_app/features/workout/screens/page/pofile_picture_select.dart';
import 'package:soft_dev_app/features/workout/screens/widget/back_btn.dart';
import 'package:soft_dev_app/features/workout/screens/widget/gradient_button.dart';
import 'package:soft_dev_app/features/workout/screens/widget/outline_text.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

//const
const List<String> sex = <String>[
  'Male',
  'Female',
];

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();
//ไว้ใช้ init ค่าทีมีอยู่ ตอนเริ่ม
  TextEditingController firstNameInit = TextEditingController();
  TextEditingController lastNameInit = TextEditingController();
  TextEditingController heightInit = TextEditingController();
  TextEditingController weightInit = TextEditingController();
  TextEditingController emailInit = TextEditingController();
//ดึง data ใน database มาใส่ userdoc
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

  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection('userProfile')
          .doc('/cXZMVx6sIaGJnK7FgSIO') // Use the correct document ID
          .update(userProfile.toMap());
      print('User profile updated successfully');
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    //fetch โดย เรียก function ข้างบนมาใส่ profile
    fetchUserProfileData().then((profile) {
      if (profile != null) {
        setState(() {
          userProfile = profile;
          //ใช้ controller เพราะ initvalue ใช้ได้ครั้งเดียวแล้ว data โหลดไม่ทันเลย กลายเป็น empty string
          firstNameInit.text = userProfile?.firstName ?? '';
          lastNameInit.text = userProfile?.lastName ?? '';
          heightInit.text = userProfile?.height.toString() ?? '0';
          weightInit.text = userProfile?.weight.toString() ?? '0';
          emailInit.text = userProfile?.email ?? '';
          birthDate = userProfile?.birthDate;
          _sex = userProfile?.gender ?? '';
        });
      }
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   firstNameInit.dispose();
  //   lastNameInit.dispose();
  //   heightInit.dispose();
  //   weightInit.dispose();
  //   emailInit.dispose();
  //   super.dispose();
  // }

  @override
  DateTime? birthDate;
  String? _sex;
  String firstName = "";
  String lastName = "";
  int height = 0;
  int weight = 0;
  String email = "null";

  void pickBirthDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Palette.orangeColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          // Update birthDate with the selected date
          birthDate = value;
        });
      }
    });
  }

  _birthDate() {
    if (birthDate == null) {
      return "Pick your birth Date";
    } else {
      return "${birthDate?.day.toString()}/${birthDate?.month}/${birthDate?.year}";
    }
  }

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final double buttonwidth = 300;

    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
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
                          child: TextFormField(
                            controller: firstNameInit,
                            decoration: InputDecoration(
                              hintText: "Enter your First name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: lastNameInit,
                            decoration: InputDecoration(
                                hintText: "Enter your last name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: pickBirthDate,
                            child: SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _birthDate(),
                                      style: const TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //gender
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.all(8),
                          width: screenWidth * 0.83,
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton<String>(
                            padding: EdgeInsets.only(left: 8),
                            underline: Container(
                              height: 0,
                            ),
                            value: _sex,
                            iconSize: 0.0,
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 16),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                _sex = value!;
                              });
                            },
                            items: sex
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: heightInit,
                            decoration: InputDecoration(
                                hintText: "Enter your Height(cm)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: weightInit,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Enter your Weight(kg)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: emailInit,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (text) {
                              text != null ? email = text : email = "";
                            },
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
            //ปุ่ม ดำเนินการ
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
                    buttonText: 'Save',
                    onPress: () {
                      userProfile?.firstName = firstNameInit.text;
                      userProfile?.lastName = lastNameInit.text;
                      userProfile?.height = int.parse(heightInit.text);
                      userProfile?.weight = int.parse(weightInit.text);
                      userProfile?.email = emailInit.text;
                      userProfile?.birthDate = birthDate;
                      userProfile?.gender = _sex;

                      if (userProfile != null) {
                        updateUserProfile(userProfile!);
                      }
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
      ),
    );
  }
}
