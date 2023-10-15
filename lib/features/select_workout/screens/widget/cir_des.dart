import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';

class CircularIconNavigationDestination extends StatelessWidget {
  final String label;
  final String assetPath;
  final IconData selectedIcon;

  CircularIconNavigationDestination({
    required this.label,
    required this.assetPath,
    required this.selectedIcon,

  });

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
              icon: SizedBox(
                height: 25,
                child: Image.asset(assetPath),
              ),
              selectedIcon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.orangeColor,
                ),
                child:  Center(
                    child: Image.asset(assetPath,color: Colors.black,height: 50),
                ),
              ),
              label: 'Workout');
  }
}
