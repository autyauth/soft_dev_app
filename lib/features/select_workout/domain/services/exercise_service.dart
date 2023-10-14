import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/exercise_model.dart';

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

  Stream<List<ExerciseModel>> getExerciseByDocIdList(List<String> docIdList) {
    return FirebaseFirestore.instance
        .collection('exercise')
        .where(FieldPath.documentId, whereIn: docIdList)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ExerciseModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<ExerciseModel>> getExerciseListByUserLevel(int level) {
    return FirebaseFirestore.instance
        .collection('exercise')
        .where('level', isEqualTo: level)
        .orderBy('level', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ExerciseModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<ExerciseModel>> getExerciseListByUserLevelAndPriority(
      int level, int priority) {
    return FirebaseFirestore.instance
        .collection('exercise')
        .where('level', isEqualTo: level)
        .where('priority', isEqualTo: priority)
        .orderBy('level', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ExerciseModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<ExerciseMedia>> getExerciseMediaByDocId(List<String> docId) {
    return FirebaseFirestore.instance
        .collection('exerciseMedia')
        .where(FieldPath.documentId, whereIn: docId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ExerciseMedia.fromJson(doc.data());
      }).toList();
    });
  }
}
