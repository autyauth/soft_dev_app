import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:soft_dev_app/core/theme/pallete.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../bloc/select_workout_bloc.dart';

class DetailExercise extends StatefulWidget {
  const DetailExercise({Key? key}) : super(key: key);

  @override
  State<DetailExercise> createState() => _DetailExerciseState();
}

class _DetailExerciseState extends State<DetailExercise>
    with TickerProviderStateMixin {
  late TabController tabController;
  late SelectWorkoutBloc selectWorkoutBloc;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void setYoutube(String url) {
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      bloc: selectWorkoutBloc,
      listenWhen: (previous, current) {
        if (current is DetailPageActionState) {
          return true;
        } else if (current is DetailPageState) {
          return false;
        }
        return false;
      },
      buildWhen: (previous, current) {
        if (current is DetailPageState) {
          return true;
        } else if (current is DetailPageActionState) {
          return false;
        }
        return false;
      },
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        print(state);
        switch (state.runtimeType) {
          case CardDetailLoading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case CardDetailInitial:
            final succesState = state as CardDetailInitial;
            List<String> partFocusList = [];
            for (String part in succesState.exercise.partFocus) {
              partFocusList.add(part);
            }
            setYoutube(succesState.exercise.media![0].video);
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              body: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 1.1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: TabBar(
                                  controller: tabController,
                                  unselectedLabelColor: Colors.black,
                                  labelColor: Colors.black,
                                  tabs: const [
                                    Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Text(
                                        'Animation',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(13.0),
                                      child: Text(
                                        'Video',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    // Content "Animation" tab
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 20),
                                        color: Palette.whiteColor,
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            Lottie.network(
                                              succesState.exercise.media![0]
                                                  .animation, // Replace image
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    succesState.exercise.name,
                                                    style: const TextStyle(
                                                      fontSize: 28,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    succesState
                                                        .exercise.description,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'กล้ามเนื้อที่เน้น',
                                                    style: TextStyle(
                                                      fontSize: 28,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Image.network(
                                              succesState.exercise.media![0]
                                                  .image, // Replace image
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: List.generate(
                                                  partFocusList.length,
                                                  (index) {
                                                    return Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    180,
                                                                    155),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              partFocusList[
                                                                  index],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Content "Video" tab
                                    SingleChildScrollView(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 20),
                                        color: Palette.whiteColor,
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.center,
                                          children: [
                                            YoutubePlayer(
                                              controller: _youtubeController,
                                              showVideoProgressIndicator: true,
                                              progressIndicatorColor:
                                                  Colors.amber,
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    succesState.exercise.name,
                                                    style: const TextStyle(
                                                      fontSize: 28,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    succesState
                                                        .exercise.description,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                    'กล้ามเนื้อที่เน้น',
                                                    style: TextStyle(
                                                      fontSize: 28,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Image.network(
                                              succesState.exercise.media![0]
                                                  .image, // Replace image
                                              width: 200,
                                              height: 200,
                                              fit: BoxFit.cover,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: Row(
                                                children: List.generate(
                                                  partFocusList.length,
                                                  (index) {
                                                    return Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    180,
                                                                    155),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              partFocusList[
                                                                  index],
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text('Error2'),
              ),
            );
        }
      },
    );
  }
}
