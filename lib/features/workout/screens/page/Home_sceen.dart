import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/sign_in_bloc/sign_in_bloc_bloc.dart';
import '../../../../core/theme/ColorSet.dart';
import '../../../select_workout/domain/models/exercise_model.dart';
import '../../../select_workout/domain/services/exercise_service.dart';
import '../widget/Calender.dart';
import 'Exercise1_screen.dart';

List<ExerciseModel> testdata = [];
List<ExerciseMedia> testdataMedia = [];
List<String> testdataCourse = [];
List<String> testdataExercise = [];
List<String> mediaList = [];

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  String username = "";
  StreamSubscription? exerciseSubscription;
  StreamSubscription? courseIdSubscription;
  StreamSubscription? exerciseIdSubscription;
  StreamSubscription? exerciseListSubscription;

  @override
  void dispose() {
    // Cancel the stream subscriptions to avoid memory leaks
    exerciseSubscription?.cancel();
    courseIdSubscription?.cancel();
    exerciseIdSubscription?.cancel();
    exerciseListSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    dd();
  }

  Future<void> dd() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    exerciseSubscription =
        ExerciseService().getUsername(currentUser!.uid).listen((event) {
      setState(() {
        username = event;
        final excercisestream = getExerciseList();
        final courseId = getUserCourseList(username);

        exerciseSubscription =
            excercisestream.listen((List<ExerciseModel> event) {
          setState(() {
            testdata = event;
          });
        });
        courseIdSubscription = courseId.listen((List<String> event) {
          setState(() {
            testdataCourse = event;
          });
          if (testdataCourse.isEmpty) {
          } else {
            final exerciseId =
                getUserExerciseList(testdataCourse[testdataCourse.length - 1]);
            exerciseIdSubscription = exerciseId.listen((List<String> event) {
              setState(() {
                testdataExercise = event;
                print(testdataExercise);
              });
              final exerciseList = getExerciseByDocIdList(testdataExercise);

              exerciseListSubscription =
                  exerciseList.listen((List<ExerciseModel> event) {
                setState(() {
                  testdata = event;
                  //print(testdata[0].name);
                  int i = 0;
                  for (var exercise in testdata) {
                    final exerciseMedia =
                        getExerciseMediaByDocIdList(exercise.mediaDocId);

                    exerciseMedia.listen((List<ExerciseMedia> event) {
                      testdata[i].setMedia(event);
                      i++;
                    });
                  }
                });
              });
            });
          }
        });
      });
    });
  }

  Stream<List<ExerciseModel>> getExerciseList() {
    return FirebaseFirestore.instance
        .collection('exercise')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ExerciseModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<String>> getUserCourseList(String username) {
    // Assuming your Firestore collection is named 'courses'.
    return FirebaseFirestore.instance
        .collection('userCourse')
        .where('username', isEqualTo: username)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data()['courseDocId'] as String;
      }).toList();
    });
  }

  Stream<List<String>> getUserExerciseList(String course) {
    try {
      return FirebaseFirestore.instance
          .collection('course')
          .doc(course)
          .snapshots()
          .map((snapshot) {
        final data = snapshot.data();
        if (data != null) {
          final exerciseDocIdList = List<String>.from(data['exerciseDocId']);
          return exerciseDocIdList;
        } else {
          return <String>[];
        }
      });
    } catch (e) {
      return Stream.value(<String>[]);
    }
  }

  Future<String?> getPicture(String courseId) async {
    String? temp;
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userCourse')
          .doc(courseId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        temp = data['image'] as String?;
      }
    } catch (e) {
      print('Error fetching picture: $e');
    }

    return temp;
  }

  String? getCourseDocIdFromUser(String username) {
    String? temp;
    Map<String, dynamic> querySnapshot;
    FirebaseFirestore.instance
        .collection('userCourse')
        .where('username', isEqualTo: username)
        .snapshots()
        .listen((event) {
      querySnapshot = event.docs.first.data!();
      temp = querySnapshot['courseDocId'];
    });
    return temp;
  }

  Stream<List<ExerciseModel>> getExerciseByDocIdList(List<String> docIdList) {
    if (docIdList.isEmpty) {
      // Handle the case when docIdList is empty
      return Stream.value([]);
    } else {
      return FirebaseFirestore.instance
          .collection('exercise')
          .where(FieldPath.documentId, whereIn: docIdList)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ExerciseModel.fromJson(doc.data()))
              .toList());
    }
  }

  Stream<List<ExerciseMedia>> getExerciseMediaByDocIdList(
      List<String> docIdList) {
    return FirebaseFirestore.instance
        .collection('exerciseMedia')
        .where(FieldPath.documentId, whereIn: docIdList)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ExerciseMedia.fromJson(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    void onStart() {
      if (testdataCourse.isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const StartEx();
        }));
      }
    }

    void onBack() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: ColorSet.bgColor,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OutlinedButton.icon(
                        label: const Text(""),
                        onPressed: () {context
                                        .read<SignInBloc>()
                                        .add(const SignOutRequired());},
                        icon: const Icon(
                          Icons.power,
                          color: Colors.white,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: MyCalendar(),
                ),
                Container(
                  height: 56,
                  width: 129,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(3, 10),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: onStart,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorSet.mainColor1),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    child: const Text('START'),
                  ),
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
