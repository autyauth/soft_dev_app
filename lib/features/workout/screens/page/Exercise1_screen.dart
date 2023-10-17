import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soft_dev_app/features/workout/screens/page/Exercise2_screen.dart';

import '../../../../core/theme/ColorSet.dart';
import '../../../select_workout/domain/models/exercise_model.dart';
import 'Home_sceen.dart';

class StartEx extends StatefulWidget {
  const StartEx({Key? key}) : super(key: key);

  @override
  State<StartEx> createState() => _StartExState();
}

class _StartExState extends State<StartEx> {
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
    return FirebaseFirestore.instance
        .collection('course')
        .doc(course)
        .snapshots()
        .map((snapshot) {
      final exerciseDocIdList =
          (snapshot.data()?['exerciseDocId'] as List<dynamic>)
              .map((item) => item.toString())
              .toList();
      return exerciseDocIdList;
    });
  }

  String? getCourseDocIdFromUser(String username) {
    String? temp;
    Map<String, dynamic> querySnapshot;
    FirebaseFirestore.instance
        .collection('userCourse')
        .where('username', isEqualTo: username)
        .snapshots()
        .listen((event) {
      querySnapshot = event.docs.first.data();
      temp = querySnapshot['courseDocId'];
    });
    return temp;
  }

  Stream<List<ExerciseModel>> getExerciseByDocIdList(List<String> docIdList) {
    return FirebaseFirestore.instance
        .collection('exercise')
        .where(FieldPath.documentId, whereIn: docIdList)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ExerciseModel.fromJson(doc.data()))
            .toList());
  }

  //static const List<Program> display = List.from(todayProgram);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    void onStartTime() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const exercising();
      }));
    }

    void onBack() {
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorSet.bgColor,
        body: SafeArea(
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
                        onPressed: onBack,
                        icon: const Icon(
                          Icons.arrow_back,
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
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: testdata.length,
                    itemBuilder: (context, index) {
                      return Boxdata(
                        screenWidth,
                        testdata[index].name,
                        testdata[index].time == 0
                            ? "Amout : ${testdata[index].amout}"
                            : "Time : ${testdata[index].time}",
                        testdata[index].media?[0].animation,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    onPressed: onStartTime,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget Boxdata(double screenWidth, String? name, String? Time, String? url) {
  return Container(
    height: 200,
    margin: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      border: Border.all(
        color: Colors.black, // Border color
        width: 2.0, // Border width
      ),
      color: ColorSet.bgWidget,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: screenWidth * 0.38,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "$name",
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 50),
                child: Text(
                  "$Time",
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          width: 150,
          child: Lottie.network(
            url!,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}
