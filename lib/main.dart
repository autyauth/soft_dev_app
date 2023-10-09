import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/theme.dart';
import 'package:soft_dev_app/features/workout/screens/page/select_excercise_page.dart';
import 'package:soft_dev_app/features/workout/screens/widget/widget_tree.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Palette.orangeCreamColor),
      home: WidgetTree(),
    );
  }
}
