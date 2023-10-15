import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_dev_app/blocs/authentication_bloc/authentication_bloc_bloc.dart';
import 'package:soft_dev_app/blocs/sign_in_bloc/sign_in_bloc_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'features/select_workout/bloc/select_workout_bloc.dart';
import 'routing/route.dart';

class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp(this.userRepository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
              userRepository: userRepository,
            ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SelectWorkoutBloc>(
                create: (context) => SelectWorkoutBloc()),
            BlocProvider(
              create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
            )
          ],
          child: MaterialApp.router(
            routerConfig: RouteConfig().router,
          ),
        ));
  }
}
