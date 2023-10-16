import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
  final String userId;
  final String email;
  final String name;
  final int weight;
  final int height;
  final String gender;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final int age;
  final int point;
  final int level;
  final DateTime? birthDate;

  const MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.weight,
    required this.height,
    required this.gender,
    required this.age,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.point,
    required this.level,
    this.birthDate,
  });

  static const empty = MyUser(
    userId: '',
    email: '',
    name: '',
    weight: 0,
    height: 0,
    gender: '',
    age: 0,
    firstName: '',
    lastName: '',
    imageUrl: '',
    point: 0,
    level: 0,
  );

  MyUser copyWith({
    String? userId,
    String? email,
    String? name,
    int? weight,
    int? height,
    String? gender,
    int? age,
    String? firstName,
    String? lastName,
    String? imageUrl,
    int? point,
    int? level,
    DateTime? birthDate,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      point: point ?? this.point,
      level: level ?? this.level,
      birthDate: birthDate ?? this.birthDate,
    );
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
      age: age,
      firstName: firstName,
      lastName: lastName,
      imageUrl: imageUrl,
      point: point,
      level: level,
      birthDate: birthDate,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      weight: entity.weight,
      height: entity.height,
      gender: entity.gender,
      age: entity.age,
      firstName: entity.firstName,
      lastName: entity.lastName,
      imageUrl: entity.imageUrl,
      point: entity.point,
      level: entity.level,
    );
  }

  @override
  List<Object?> get props => [userId, email, name, weight, height, gender, age];
}
