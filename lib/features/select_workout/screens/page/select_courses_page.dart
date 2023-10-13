import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/courses_model.dart';

import '../../../../core/theme/theme.dart';
import '../../bloc/select_workout_bloc.dart';
import '../widget/select_exercise_widget.dart';

class SelectCoursesPage extends StatefulWidget {
  const SelectCoursesPage({super.key});

  @override
  State<SelectCoursesPage> createState() => _SelectCoursesPageState();
}

class _SelectCoursesPageState extends State<SelectCoursesPage> {
  late SelectWorkoutBloc selectWorkoutBloc;
  @override
  void initState() {
    super.initState();
    selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
      bloc: selectWorkoutBloc,
      listenWhen: (previous, current) => current is SelectCoursesActionState,
      buildWhen: (previous, current) => current is SelectCoursesState,
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        switch (state.runtimeType) {
          case SelectCourseLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case SelectCourseLoadedState:
            // print(successState.partList.length);
            //print(successState.partList[0].title);
            final successState = state as SelectCourseLoadedState;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    return Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  successState.courseTypeName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Palette.whiteColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Palette.greyColor,
              ),
              backgroundColor: Palette.backgroundColor,
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            successState.courses.length,
                            (index) {
                              final course = successState.courses[index];
                              return Column(
                                children: [
                                  SelectExerciseWidget<CoursesModel>(
                                    model: course,
                                    onTap: () {},
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          default:
            print('Debugging message: State is $state');

            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../core/theme/theme.dart';
// import '../../../../routing/route_constants.dart';
// import '../../bloc/select_workout_bloc.dart';
// import '../../domain/models/sub_courses_model.dart';
// import '../widget/select_exercise_widget.dart';

// class SelectSpecificPage extends StatefulWidget {
//   const SelectSpecificPage({super.key});

//   @override
//   State<SelectSpecificPage> createState() => _SelectSpecificPageState();
// }

// class _SelectSpecificPageState extends State<SelectSpecificPage> {
//   late SelectWorkoutBloc selectWorkoutBloc;
//   @override
//   void initState() {
//     super.initState();
//     selectWorkoutBloc = BlocProvider.of<SelectWorkoutBloc>(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SelectWorkoutBloc, SelectWorkoutState>(
//       bloc: selectWorkoutBloc,
//       listenWhen: (previous, current) => current is SelectWorkoutActionState,
//       buildWhen: (previous, current) => current is! SelectWorkoutActionState,
//       listener: (context, state) {
//         if (state is SelectSpecificNavigateToDetailWorkoutPageState) {
//           selectWorkoutBloc.add(
//             DetailExerciseInitialEvent(exerciseList: state.exerciseList),
//           );
//           context.pushNamed(RouteConstants.detailWorkout);
//         }
//       },
//       builder: (context, state) {
//         switch (state.runtimeType) {
//           case SelectSpecificLoadingState:
//             return const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           case SelectSpecificLoadedSuccessState:
//             final successState = state as SelectSpecificLoadedSuccessState;
//             // print(successState.partList.length);
//             //print(successState.partList[0].title);
//             return Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//                 title: const Text(
//                   'Specific',
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
//               backgroundColor: Colors.black,
//               body: SafeArea(
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: List.generate(
//                             successState.partList.length,
//                             (index) {
//                               final partbody = successState.partList[index];
//                               return Column(
//                                 children: [
//                                   SelectExerciseWidget<SubCoursesModel>(
//                                     onTap: () {
//                                       selectWorkoutBloc.add(
//                                           SelectSpecificClickPartEvent(
//                                               part: partbody));
//                                     },
//                                     model: partbody,
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   )
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           // case SelectWorkoutLoadedFailureState:
//           //   return const Scaffold(
//           //     body: Center(
//           //       child: Text('Error'),
//           //     ),
//           //   );
//           default:
//             print('Debugging message: State is $state');

//             return const Scaffold(
//               body: Center(
//                 child: Text('Error'),
//               ),
//             );
//         }
//       },
//     );
//   }
// }
