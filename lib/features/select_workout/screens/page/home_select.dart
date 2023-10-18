import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/courses_model.dart';
import 'package:soft_dev_app/features/select_workout/domain/services/exercise_service.dart';
import 'package:soft_dev_app/features/select_workout/screens/widget/body_add_home_select.dart';
import 'package:soft_dev_app/features/select_workout/screens/widget/select_exercise_widget.dart';
import 'package:soft_dev_app/features/workout/screens/page/Home_sceen.dart';

import '../../../../blocs/sign_in_bloc/sign_in_bloc_bloc.dart';
import '../../../../core/theme/pallete.dart';
import '../../../../routing/route_constants.dart';
import '../../../workout/screens/page/Exercise1_screen.dart';
import '../../domain/models/exercise_model.dart';

class HomeSelect extends StatefulWidget {
  const HomeSelect({super.key});

  @override
  State<HomeSelect> createState() => _HomeSelectState();
}

class _HomeSelectState extends State<HomeSelect> {
  List<String> courseDocId = [];
  List<CoursesModel> courseList = [];
  String userId = "";
  String username = "";
  bool _isDisposed = false;

  StreamSubscription? usernameSubscription;
  //StreamSubscription? courseIdSubscription;
  StreamSubscription? courseListSubscription;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  void dispose() {
    _isDisposed = true;
    usernameSubscription?.cancel();
    //courseIdSubscription?.cancel();
    courseListSubscription?.cancel();
    super.dispose();
  }

