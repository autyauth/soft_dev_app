import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/workout/screens/page/profile_page.dart';
import 'package:soft_dev_app/features/workout/screens/page/select_excercise_page.dart';

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
        destinations:  [
          NavigationDestination(icon: SizedBox(height: 25,child: Image.asset("assets/icons/dumble.png"),) , label: 'Workout'),
          NavigationDestination(icon: SizedBox(height: 25,child: Image.asset("assets/icons/shop.png"),), label: 'Shop'),
          NavigationDestination(icon: SizedBox(height: 25,child: Image.asset("assets/icons/home.png"),), label: 'Home'),
          NavigationDestination(icon: SizedBox(height: 25,child: Image.asset("assets/icons/medal.png"),), label: 'Leader board'),
          NavigationDestination(icon: SizedBox(height: 25,child: Image.asset("assets/icons/person.png"),), label: 'Profile'),
        ],
        selectedIndex: currentPage,
        onDestinationSelected: (int value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
    );
  }
}
