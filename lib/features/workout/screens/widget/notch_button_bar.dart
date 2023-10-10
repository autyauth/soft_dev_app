import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/workout/screens/page/profile_page.dart';
import 'package:soft_dev_app/features/workout/screens/page/select_excercise_page.dart';

class AnimatedNavbar extends StatefulWidget {
  const AnimatedNavbar({super.key});

  @override
  State<AnimatedNavbar> createState() => _AnimatedNavbarState();
}

class _AnimatedNavbarState extends State<AnimatedNavbar>
    with TickerProviderStateMixin {
  double horizontalPadding = 50.0;
  double horizontalMargin = 20.0;
  late double position;
  int noOfIcons = 3;
  int selected = 0;
  List<Widget> pages = const [SelectExercisePage(), ProfilePage()];

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
        vsync: this, duration: const Duration(milliseconds: 375));
  }

  @override
  void didChangeDependencies() {
    animation = Tween(begin: getEndPostion(0), end: getEndPostion(2)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    position = getEndPostion(0);

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
            bottom: horizontalMargin,
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
                                padding: const EdgeInsets.only(
                                    bottom: 17.5, top: 22.5),
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
                                              color: Colors.white,
                                              key: ValueKey('yellow$icon'),
                                            )
                                          : Image.asset(icon,
                                              width: 30.0,
                                              color: Colors.white,
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
  double start = 40.0;
  double end = 120.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    var path = Path();
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

    path.lineTo(size.width - 20.0, start);

    path.quadraticBezierTo(size.width, start, size.width, start + 25.0);
    path.lineTo(size.width, end - 25.0);
    path.quadraticBezierTo(size.width, end, size.width - 25.0, end);
    path.lineTo(25.0, end);
    path.quadraticBezierTo(0.0, end, 0.0, end - 25.0);
    path.lineTo(0.0, start + 25.0);
    path.quadraticBezierTo(0.0, start, 20.0, start);
    path.close();

    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(70.0 + x, 50.0), 35.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