  void initializeData() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    usernameSubscription =
        ExerciseService().getUsername(currentUser!.uid).listen((event) {
      if (mounted && !_isDisposed) {
        setState(() {
          username = event;
          final courseIdStream =
              ExerciseService().getUserCourseIdByUsername(username);
          courseIdStream.listen((event) {
            if (mounted && !_isDisposed) {
              if (event.isNotEmpty) {
                setState(() {
                  courseDocId = event;
                  courseList
                      .clear(); // Clear the courseList before adding new elements
                  getCourseUser(event);
                });
              } else {
                // Handle the case where the event is empty.
                print('No Course');
              }
            }
          });
        });
      }
    });
  }

  void getCourseUser(List<String> courseId) {
    const int chunkSize = 30;
    for (var i = 0; i < courseId.length; i += chunkSize) {
      final List<String> chunk = courseId.sublist(
          i, i + chunkSize > courseId.length ? courseId.length : i + chunkSize);
      final courseStream = ExerciseService().getCourseListByListDocId(chunk);
      courseListSubscription = courseStream.listen((event) {
        if (mounted && !_isDisposed) {
          setState(() {
            courseList.addAll(event);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TopFloatingActionButton(onTap: () {
        context.pushNamed(RouteConstants.courseTypeRoute).then((value) async {
          initializeData();
        });
      }),
      backgroundColor: Palette.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Container(
                          padding: const EdgeInsets.all(10.0),
                          height: 70,
                          decoration: BoxDecoration(
                            color: Palette.darkColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // IconButton(
                                //   icon: const Icon(Icons.arrow_back),
                                //   color: Colors.white,
                                //   onPressed: () {
                                //     context
                                //         .read<SignInBloc>()
                                //         .add(const SignOutRequired());
                                //   },
                                // ),
                                const Text(' คอร์สของคุณ : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(courseList.length.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ])),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                courseList.isNotEmpty
                    ? CourseListWidget(
                        courseList: courseList,
                        courseDocId: courseDocId,
                      )
                    : const BodyAddHomeSelect()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopFloatingActionButton extends StatelessWidget {
  const TopFloatingActionButton({super.key, required this.onTap});

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 180.0,
          right: 0.0,
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              backgroundColor: Palette.darkColor,
              onPressed: () {
                onTap();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}

class CourseListWidget extends StatefulWidget {
  const CourseListWidget(
      {super.key, required this.courseList, required this.courseDocId});
  final List<CoursesModel> courseList;
  final List<String> courseDocId;
  @override
  State<CourseListWidget> createState() => _CourseListWidgetState();
}

class _CourseListWidgetState extends State<CourseListWidget> {
  late List<Stream<List<ExerciseModel>>> exerciseStream;

  @override
  void initState() {
    super.initState();
    exerciseStream = List.generate(widget.courseList.length, (index) {
      return ExerciseService()
          .getExerciseByDocIdList(widget.courseList[index].exerciseDocId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.courseList.length, (index) {
        return StreamBuilder<List<ExerciseModel>>(
          stream: exerciseStream[index],
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ExerciseModel> exList = snapshot.data!;
              final course = widget.courseList[index];
              final courseId = widget.courseDocId[index];
              return SelectExerciseWidget<CoursesModel>(
                model: course,
                onTap: () async {
                  await startEx(courseId, exList);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const StartEx();
                  }));
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      }),
    );
  }

  Future<void> startEx(
      String courseId, List<ExerciseModel> exerciseList) async {
    // A list to store all the media fetching operations
    List<Future<void>> mediaFetchFutures = [];

    // Fetch exercise media for each exercise
    for (ExerciseModel exercise in exerciseList) {
      var mediaFetchFuture = ExerciseService()
          .getExerciseMediaByDocId(exercise.mediaDocId)
          .listen((mediaList) {
        exercise.setMedia(mediaList);
        setState(() {
          testdata = List.from(exerciseList);
        });
        //print(exercise.name);
        // Once the media is fetched and set, you can navigate to the StartEx screen
      });
    }
    await Future.delayed(const Duration(seconds: 1));
    //await Future.wait(mediaFetchFutures);
  }
}
//   Future<void> startEx(
//       String courseId, List<ExerciseModel> exerciseList) async {
//     // Fetch exercise media for each exercise
//     for (var exercise in exerciseList) {
//       ExerciseService()
//           .getExerciseMediaByDocId(exercise.mediaDocId)
//           .listen((mediaList) {
//         exercise.media = mediaList;
//         print(exercise.media?[0].image);
//         // Once the media is fetched and set, you can navigate to the StartEx screen
//       });
//     }

//     testdataCourse[0] = courseId;
//     testdata = exerciseList;
//     print(testdataCourse[0]);
//     print(testdata[0].name);
//     print(testdata[1].name);
//   }
// }

// class _CourseListWidgetState extends State<CourseListWidget> {
//   late List<Stream<List<ExerciseModel>>> exerciseStream;
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < widget.courseList.length; i++) {
//       exerciseStream[i] = ExerciseService()
//           .getExerciseByDocIdList(widget.courseList.first.exerciseDocId);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<ExerciseModel>>(
//       stream: exerciseStream,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<ExerciseModel> exList = snapshot.data!;
//           return Column(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: widget.courseList.length,
//                 itemBuilder: (context, index) {
//                   final course = widget.courseList[index];
//                   final courseId = widget.courseDocId[index];
//                   return SelectExerciseWidget<CoursesModel>(
//                     model: course,
//                     onTap: () async {
//                       startEx(courseId, exList);
//                       Navigator.of(context)
//                           .push(MaterialPageRoute(builder: (context) {
//                         return const StartEx();
//                       }));
//                     },
//                   );
//                 },
//               ),
//               const SizedBox(
//                 height: 100,
//               )
//             ],
//           );
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return const CircularProgressIndicator(); // Show a loading indicator if data is not available yet
//         }
//       },
//     );
//   }
// }

// // void startEx(String courseId, List<ExerciseModel> exerciseList) {
// //   testdataCourse[0] = courseId;
// //   testdata = exerciseList;
// // }
// Future<void> startEx(String courseId, List<ExerciseModel> exerciseList) async {
//   // Fetch exercise media for each exercise
//   for (var exercise in exerciseList) {
//     await ExerciseService()
//         .getExerciseMediaByDocId(exercise.mediaDocId)
//         .listen((mediaList) {
//       exercise.media = mediaList;
//       print(exercise.media?[0].image);
//       // Once the media is fetched and set, you can navigate to the StartEx screen
//     }).asFuture();
//   }

//   testdataCourse[0] = courseId;
//   testdata = exerciseList;
// }
