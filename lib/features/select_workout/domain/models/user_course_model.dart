import 'package:cloud_firestore/cloud_firestore.dart';

class UserCourseModel {
  String courseDocId;
  DateTime courseEndDate;
  DateTime dateStart;
  bool isFinish;
  DateTime lastDo;
  String username;
  UserCourseModel({
    required this.courseDocId,
    required this.courseEndDate,
    required this.dateStart,
    required this.isFinish,
    required this.lastDo,
    required this.username,
  });
  factory UserCourseModel.fromJson(Map<String, dynamic> json) {
    return UserCourseModel(
      courseDocId: json['courseDocId'] as String,
      courseEndDate: (json['courseEndDate'] as Timestamp).toDate(),
      dateStart: (json['dateStart'] as Timestamp).toDate(),
      isFinish: json['isFinish'] as bool,
      lastDo: (json['lastDo'] as Timestamp).toDate(),
      username: json['username'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'courseDocId': courseDocId,
      'courseEndDate': courseEndDate,
      'dateStart': dateStart,
      'isFinish': isFinish,
      'lastDo': lastDo,
      'username': username,
    };
  }

  void setUsername(String username) {
    this.username = username;
  }

  void setCourseId(String courseDocId) {
    this.courseDocId = courseDocId;
  }
}
