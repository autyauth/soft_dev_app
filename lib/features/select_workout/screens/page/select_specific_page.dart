import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../bloc/select_workout_bloc.dart';
import '../../domain/models/part_body_model.dart';
import '../widget/select_exercise_widget.dart';

class SelectSpecificPage extends StatefulWidget {
  const SelectSpecificPage({super.key});

  @override
  State<SelectSpecificPage> createState() => _SelectSpecificPageState();
}

class _SelectSpecificPageState extends State<SelectSpecificPage> {
  late SelectWorkoutBloc selectWorkoutBloc;
  @override
  void initState() {
    super.initState();
    selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      listenWhen: (previous, current) => current is SelectWorkoutActionState,
      buildWhen: (previous, current) => current is! SelectWorkoutActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case SelectSpecificLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SelectSpecificLoadedSuccessState:
            final successState = state as SelectSpecificLoadedSuccessState;
            // print(successState.partList.length);
            //print(successState.partList[0].title);
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Specific',
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
                            successState.partList.length,
                            (index) {
                              final partbody = successState.partList[index];
                              return Column(
                                children: [
                                  SelectExerciseWidget<PartBodyModel>(
                                    onTap: () {},
                                    model: partbody,
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
          // case SelectWorkoutLoadedFailureState:
          //   return const Scaffold(
          //     body: Center(
          //       child: Text('Error'),
          //     ),
          //   );
          default:
            print('Debugging message: State is $state');

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
