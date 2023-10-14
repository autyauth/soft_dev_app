import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_dev_app/blocs/sign_up_bloc/sign_up_bloc_bloc.dart';
import 'package:soft_dev_app/screens/auth/components/my_text_field.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
	final passwordController = TextEditingController();
  final emailController = TextEditingController();
	final nameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	bool signUpRequired = false;

	bool containsUpperCase = false;
	bool containsLowerCase = false;
	bool containsNumber = false;
	bool containsSpecialChar = false;
	bool contains8Length = false;

  bool isMale = false;
  bool isFemale = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
			listener: (context, state) {
				if(state is SignUpSuccess) {
					setState(() {
					  signUpRequired = false;
					});
					// Navigator.pop(context);
				} else if(state is SignUpProcess) {
					setState(() {
					  signUpRequired = true;
					});
				}  else if(state is SignUpFailure) {
					return;
				} 
			},
      child: SingleChildScrollView( //เพิ่ม
        child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(CupertinoIcons.mail_solid),
                        validator: (val) {
                          if(val!.isEmpty) {
                            return 'Please fill in this field';													
                          } else if(!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        }
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock_fill),
                        onChanged: (val) {
                          if(val!.contains(RegExp(r'[A-Z]'))) {
                            setState(() {
                              containsUpperCase = true;
                            });
                          } else {
                            setState(() {
                              containsUpperCase = false;
                            });
                          }
                          if(val.contains(RegExp(r'[a-z]'))) {
                            setState(() {
                              containsLowerCase = true;
                            });
                          } else {
                            setState(() {
                              containsLowerCase = false;
                            });
                          }
                          if(val.contains(RegExp(r'[0-9]'))) {
                            setState(() {
                              containsNumber = true;
                            });
                          } else {
                            setState(() {
                              containsNumber = false;
                            });
                          }
                          if(val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                            setState(() {
                              containsSpecialChar = true;
                            });
                          } else {
                            setState(() {
                              containsSpecialChar = false;
                            });
                          }
                          if(val.length >= 8) {
                            setState(() {
                              contains8Length = true;
                            });
                          } else {
                            setState(() {
                              contains8Length = false;
                            });
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                              if(obscurePassword) {
                                iconPassword = CupertinoIcons.eye_fill;
                              } else {
                                iconPassword = CupertinoIcons.eye_slash_fill;
                              }
                            });
                          },
                          icon: Icon(iconPassword),
                        ),
                        validator: (val) {
                          if(val!.isEmpty) {
                            return 'Please fill in this field';			
                          } else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        }
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "⚈  1 uppercase",
                              style: TextStyle(
                                color: containsUpperCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground
                              ),
                            ),
                            Text(
                              "⚈  1 lowercase",
                              style: TextStyle(
                                color: containsLowerCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground
                              ),
                            ),
                            Text(
                              "⚈  1 number",
                              style: TextStyle(
                                color: containsNumber
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "⚈  1 special character",
                              style: TextStyle(
                                color: containsSpecialChar
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground
                              ),
                            ),
                            Text(
                              "⚈  8 minimum character",
                              style: TextStyle(
                                color: contains8Length
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onBackground
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: nameController,
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(CupertinoIcons.person_fill),
                        validator: (val) {
                          if(val!.isEmpty) {
                            return 'Please fill in this field';													
                          } else if(val.length > 30) {
                            return 'Name too long';
                          }
                          return null;
                        }
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: ageController,
                        hintText: 'Age',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(CupertinoIcons.timer_fill),
                        validator: (val) {
                          if(val!.isEmpty) {
                            return 'Please fill in this field';													
                          } else if(val.length > 10) {
                            return 'Age too long';
                          }
                          return null;
                        }
                      ),
                    ),
                    const SizedBox(height: 10),
                // Checkbox for gender
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isMale,
                      onChanged: (value) {
                        setState(() {
                          isMale = value ?? false;
                          isFemale = !isMale;
                          genderController.text = isMale ? 'Male' : '';
                        });
                      },
                    ),
                    Text('Male'),
                    Checkbox(
                      value: isFemale,
                      onChanged: (value) {
                        setState(() {
                          isFemale = value ?? false;
                          isMale = !isFemale;
                          genderController.text = isFemale ? 'Female' : '';
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
                
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: heightController,
                        hintText: 'Height',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(CupertinoIcons.arrow_up_down),
                        validator: (val) {
                          if(val!.isEmpty) {
                            return 'Please fill in this field';													
                          } else if(val.length > 30) {
                            return 'Height too long';
                          }
                          return null;
                        }
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MyTextField(
                        controller: weightController,
                        hintText: 'Weight',
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        prefixIcon: const Icon(CupertinoIcons.arrow_up_bin_fill),
                        validator: (val) {
                          if(val!.isEmpty) {
                            return 'Please fill in this field';													
                          } else if(val.length > 10) {
                            return 'Weight too long';
                          }
                          return null;
                        }
                      ),
                    ),
                    //ถ้าเพิ่มวิดเจ็ตระวังมัน overflow
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    !signUpRequired
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                MyUser myUser = MyUser.empty;
                                myUser = myUser.copyWith( //เพิ่มลง data ได้
                                  email: emailController.text,
                                  name: nameController.text,
                                  height: heightController.text,
                                  weight: weightController.text,
                                  age: ageController.text,
                                  gender: genderController.text,

                                );
                                setState(() {
                                  context.read<SignUpBloc>().add(
                                    SignUpRequired(
                                      myUser,
                                      passwordController.text
                                    )
                                  );
                                });																			
                              }
                            },
                            style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)
                              )
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            )
                            
                          ),
                          
                        )
                      : const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                  ],
                ),
              ),
          ),
      ),
    );
  }
}