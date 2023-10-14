import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final String? gender;
  final int height;
  final int weight;
  final String email;
  final String? imageUrl;
  final int level;
  final int point;
  UserProfile({
    required this.firstName,
    required this.lastName,
    this.birthDate,
    required this.level,
    required this.point,
    required this.imageUrl,
    required this.gender,
    required this.height,
    required this.weight,
    required this.email,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      birthDate: map['birthDate'] != null
          ? (map['birthDate'] as Timestamp).toDate()
          : null,
      gender: map['gender'],
      level: map['level'] ?? 0,
      point: map['point'] ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      height: map['height'] ?? 0,
      weight: map['weight'] ?? 0,
      email: map['email'] ?? '',
    );
  }
}
