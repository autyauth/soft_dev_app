import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/features/select_workout/bloc/select_workout_bloc.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/exercise_model.dart';
import 'package:soft_dev_app/features/select_workout/screens/widget/card_exercise_widget.dart';
import 'package:soft_dev_app/routing/route_constants.dart';

import '../../../../core/theme/theme.dart';
import '../../domain/services/exercise_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  late SelectWorkoutBloc selectWorkoutBloc;
  String username = "";

  @override
  void initState() {
    selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 70 && !_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      } else if (_scrollController.offset <= 0 && _isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }
    });
    final User? currentUser = FirebaseAuth.instance.currentUser;

    ExerciseService().getUsername(currentUser!.uid).listen((event) {
      setState(() {
        username = event;
        print(currentUser.uid);
        print(username);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      bloc: selectWorkoutBloc,
      listenWhen: (previous, current) {
        if (current is CreatePageActionState) {
          return true;
        }
        if (current is DetailPageActionState) {
          return true;
        } else if (current is DetailPageState) {
          return true;
        }
        if (current is CreatePageState) {
          return false;
        }

        return false;
      },
      buildWhen: (previous, current) {
        if (current is DetailPageActionState) {
          return false;
        } else if (current is DetailPageState) {
          return false;
        }
        if (current is CreatePageActionState) {
          return false;
        }
        if (current is CreatePageState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        // TODO: implement listener
        if (state is CreatePageNavigateToHome) {
          context.pop();
          context.pop();
          context.pop();
        } else if (state is CreatePageNavigateToCardDetail) {
          selectWorkoutBloc
              .add(CardDetailInitialEvent(exercise: state.exercise));
          context.pushNamed(RouteConstants.detailExercise);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CreatePageLoading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case CreatePageInitial:
            final successState = state as CreatePageInitial;
            for (ExerciseModel exercise in state.exerciseList) {
              print(exercise.name);
            }

            return Scaffold(
              body: SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 170,
                      backgroundColor: Palette.whiteColor,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          'assets/images/temp_exercise.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Column(
                        children: [
                          Text(
                            _isScrolled
                                ? successState.course.name
                                : successState.course.name,
                            style: TextStyle(
                                color: _isScrolled
                                    ? Colors.black
                                    : Palette.orangeColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${(successState.time / 60).floor()} : "
                            "${successState.time % 60} นาที",
                            style: TextStyle(
                                color: _isScrolled
                                    ? Colors.black
                                    : Palette.orangeColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      leading: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color:
                              _isScrolled ? Colors.black : Palette.whiteColor,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final exercise = successState.exerciseList[index];
                          return CardExerciseWidget(
                              onTap: () {
                                selectWorkoutBloc.add(
                                    CreatePageClickCardDetailEvent(
                                        exercise: exercise));
                              },
                              model: exercise);
                        },
                        childCount: state.exerciseList.length,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.orangeColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: const Text(
                    'สร้าง',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    selectWorkoutBloc.add(CreatePageClickCreateEvent(
                        course: successState.course,
                        exerciseList: successState.exerciseList,
                        username: username));
                  },
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
        }
      },
    );
  }
}
