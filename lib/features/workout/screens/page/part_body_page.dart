// import 'package:flutter/material.dart';
// import 'package:soft_dev_app/core/theme/pallete.dart';

// class PartBodyPage extends StatefulWidget {
//   const PartBodyPage({
//     super.key,
//   });

//   @override
//   State<PartBodyPage> createState() => _PartBodyState();
// }

// class _PartBodyState extends State<PartBodyPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Specific',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Palette.whiteColor,
//             fontSize: 30,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Palette.greyColor,
//       ),
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: List.generate(
//                     listWorkout.length,
//                     (index) {
//                       final workout = listWorkout[index];
//                       return Column(
//                         children: [
//                           SelectExerciseWidget(
//                             onTap: () {},
//                             workout: workout,
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           )
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
