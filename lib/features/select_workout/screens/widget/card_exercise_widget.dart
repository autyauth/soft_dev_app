import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/exercise_model.dart';

class CardExerciseWidget<T> extends StatelessWidget {
  const CardExerciseWidget(
      {super.key, required this.onTap, required this.model});
  final Function onTap;
  final T model;

  String timeOrAmout(int time, int amout) {
    String result = "";
    if (time != 0) {
      result = "${(time / 60).floor()}:${time % 60} นาที";
    } else {
      result = "x$amout ครั้ง";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 228, 226, 226),
              width: 2.0,
            ),
          ),
        ),
        height: 110,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  // height: 100,
                  width: 60,
                  child: Icon(Icons.unfold_more_double),
                ),
                SizedBox(
                  //alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Lottie.network(
                    (((model as ExerciseModel).media)?[0] as ExerciseMedia)
                        .animation,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (model as ExerciseModel).name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        timeOrAmout((model as ExerciseModel).time,
                            (model as ExerciseModel).amout),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
