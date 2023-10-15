import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../blocs/sign_in_bloc/sign_in_bloc_bloc.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.read<SignInBloc>().add(const SignOutRequired());
            ;
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.pushNamed(RouteConstants.courseTypeRoute);
          },
          child: Text('go select exercise'),
        ),
      ),
    );
  }
}
