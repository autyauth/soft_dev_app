// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:soft_dev_app/blocs/authentication_bloc/authentication_bloc_bloc.dart';
// import 'package:soft_dev_app/screens/auth/welcome_screen.dart';

// import 'blocs/sign_in_bloc/sign_in_bloc_bloc.dart';
// import 'features/select_workout/bloc/select_workout_bloc.dart';
// import 'screens/home/home_screen.dart';

// class MyAppView extends StatelessWidget {
//   const MyAppView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Exercise LogReBloc',
//         theme: ThemeData(),
//         home: BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
//             builder: (context, state) {
//           if (state.status == AuthenticationBlocStatus.authenticated) {
//             return MultiBlocProvider(
//               // create: (context) => SignInBloc(
//               // 	userRepository: context.read<AuthenticationBloc>().userRepository
//               // ),
//               providers: [
//                 BlocProvider<SelectWorkoutBloc>(
//                     create: (context) => SelectWorkoutBloc()),
//                 BlocProvider(
//                   create: (context) => SignInBloc(
//                       userRepository:
//                           context.read<AuthenticationBloc>().userRepository),
//                 )
//               ],
//               child: const HomeScreen(),
//             );
//           } else {
//             return const WelcomeScreen();
//           }
//         }));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_dev_app/blocs/authentication_bloc/authentication_bloc_bloc.dart';
import 'package:soft_dev_app/screens/auth/welcome_screen.dart';

import 'features/select_workout/bloc/select_workout_bloc.dart';
import 'features/select_workout/screens/widget/notch_button_bar.dart';
import 'routing/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectWorkoutBloc>(
          create: (context) => SelectWorkoutBloc(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: RouteConfig().router.routeInformationParser,
        routerDelegate: RouteConfig().router.routerDelegate,
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Exercise LogReBloc',
        theme: ThemeData(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationBlocState>(
            builder: (context, state) {
          if (state.status == AuthenticationBlocStatus.authenticated) {
            return const AnimatedNavbar();
          } else {
            return const WelcomeScreen();
          }
        }));
  }
}
