import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/page/background_picture_select.dart';
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
  @override
  DateTime? birthDate;
  String _sex = sex.first;
  String firstName = "KKK";
  String lastName = "SASA";
  double height = 169.0;
  double weight = 72.0;
  String email = "68090251@kmitl.ac.th";

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
              child: Flexible(
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
                            controller: TextEditingController(text: firstName),
                            decoration: InputDecoration(
                              hintText: "Enter your First name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller: TextEditingController(text: lastName),
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
                          //Sex
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(left: 8, right: 8),
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
                            controller:
                                TextEditingController(text: height.toString()),
                            decoration: InputDecoration(
                                hintText: "Enter your Height(cm)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            controller:
                                TextEditingController(text: weight.toString()),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Enter your Weight(kg)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
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
                  onPress: () {},
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
    );
  }
}
