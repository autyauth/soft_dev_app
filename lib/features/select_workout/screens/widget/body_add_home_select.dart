import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/route_constants.dart';

class BodyAddHomeSelect extends StatelessWidget {
  const BodyAddHomeSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 250),
      const Text(
        'Do you want to add course?',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          context.pushNamed(RouteConstants.courseTypeRoute);
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(150, 50)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black; // Color when button is pressed
            }
            return Colors.orange; // Default color
          }),
        ),
        child: const Text(
          '    Add course    ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ]);
  }
}
