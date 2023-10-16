import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/courses_model.dart';
import 'package:soft_dev_app/features/select_workout/domain/services/exercise_service.dart';
import 'package:soft_dev_app/features/select_workout/screens/widget/body_add_home_select.dart';
import 'package:soft_dev_app/features/select_workout/screens/widget/select_exercise_widget.dart';

import '../../../../blocs/sign_in_bloc/sign_in_bloc_bloc.dart';
import '../../../../core/theme/pallete.dart';
import '../../../../routing/route_constants.dart';

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

  @override
  void initState() {
    super.initState();

    initializeData();
    for (var course in courseDocId) {
      print(course);
    }
  }

  void initializeData() async {
    // FirebaseUserRepo().user.listen((user) {
    //   setState(() {
    //     userId = user!.uid;
    //   });
    // });
    final User? currentUser = FirebaseAuth.instance.currentUser;

    ExerciseService().getUsername(currentUser!.uid).listen((event) {
      setState(() {
        username = event;
        print(currentUser.uid);
        print(username);
        final courseIdStream =
            ExerciseService().getUserCourseIdByUsername(username);
        courseIdStream.listen((event) {
          print(event);
          if (event.isNotEmpty) {
            setState(() {
              courseDocId = event;
              getCourseUser(event);
            });
          } else {
            // Handle the case where the event is empty.
            print('No Course');
          }
        });
      });
    });
  }

  void getCourseUser(List<String> courseId) {
    final courseStream = ExerciseService().getCourseListByListDocId(courseId);
    courseStream.listen((event) {
      setState(() {
        courseList = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [],
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     color: Colors.black,
      //     onPressed: () {
      //       context.read<SignInBloc>().add(const SignOutRequired());
      //     },
      //   ),
      // ),
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
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.white,
                                  onPressed: () {
                                    context
                                        .read<SignInBloc>()
                                        .add(const SignOutRequired());
                                  },
                                ),
                                Text(' Your course : ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(courseList.length.toString(),
                                    style: TextStyle(
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
                      )
                    : BodyAddHomeSelect()
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
          top: 170.0,
          right: 0.0,
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              backgroundColor: Palette.darkColor,
              onPressed: () {
                onTap();
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}

class CourseListWidget extends StatefulWidget {
  const CourseListWidget({super.key, required this.courseList});
  final List<CoursesModel> courseList;
  @override
  State<CourseListWidget> createState() => _CourseListWidgetState();
}

class _CourseListWidgetState extends State<CourseListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.courseList.length,
          itemBuilder: (context, index) {
            final course = widget.courseList[index];
            return SelectExerciseWidget<CoursesModel>(
              model: course,
              onTap: () {},
            );
          },
        ),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
