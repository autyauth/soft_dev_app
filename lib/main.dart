// import 'core/theme/theme.dart';
// import 'routing/route.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<SelectWorkoutBloc>(
//             create: (context) => SelectWorkoutBloc()),
//       ],
//       child: MaterialApp.router(
//         title: 'Flutter Demo',
//         theme: AppTheme.lightTheme,
//         debugShowCheckedModeBanner: false,
//         routerConfig: RouteConfig().router,
//       ),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_dev_app/firebase_options.dart';

import 'core/theme/theme.dart';
import 'features/select_workout/bloc/select_workout_bloc.dart';
import 'routing/route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SelectWorkoutBloc>(
              create: (context) => SelectWorkoutBloc())
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: RouteConfig().router,
        ));
  }
}
