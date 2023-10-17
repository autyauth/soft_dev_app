import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/modal/Userprofile.dart';
import 'package:soft_dev_app/features/workout/screens/page/pofile_picture_select.dart';

import '../../../select_workout/screens/widget/gradient_button.dart';
import '../../../select_workout/screens/widget/outline_text.dart';

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
  final User? currentUser = FirebaseAuth.instance.currentUser;
//ดึง data ใน database มาใส่ userdoc
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
        print('Us er document does not exist.');
        return null;
      }
    } catch (e) {
      print('Error fetching user profile data: $e');
      return null;
    }
  }

  UserProfile? userProfile;
  UserProfile? updatedUserProfile;
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

  @override
  void dispose() {
    // TODO: implement dispose
    firstNameInit.dispose();
    lastNameInit.dispose();
    heightInit.dispose();
    weightInit.dispose();
    emailInit.dispose();
    super.dispose();
  }

  DateTime? birthDate;
  String? _sex;
  String firstName = "";
  String lastName = "";
  int height = 0;
  int weight = 0;
  String email = "null";

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: 'กรุณาอย่าเว้นข้อมูลว่างครับ'),
    //PatternValidator(r'^[ก-๙]*$', errorText: 'กรุณากรอกแค่ตัวอักษรภาษาไทยครับ'),
  ]);
  final emailValidator = MultiValidator([
    EmailValidator(errorText: 'กรุฯากรอกรูปแบบemail ให้ถูกต้อง'),
    RequiredValidator(errorText: 'กรุณาอย่าเว้นข้อมูลว่างครับ'),
  ]);
  final numberValidator = MultiValidator([
    RequiredValidator(errorText: 'กรุณาอย่าเว้นข้อมูลว่างครับ'),
    PatternValidator(r'^[0-9]*$', errorText: 'กรุณากรอกแต่ตัวเลขด้วยครับ'),
  ]);

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    const double buttonwidth = 300;

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
              child: const OutlinedText(
                  text: "edits",
                  textStyle: TextStyle(
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
              child: Align(
                //edit form
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                      left: screenWidth * 0.085,
                      right: screenWidth * 0.085,
                      top: screenHeight * 0.15,
                      bottom: screenHeight * 0.25),
                  height: screenHeight * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Palette.orangeColor,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: firstNameInit,
                            validator: nameValidator,
                            decoration: InputDecoration(
                              hintText: "Enter your First name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: lastNameInit,
                            validator: nameValidator,
                            decoration: InputDecoration(
                                hintText: "Enter your last name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _birthDate(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //gender
                          padding: const EdgeInsets.all(4),
                          margin: const EdgeInsets.all(8),
                          width: screenWidth * 0.83,
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButton<String>(
                            padding: const EdgeInsets.only(left: 8),
                            underline: Container(
                              height: 0,
                            ),
                            value: _sex,
                            iconSize: 0.0,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
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
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: heightInit,
                            validator: numberValidator,
                            decoration: InputDecoration(
                                hintText: "Enter your Height(cm)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: weightInit,
                            keyboardType: TextInputType.number,
                            validator: numberValidator,
                            decoration: InputDecoration(
                                hintText: "Enter your Weight(kg)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: emailInit,
                            validator: emailValidator,
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
                      if (formKey.currentState!.validate()) {
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

                        print('sucess');
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.04,
              left: screenWidth * 0.1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  'assets/ui/back.png',
                  width: 100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
