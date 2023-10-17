import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/select_workout/domain/services/exercise_service.dart';
import 'package:soft_dev_app/features/workout/screens/page/Exercise2_screen.dart';
import 'package:soft_dev_app/features/workout/screens/page/Home_sceen.dart';

import '../../../select_workout/screens/widget/notch_button_bar.dart';
import 'Exercise1_screen.dart';

class VictoryPage extends StatefulWidget {
  const VictoryPage({super.key});

  @override
  State<VictoryPage> createState() => _VictoryPageState();
}

class _VictoryPageState extends State<VictoryPage> {
  final confesController = ConfettiController();
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _triggerConfetti();
  }

  void _triggerConfetti() {
    setState(() {
      confesController.play();
    });
    // Stop the confetti after 5 seconds
    Timer(Duration(seconds: 5), () {
      confesController.stop();
    });
  }

  final String time = '18:00';

  final int cal = 210;

  final int score = 1000;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFDA4618),
                  Color.fromARGB(255, 236, 230, 211),
                  Color.fromARGB(255, 236, 230, 211),
                  Color.fromARGB(255, 236, 230, 211),
                  Color.fromARGB(255, 236, 230, 211),
                  Color.fromARGB(255, 236, 230, 211),
                  Color.fromARGB(255, 236, 230, 211),
                ], // Customize your gradient colors here
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                ),
                Container(
                  height: screenHeight * 0.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://i.ibb.co/NsXN3yM/pngtree-beautiful-trophy-png-image-4541793-removebg-preview.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Container(
                  height: 50,
                  width: 280,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15), // Set the border radius
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const StartEx();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 220, 26, 27),
                    ),
                    child: const Text(
                      'DO IT AGAIN',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Container(
                  height: 50,
                  width: 280,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(15), // Set the border radius
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      String userCourseId = await ExerciseService()
                          .getUserCourseIdByCourseId(
                              testdataCourse[testdataCourse.length - 1]);
                      await ExerciseService().deleteCourse(
                          testdataCourse[testdataCourse.length - 1]);
                      await ExerciseService().deleteUserCourse([userCourseId]);
                      indexEx = 0;
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const AnimatedNavbar();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 111, 99, 91),
                    ),
                    child: const Text(
                      'HOME',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confesController,
              blastDirectionality: BlastDirectionality
                  .explosive, // You can customize confetti settings here
              shouldLoop: false,
              numberOfParticles: 25, // Number of confetti pieces
              maxBlastForce: 10,
              minBlastForce: 4,
              // Customize confetti appearance
            ),
          ),
        ),
      ],
    );
  }
}
