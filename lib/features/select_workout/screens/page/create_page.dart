import 'package:flutter/material.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/exercise_model.dart';
import 'package:soft_dev_app/features/select_workout/screens/widget/card_exercise_widget.dart';

import '../../../../core/theme/theme.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late ScrollController _scrollController;
  bool _isScrolled = false;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 70 && !_isScrolled) {
        setState(() {
          _isScrolled = true;
        });
      } else if (_scrollController.offset <= 0 && _isScrolled) {
        setState(() {
          _isScrolled = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 160,
              backgroundColor: Palette.whiteColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/images/temp_exercise.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                _isScrolled ? 'ท่าวิดพื้น' : '',
                style: TextStyle(color: Colors.black),
              ),
              leading: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: _isScrolled ? Colors.black : Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final exercise = [
                    ExerciseModel(
                      name: 'ท่าวิดพื้น',
                      description: '',
                      mediaDocId: [],
                      amout: 0,
                      time: 100,
                      level: 0,
                      partFocus: [],
                      priority: 0,
                    ),
                    ExerciseModel(
                      name: 'ท่าวิดพื้น2',
                      description: '',
                      mediaDocId: [],
                      amout: 20,
                      time: 0,
                      level: 0,
                      partFocus: [],
                      priority: 0,
                    ),
                  ];
                  exercise[0].setMedia([
                    ExerciseMedia(
                        image: '',
                        video: '',
                        animation: 'assets/images/ChestStretch_lottie.json')
                  ]);
                  exercise[1].setMedia([
                    ExerciseMedia(
                        image: '',
                        video: '',
                        animation: 'assets/images/Lunge_1.mp4.lottie.json')
                  ]);

                  ExerciseModel exerciseModel = exercise[index];

                  return CardExerciseWidget(onTap: () {}, model: exerciseModel);
                },
                childCount: 2,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Palette.orangeColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: Text(
            'เริ่ม',
            style: TextStyle(fontSize: 25),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
