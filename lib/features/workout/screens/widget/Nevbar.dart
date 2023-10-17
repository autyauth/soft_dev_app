import 'package:flutter/material.dart';

class Nevbar extends StatelessWidget {
  const Nevbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: Container(
        color: Colors.blue, // Background color of the navbar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                // Add your home button functionality here
              },
              color: Colors.white, // Icon color
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Add your search button functionality here
              },
              color: Colors.white, // Icon color
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // Add your profile button functionality here
              },
              color: Colors.white, // Icon color
            ),
          ],
        ),
      ),
    );
  }
}
