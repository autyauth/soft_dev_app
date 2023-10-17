import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:fit/widget/timecount.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soft_dev_app/features/workout/screens/page/Exercise4_screen.dart';
import 'package:soft_dev_app/features/workout/screens/page/Home_sceen.dart';

import '../../../../core/theme/ColorSet.dart';
import '../widget/TimeButton.dart';

int indexEx = 0;
int readedstate = 0;
bool typeState = false;

class exercising extends StatefulWidget {
  const exercising({super.key});

  @override
  State<exercising> createState() => _exercisingState();
}

class _exercisingState extends State<exercising> {
  int maxSeconds = 50;
  int seconds = 30;
  int state = 0;
  int time = 0;
  int times = 0;
  String name = "";
  Timer? timer;

  Future<void> dd() async {}

  Future<void> someFunction() async {
    await dd();
  }

  @override
  void initState() {
    super.initState();
    // Perform one-time initialization tasks here
    maxSeconds = 50;
    seconds = 30;
    state = 0;
    time = 0;
    times = 0;
    name = "";
    timer = null;
    readedstate = 0;
    typeState = false;
    someFunction();
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer in the dispose method
    super.dispose();
  }

  void setStateIfMounted(VoidCallback callback) {
    if (mounted) {
      setState(callback);
    }
  }

  Future<void> fetchMaxSecondsFromFirestore(String courseId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('exercise')
        .doc(courseId)
        .get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final maxSecondsFromFirestore = data['amout'] as int;
      //times = data['amout'] as int;
      //time = data['time'] as int;
      //name = data['name'] as String;
      setStateIfMounted(() {
        if (time == 0) {
          typeState = false;
        } else {
          typeState = true;
          maxSeconds = time;
          seconds = maxSeconds;
        }
      });
    }
  }

  void goNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      indexEx++;
      if (indexEx == testdataExercise.length) {
        indexEx = 0;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const VictoryPage();
        }));
      } else {
        readedstate = 0;
        state = 0;
        fetchMaxSecondsFromFirestore(testdataExercise[indexEx]);
        StopTimer();
      }
    });
  }

  void resetTimer() => setState(() => seconds = maxSeconds);

  void StartTimer({bool reset = true}) {
  if (reset) {
    resetTimer();
  }
  final startTime = DateTime.now().millisecondsSinceEpoch;

  timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final elapsedSeconds = ((currentTime - startTime) / 1000).floor();
    final remainingSeconds = maxSeconds - elapsedSeconds;

    setState(() {
      if (remainingSeconds >= 0) {
        seconds = remainingSeconds;
      } else {
        StopTimer(reset: false);
      }
    });
  });
}

  void StopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      timer?.cancel();
    });
    //timer?.cancel();
  }

  void finishEx() {
    maxSeconds = 25;
    seconds = maxSeconds;
    state = 1;
    //fetchMaxSecondsFromFirestore(testdataExercise[indexEx]);
    // maxSeconds = 25;
    // seconds = maxSeconds;
    StopTimer();
    StartTimer();
  }

  void onBack() {
    indexEx = 0;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == 0 || seconds == maxSeconds;
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String anime;
    try {
      anime = testdata[indexEx].media![0].animation;
      name = testdata[indexEx].name;
      time = testdata[indexEx].time;
      times = testdata[indexEx].amout;
      //print(indexEx);
    } catch (e) {
      anime =
          'https://lottie.host/ea965162-bff0-4f00-be7b-14c946c8d1a0/mFdud1qtBe.json';
    }
    if (testdataExercise.isEmpty) {
      // Data is still being fetched
      //, return a loading indicator or another widget.
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      if (readedstate == 0) {
        fetchMaxSecondsFromFirestore(testdataExercise[indexEx]);
        readedstate = 1;
      }
      //fetchMaxSecondsFromFirestore(testdataExercise[indexEx]);
      if (state == 1) {
        return Scaffold(
          backgroundColor: ColorSet.bgColor,
          body: SafeArea(
              child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFDB7D39), Color(0xFF891414)])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Column(
                  children: [
                    Text(
                      "Are You",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make the text bold
                        fontSize: 50, // Set the font size to 24
                      ),
                    ),
                    Text(
                      "Finished?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make the text bold
                        fontSize: 50, // Set the font size to 24
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    height: screenHeight * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  buildTimer(minutes, remainingSeconds),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  TimeCountButton(
                                      text: indexEx == testdata.length - 1
                                          ? "FINISH"
                                          : "CONTINUE",
                                      onClicked: goNext)
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      }

      return Scaffold(
        backgroundColor: ColorSet.bgColor,
        body: SafeArea(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  height: screenHeight * 0.5,
                  child: Stack(
                    children: [
                      Lottie.network(
                        anime,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: screenHeight * 0.5,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Padding(
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
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              typeState
                  ? Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: screenHeight * 0.5,
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0,
                                        0), // Set the text color to blue
                                    fontSize: 18.0, // Set the font size to 24.0
                                    fontWeight:
                                        FontWeight.bold, // Make the text bold
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      buildTimer(minutes, remainingSeconds),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      isRunning || !isCompleted
                                          ? TimeCountButton(
                                              text: isRunning
                                                  ? "Pause"
                                                  : "Resume",
                                              onClicked: () {
                                                if (isRunning) {
                                                  StopTimer(reset: false);
                                                } else {
                                                  StartTimer(reset: false);
                                                }
                                              },
                                            )
                                          : TimeCountButton(
                                              text: "StartTimer",
                                              onClicked: StartTimer,
                                            ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        height: screenHeight * 0.5,
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        name,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0,
                                              0), // Set the text color to blue
                                          fontSize:
                                              30.0, // Set the font size to 24.0
                                          fontWeight: FontWeight
                                              .bold, // Make the text bold
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Text(
                                        "x$times",
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0,
                                              0), // Set the text color to blue
                                          fontSize:
                                              60.0, // Set the font size to 24.0
                                          fontWeight: FontWeight
                                              .bold, // Make the text bold
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 70,
                                      ),
                                      TimeCountButton(
                                          text: "FINISH", onClicked: finishEx),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    )
            ],
          ),
        )),
      );
    }
  }

  Widget buildTimer(int min, int sec) {
    return SizedBox(
      width: 170,
      height: 170,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / maxSeconds,
            valueColor: const AlwaysStoppedAnimation(ColorSet.mainColor1),
            strokeCap: StrokeCap.round,
            strokeWidth: 18,
            backgroundColor: ColorSet.bgSub,
          ),
          Center(
            child: buildTime(min, sec),
          )
        ],
      ),
    );
  }

  Widget buildTime(int min, int sec) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    if (seconds == 0) {
      setState(() {
        if (state == 0) {
          finishEx();
        } else {
          goNext();
        }
      });
    }
    return Text(
      '${twoDigits(min)} : ${twoDigits(sec)}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 40,
      ),
    );
  }
}
