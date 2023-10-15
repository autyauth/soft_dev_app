import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String name;
  final String weight;
  final String height;
  final String gender;
  final String age;
  // final String point;
  // final String UserPicture;
  // final String UserExerciseLevel;

  const MyUser(
      {required this.userId,
      required this.email,
      required this.name,
      required this.weight,
      required this.height,
      required this.gender,
      required this.age

      // this.point,
      // this.UserPicture,
      // this.UserExerciseLevel,
      });

  static const empty = MyUser(
    userId: '',
    email: '',
    name: '',
    weight: '',
    height: '',
    gender: '',
    age: '',
  );

  MyUser copyWith({
    String? userId,
    String? email,
    String? name,
    String? weight,
    String? height,
    String? gender,
    String? age,
  }) {
    return MyUser(
        userId: userId ?? this.userId,
        email: email ?? this.email,
        name: name ?? this.name,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        gender: gender ?? this.gender,
        age: age ?? this.age);
  }

//
  MyUserEntity toEntity() {
    return MyUserEntity(
        userId: userId,
        email: email,
        name: name,
        weight: weight,
        height: height,
        gender: gender,
        age: age);
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
        userId: entity.userId,
        email: entity.email,
        name: entity.name,
        weight: entity.weight,
        height: entity.height,
        gender: entity.gender,
        age: entity.age);
  }

  @override
  List<Object?> get props => [userId, email, name, weight, height, gender, age];
}
