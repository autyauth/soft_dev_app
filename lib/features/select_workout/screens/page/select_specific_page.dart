import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme.dart';
import '../../bloc/select_workout_bloc.dart';
import '../../domain/models/part_body_model.dart';
import '../widget/select_exercise_widget.dart';

class SelectSpecificPage extends StatefulWidget {
  const SelectSpecificPage({super.key, required this.partBodyList});
  final List<PartBodyModel> partBodyList;
  @override
  State<SelectSpecificPage> createState() => _SelectSpecificPageState();
}

class _SelectSpecificPageState extends State<SelectSpecificPage> {
  final SelectWorkoutBloc selectWorkoutBloc = SelectWorkoutBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (PartBodyModel partBody in widget.partBodyList) {
      print(partBody.title);
    }

    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      bloc: selectWorkoutBloc,
      listenWhen: (previous, current) => current is SelectWorkoutActionState,
      buildWhen: (previous, current) => current is! SelectWorkoutActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case SelectWorkoutLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SelectWorkoutLoadedSuccessState:
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
                            widget.partBodyList.length,
                            (index) {
                              final partbody = widget.partBodyList[index];
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
