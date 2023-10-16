import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/routing/route_constants.dart';

import '../../../select_workout/bloc/select_workout_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectWorkoutBloc selectWorkoutBloc = SelectWorkoutBloc();
    return BlocProvider(
      create: (context) => selectWorkoutBloc,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouteConstants.courseTypeRoute);
                },
                child: const Text('go workout'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('click me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
