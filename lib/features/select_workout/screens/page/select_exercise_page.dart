import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

//import 'package:soft_dev_app/features/select_workout/domain/models/part_body_model.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../routing/route_constants.dart';
import '../../bloc/select_workout_bloc.dart';
import '../../domain/models/courses_model.dart';
import '../widget/select_exercise_widget.dart';

class SelectExercisePage extends StatefulWidget {
  const SelectExercisePage({super.key});

  @override
  State<SelectExercisePage> createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> {
  //final SelectWorkoutBloc selectWorkoutBloc = SelectWorkoutBloc();
  late SelectWorkoutBloc selectWorkoutBloc;
  List<CoursesModel> workoutList = [];
  @override
  void initState() {
    super.initState();
    selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
    selectWorkoutBloc.add(SelectWorkoutInitialEvent());
    print(selectWorkoutBloc.state.toString());
    //loadWorkout();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      bloc: selectWorkoutBloc,
      listenWhen: (previous, current) => current is SelectWorkoutActionState,
      buildWhen: (previous, current) => current is! SelectWorkoutActionState,
      listener: (context, state) {
        if (state is SelectWorkoutNavigateToSelectSpecificPageState) {
          print(state.partBodyList.length);
          selectWorkoutBloc.add(
            SelectSpecificInitialEvent(
              partList: state.partBodyList,
            ),
          );
          context.pushNamed(RouteConstants.specificPage);
          //print(selectWorkoutBloc.state.toString());
        }
      },
      builder: (context, state) {
        //print('Debugging message:' + state.toString());

        switch (state.runtimeType) {
          case SelectWorkoutLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SelectWorkoutLoadedSuccessState:
            final successState = state as SelectWorkoutLoadedSuccessState;
            workoutList = successState.workoutList;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Select Your Exercise',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Palette.whiteColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Palette.greyColor,
              ),
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            workoutList.length,
                            (index) {
                              final workout = workoutList[index];
                              return Column(
                                children: [
                                  SelectExerciseWidget<CoursesModel>(
                                    onTap: () {
                                      selectWorkoutBloc.add(
                                        SelectWorkoutClickWorkoutEvent(
                                          workout: workout,
                                        ),
                                      );
                                    },
                                    model: workout,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          case SelectWorkoutLoadedFailureState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
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
