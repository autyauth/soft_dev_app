import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_dev_app/blocs/authentication_bloc/authentication_bloc_bloc.dart';
import 'package:soft_dev_app/blocs/sign_in_bloc/sign_in_bloc_bloc.dart';

import 'screens/auth/welcome_screen.dart';
import 'screens/home/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise LogReBloc',
			theme: ThemeData(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
				builder: (context, state) {
					if(state.status == AuthenticationBlocStatus.authenticated) {

						return BlocProvider(
							create: (context) => SignInBloc(
								userRepository: context.read<AuthenticationBloc>().userRepository
							),
							child: const HomeScreen(),
						);
					} else {
          
						return const WelcomeScreen();
					}
				}
			)
    );
  }
}