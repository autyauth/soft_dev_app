import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/pallete.dart';
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
        // TODO: implement listener
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
                                  SelectExerciseWidget(
                                    onTap: () {},
                                    workout: workout,
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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         'Select Your Exercise',
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: Palette.whiteColor,
  //           fontSize: 30,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //       centerTitle: true,
  //       backgroundColor: Palette.greyColor,
  //     ),
  //     backgroundColor: Colors.black,
  //     body: SafeArea(
  //       child: Column(
  //         children: [
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: List.generate(
  //                   workoutList.length,
  //                   (index) {
  //                     final workout = workoutList[index];
  //                     return Column(
  //                       children: [
  //                         SelectExerciseWidget(
  //                           onTap: () {},
  //                           workout: workout,
  //                         ),
  //                         const SizedBox(
  //                           height: 20,
  //                         )
  //                       ],
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
