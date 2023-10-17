import 'package:cloud_firestore/cloud_firestore.dart';
//model
class UserProfile {
  //อย่าใช้ final เพราะจะเขียน data ไม่ได้ ยกเว้นแค่จะดึงมาดูอย่างเดียวค่อยใช้
   String firstName;
   String lastName;
   DateTime? birthDate;
   String? gender;
   int height;
   int weight;
   String email;
   String? imageUrl;
   int level;
   int point;
   String username;
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
    required this.username
  });
//mapping model and data in database
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
      username: map['username']?? '',
    );
  }
  //map dataใน Userprofile ไปใส่ใน database
    Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'height': height,
      'weight': weight,
      'email': email,
      'birthDate': birthDate,
      'gender': gender,
      'imageUrl':imageUrl,
    };
  }
}
