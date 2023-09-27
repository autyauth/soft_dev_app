import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soft_dev_app/routing/route_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.pushNamed(RouteConstants.workout);
              },
              child: Text('go workout'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('click me'),
            ),
          ],
        ),
      ),
    );
  }
}
