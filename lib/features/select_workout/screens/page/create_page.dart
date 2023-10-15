import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_dev_app/features/select_workout/bloc/select_workout_bloc.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/exercise_model.dart';
import 'package:soft_dev_app/features/select_workout/screens/widget/card_exercise_widget.dart';

import '../../../../core/theme/theme.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  late SelectWorkoutBloc selectWorkoutBloc;
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
        if (current is CreatePageState) {
          return false;
        }
        return true;
      },
      buildWhen: (previous, current) {
        if (current is CreatePageState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        // TODO: implement listener
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
                      expandedHeight: 160,
                      backgroundColor: Palette.whiteColor,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          'assets/images/temp_exercise.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        _isScrolled ? successState.course.name : '',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: _isScrolled ? Colors.black : Colors.white,
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
                              onTap: () {}, model: exercise);
                        },
                        childCount: state.exerciseList.length,
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.orangeColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    'สร้าง',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    selectWorkoutBloc.add(CreatePageClickCreateEvent(
                        course: successState.course,
                        exerciseList: successState.exerciseList,
                        username: "nakorn"));
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
