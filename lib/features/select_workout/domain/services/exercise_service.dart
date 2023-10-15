import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/exercise_model.dart';
import 'package:soft_dev_app/features/select_workout/domain/models/user_course_model.dart';

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
        .where('isGlobal', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return CoursesModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<CoursesModel>> getCourseCustom() {
    // Assuming your Firestore collection is named 'courses'.
    return FirebaseFirestore.instance
        .collection('course')
        .where('isGlobal', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) {
            return CoursesModel.fromJson(doc.data());
          })
          .where((course) => course.type.any((type) => type.name == "Custom"))
          .toList();
    });
  }

  Stream<List<ExerciseModel>> getExerciseList() {
    return FirebaseFirestore.instance.collection('exercise').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => ExerciseModel.fromJson(doc.data()))
            .toList());
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

  Stream<List<ExerciseMedia>> getExerciseMediaByDocIdList(
      List<String> docIdList) {
    return FirebaseFirestore.instance
        .collection('exerciseMedia')
        .where(FieldPath.documentId, whereIn: docIdList)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ExerciseMedia.fromJson(doc.data()))
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
        .orderBy('priority', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ExerciseModel.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<ExerciseModel>> getExerciseListByUserLevelAndPriorityAndPartFocus(
      int priority, String partFocus) {
    return FirebaseFirestore.instance
        .collection('exercise')
        .where('priority', isEqualTo: priority)
        .where('partFocus', arrayContains: partFocus)
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

  Future<String> addCourse(CoursesModel course) async {
    try {
      course.setisGlobalIsFalse();
      late String docId;
      await _firestore
          .collection('course')
          .add(course.toJson())
          .then((DocumentReference doc) {
        docId = doc.id;
      });
      return docId;
    } catch (e) {
      return 'fail';
    }
  }

  Future<String> addUserCourse(String courseId, String username) async {
    try {
      UserCourseModel userCourse = UserCourseModel(
          courseDocId: courseId,
          courseEndDate: DateTime.now().add(const Duration(days: 5)),
          dateStart: DateTime.now(),
          isFinish: false,
          lastDo: DateTime.now(),
          username: username);
      await _firestore.collection('userCourse').add(userCourse.toJson());
      return 'success';
    } catch (e) {
      return 'fail';
    }
  }

  Future<List<String>?> getExerciseDocIdByName(List<String> nameList) async {
    List<String> docId = [];
    int i = 0;
    try {
      for (String name in nameList) {
        QuerySnapshot querySnapshot =
            await _exerciseCollection.where('name', isEqualTo: name).get();
        if (querySnapshot.docs.isNotEmpty) {
          docId.add(querySnapshot.docs.first.id);
          print(docId[i]);
        } else {
          print('No document found for name: $name');
        }
        i++;
      }
    } catch (e) {
      print('Error: $e');
    }
    return docId;
  }

  Future<String?> getCourseDocIdByName(String name) async {
    String docId = "";

    try {
      QuerySnapshot querySnapshot =
          await _courseCollection.where('name', isEqualTo: name).get();
      if (querySnapshot.docs.isNotEmpty) {
        docId = querySnapshot.docs.first.id;
      }
    } catch (e) {
      print('Error: $e');
    }
    return docId;
  }
}
