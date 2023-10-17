import 'package:flutter/material.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:soft_dev_app/features/select_workout/screens/page/home_select.dart';
import 'package:soft_dev_app/features/workout/screens/page/Home_sceen.dart';
import 'package:soft_dev_app/features/workout/screens/page/profile_page.dart';

class AnimatedNavbar extends StatefulWidget {
  const AnimatedNavbar({super.key});

  @override
  State<AnimatedNavbar> createState() => _AnimatedNavbarState();
}

class _AnimatedNavbarState extends State<AnimatedNavbar>
    with TickerProviderStateMixin {
  double horizontalPadding = 50.0;
  double horizontalMargin = 0.0;
  late double position;
  int noOfIcons = 3;
  int selected = 0;
  List<Widget> pages = [
    const MyHomeScreen(),
    const HomeSelect(),
    const ProfilePage()
  ];

  List<String> icons = [
    'assets/icons/home.png',
    'assets/icons/medal.png',
    'assets/icons/dumble.png',
  ];

  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
  }

  @override
  void didChangeDependencies() {
    animation =
        Tween(begin: getEndPostion(selected), end: getEndPostion(selected))
            .animate(
                CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    position = getEndPostion(0);
    Future.delayed(const Duration(microseconds: 0), () {
      controller.forward();
    });

    super.didChangeDependencies();
  }

  double getEndPostion(int index) {
    double totalMargin = 2 * horizontalMargin;
    double totalPadding = 2 * horizontalPadding;
    double valueToOmit = totalMargin + totalPadding;

    return (MediaQuery.of(context).size.width - valueToOmit) /
            noOfIcons *
            index +
        horizontalPadding +
        (((MediaQuery.of(context).size.width - valueToOmit) / noOfIcons) / 2) -
        70;
  }

  void animateDrop(int index) {
    animation = Tween(begin: position, end: getEndPostion(index)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    controller.forward().then((value) {
      position = getEndPostion(index);
      controller.dispose();
      controller = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 375));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: pages[selected]),
          Positioned(
            bottom: 10,
            left: horizontalMargin,
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return CustomPaint(
                    painter: AppbarPainter(animation.value),
                    size: Size(
                        MediaQuery.of(context).size.width -
                            (2 * horizontalMargin),
                        80),
                    child: SizedBox(
                      height: 120.0,
                      width: MediaQuery.of(context).size.width -
                          (2 * horizontalMargin),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Row(
                          children: icons.map<Widget>((icon) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = icons.indexOf(icon);
                                  animateDrop(icons.indexOf(icon));
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 575,
                                ),
                                curve: Curves.easeOut,
                                height: 105.0,
                                width: (MediaQuery.of(context).size.width -
                                        (2 * horizontalMargin) -
                                        (2 * horizontalPadding)) /
                                    noOfIcons,
                                padding:
                                    const EdgeInsets.only(bottom: 0, top: 40),
                                alignment: selected == icons.indexOf(icon)
                                    ? Alignment.topCenter
                                    : Alignment.bottomCenter,
                                child: SizedBox(
                                  height: 35.0,
                                  width: 35.0,
                                  child: Center(
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 375),
                                      switchInCurve: Curves.easeOut,
                                      child: selected == icons.indexOf(icon)
                                          ? Image.asset(
                                              icon,
                                              width: 30.0,
                                              color: Palette.whiteColor,
                                              key: ValueKey('yellow$icon'),
                                            )
                                          : Image.asset(icon,
                                              width: 30.0,
                                              color: Palette.backgroundColor,
                                              key: ValueKey('white$icon')),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class AppbarPainter extends CustomPainter {
  double x;

  AppbarPainter(this.x);

  double height = 80.0;
  double start = 60.0;
  double end = 140.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Palette.greyColor
      ..style = PaintingStyle.fill;
    var paint2 = Paint()
      ..color = Palette.orangeColor
      ..style = PaintingStyle.fill;
    var paint3 = Paint()
      ..color = Palette.backgroundColor
      ..style = PaintingStyle.fill;
    var path = Path();
    var path2 = Path();
    path2.moveTo(0.0, start);

    path2.lineTo((x) < 20.0 ? 20.0 : x, start);
    path2.lineTo(size.width, start);
    path2.lineTo(size.width, end);
    path2.lineTo(0, end);
    path2.lineTo(0.0, start);
    path2.close();
    canvas.drawPath(path2, paint3);
    path.moveTo(0.0, start);

    path.lineTo((x) < 20.0 ? 20.0 : x, start);
    path.quadraticBezierTo(20.0 + x, start, 30.0 + x, start + 30.0);
    path.quadraticBezierTo(40.0 + x, start + 55.0, 70.0 + x, start + 55.0);
    path.quadraticBezierTo(100.0 + x, start + 55.0, 110.0 + x, start + 30.0);
    path.quadraticBezierTo(
        120.0 + x,
        start,
        (140.0 + x) > (size.width - 20.0) ? (size.width - 20.0) : 140.0 + x,
        start);

    path.lineTo(size.width, start);

    path.lineTo(size.width, end);
    path.lineTo(0, end);
    path.lineTo(0.0, start);
    path.close();

    canvas.drawPath(path, paint1);

    canvas.drawCircle(Offset(70.0 + x, 70.0), 35.0, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
