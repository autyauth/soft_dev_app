import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/route_constants.dart';

class WorkOutHomePage extends StatefulWidget {
  const WorkOutHomePage({super.key});

  @override
  State<WorkOutHomePage> createState() => _WorkOutHomePageState();
}

class _WorkOutHomePageState extends State<WorkOutHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.pushNamed(RouteConstants.selectExercise);
          },
          child: Text('go select exercise'),
        ),
      ),
    );
  }
}
