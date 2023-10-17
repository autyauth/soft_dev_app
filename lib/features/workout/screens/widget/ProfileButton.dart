import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/ColorSet.dart';
import 'package:soft_dev_app/features/workout/screens/page/panel_right_page.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onBack() {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return PanelRightPage();
      }));
    }

    return Positioned(
      top: 70,
      right: 1,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: OutlinedButton.icon(
            label: const Text(""),
            onPressed: onBack,
            icon: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: const Icon(
                //Icons.person,
                Icons.trending_up,
                color: ColorSet.mainColor1,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(0, 255, 255, 255), // Transparent background
              ),
              shape: MaterialStateProperty.all<CircleBorder>(
                CircleBorder(),
              ),
              side: MaterialStateProperty.all(BorderSide.none), // Remove the border
            ),
          ),
        ),
      ),
    );
  }
}
