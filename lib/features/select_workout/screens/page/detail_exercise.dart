// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/theme/theme.dart';
// import '../../bloc/select_workout_bloc.dart';

// class DetialWorkoutPage extends StatefulWidget {
//   const DetialWorkoutPage({super.key});

//   @override
//   State<DetialWorkoutPage> createState() => _DetialWorkoutPageState();
// }

// class _DetialWorkoutPageState extends State<DetialWorkoutPage> {
//   late SelectWorkoutBloc selectWorkoutBloc;
//   @override
//   void initState() {
//     super.initState();
//     selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(selectWorkoutBloc.state.toString());
//     return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
//       bloc: selectWorkoutBloc,
//       listenWhen: (previous, current) => current is SelectWorkoutActionState,
//       buildWhen: (previous, current) => current is! SelectWorkoutActionState,
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         switch (state.runtimeType) {
//           case DetailExerciseLoadingState:
//             return const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           case DetailExerciseLoadedSuccessState:
//             final success = state as DetailExerciseLoadedSuccessState;
//             return Scaffold(
//               body: SafeArea(
//                 child: CustomScrollView(
//                   slivers: <Widget>[
//                     SliverAppBar(
//                       pinned: true,
//                       expandedHeight: 160,
//                       backgroundColor: Palette.whiteColor,
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: Image.asset(
//                           'assets/images/temp_exercise.jpg',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       leading: IconButton(
//                         icon: const Icon(Icons.arrow_back, color: Colors.white),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                     ),
//                     SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                           (BuildContext context, int index) {
//                         return Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: const Color.fromARGB(255, 228, 226, 226),
//                                 width: 2.0,
//                               ),
//                             ),
//                           ),
//                           height: 110,
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     // height: 100,
//                                     width: 60,
//                                     child: Icon(Icons.unfold_more_double),
//                                   ),
//                                   Container(
//                                     //alignment: Alignment.center,
//                                     height: 100,
//                                     width: 100,
//                                     child: Image.asset(
//                                       success.exerciseList[index].image,
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           success.exerciseList[index].name,
//                                           style: TextStyle(
//                                               fontSize: 20,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         Text(
//                                           "X" +
//                                               success.exerciseList[index].amout
//                                                   .toString(),
//                                           style: TextStyle(fontSize: 15),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       }, childCount: success.exerciseList.length),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           default:
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text(
//                   'Select Your Exercise',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Palette.whiteColor,
//                     fontSize: 30,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 centerTitle: true,
//                 backgroundColor: Palette.greyColor,
//               ),
//               body: Center(
//                 child: Text('Error'),
//               ),
//             );
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class DetailExercise extends StatefulWidget {
  const DetailExercise({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DetailExercise> createState() => _DetailExerciseState();
}

class _DetailExerciseState extends State<DetailExercise>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            Container(
                              color: Colors.blue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://example.com/your-image-url.jpg', // Replace image
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 20),
                                  const Text(
                                    'Animated Image',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(height: 20),
                                  const Text(
                                    'Description of the animation goes here.',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Image.network(
                                    'https://example.com/another-image-url.jpg', // Replace image
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                            // Content "Video" tab
                            Container(
                              color: Colors.red,
                              child: const Center(
                                child: Text(
                                  'Video Content',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
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
  }
}
