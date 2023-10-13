import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/courses_model.dart';

class ExerciseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final User _user = FirebaseAuth.instance.currentUser!;

  final CollectionReference _exerciseCollection =
      FirebaseFirestore.instance.collection('exercise');
  final CollectionReference _courseCollection =
      FirebaseFirestore.instance.collection('course');

  Stream<QuerySnapshot> getExercise() {
    return _exerciseCollection.snapshots();
  }

  Stream<QuerySnapshot> getCourse() {
    return _courseCollection.snapshots();
  }

  Stream<List<CoursesModel>> getCourseList() {
    // Assuming your Firestore collection is named 'courses'.
    return FirebaseFirestore.instance
        .collection('course')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CoursesModel.fromJson(doc.data());
      }).toList();
    });
  }
}
