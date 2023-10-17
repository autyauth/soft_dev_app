import 'dart:async';

//import 'package:fit/widget/timecount.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/ColorSet.dart';
import '../../modal/Exinday.dart';
import '../widget/TimeButton.dart';
import 'Exercise2_screen.dart';

class BreakTime extends StatefulWidget {
  const BreakTime({super.key});

  @override
  State<BreakTime> createState() => _StartTimerState();
}

class _StartTimerState extends State<BreakTime> {
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;

  static List<Program> todayProgram = [
    Program("A", 40, "A"),
    Program("dfasfsa", 60, "A"),
    Program("fsffdf", 50, "A")
  ];

  @override
  void initState() {
    super.initState();

    // Call your initialization function here
    StartTimer();
  }

  void resetTimer() => setState(() => seconds = maxSeconds);

  void goNext() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const exercising();
    }));
  }

  void StartTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
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

  void onBack() {
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
                                  text: "Continue", onClicked: goNext)
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

  Widget buildTimer(int min, int sec) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / maxSeconds,
            valueColor: const AlwaysStoppedAnimation(ColorSet.mainColor1),
            strokeCap: StrokeCap.round,
            strokeWidth: 18,
            backgroundColor: const Color(0xFFECE6D3),
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
        goNext();
      });
      // return const Icon(
      //   Icons.done,
      //   color: Colors.greenAccent,
      //   size: 112,
      // );
    }
    return Container(
      width: 185, // Adjust the width and height as needed
      height: 185, // Make it a square
      decoration: const BoxDecoration(
        shape: BoxShape.circle, // This makes it a circle
        color: Color.fromARGB(255, 185, 146, 146),
        //border: Border.all(color: Colors.black, width: 2), // Optional: Add a border
      ),
      child: Center(
        child: Text(
          '${twoDigits(min)} : ${twoDigits(sec)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
