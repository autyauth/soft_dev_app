import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/workout/screens/widget/back.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/profile_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        child: const Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 85,
              child: ImgBackButton(),
            )
          ],
        ),
      ),
    );
  }
}
