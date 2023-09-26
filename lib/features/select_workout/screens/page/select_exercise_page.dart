import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

//import 'package:soft_dev_app/features/select_workout/domain/models/part_body_model.dart';

import '../../../../core/theme/pallete.dart';
import '../../../../routing/route_constants.dart';
import '../../bloc/select_workout_bloc.dart';
import '../../domain/models/workout_list_model.dart';
import '../widget/select_exercise_widget.dart';

class SelectExercisePage extends StatefulWidget {
  const SelectExercisePage({super.key});

  @override
  State<SelectExercisePage> createState() => _SelectExercisePageState();
}

class _SelectExercisePageState extends State<SelectExercisePage> {
  final SelectWorkoutBloc selectWorkoutBloc = SelectWorkoutBloc();
  List<WorkoutListModel> workoutList = [];
  @override
  void initState() {
    selectWorkoutBloc.add(SelectWorkoutInitialEvent());
    //loadWorkout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      bloc: selectWorkoutBloc,
      listenWhen: (previous, current) => current is SelectWorkoutActionState,
      buildWhen: (previous, current) => current is! SelectWorkoutActionState,
      listener: (context, state) {
        if (state is SelectWorkoutNavigateToSelectSpecificPageState) {
          context.pushNamed(RouteConstants.specificPage,
              extra: state.partBodyList);
        }
      },
      builder: (context, state) {
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
                                  SelectExerciseWidget<WorkoutListModel>(
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
