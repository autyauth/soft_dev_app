import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'routing/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: RouteConfig().router,
    );
  }
}
