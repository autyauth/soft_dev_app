import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/workout/screens/page/profile_page.dart';
import 'package:soft_dev_app/features/workout/screens/page/select_excercise_page.dart';
import 'package:soft_dev_app/features/workout/screens/widget/cir_des.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int currentPage = 0;

  List<Widget> pages = const [SelectExercisePage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: [
          CircularIconNavigationDestination(
            label: "Shop",
            assetPath: "assets/icons/shop.png",
            selectedIcon: Icons.access_alarm,
          ),CircularIconNavigationDestination(
            label: "Shop",
            assetPath: "assets/icons/shop.png",
            selectedIcon: Icons.access_alarm,
          ),
          
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (int value) {
          setState(() {
            currentPage = value;
          });
        },
        backgroundColor: Palette.greyColor,
        indicatorColor: Palette.whiteColor,
        elevation: 10,
      ),
    );
  }
}
