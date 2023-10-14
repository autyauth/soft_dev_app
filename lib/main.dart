import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/theme.dart';
import 'package:soft_dev_app/features/workout/screens/widget/notch_button_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Palette.orangeCreamColor),
      home: AnimatedNavbar(),
    );
  }
}
