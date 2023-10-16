import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
	final String userId;
	final String email;
	final String name;
  final String gender;
  final int weight;
  final int height;
  final int age;
  final String firstName;
  final String lastName;
  final String imageUrl;
  final int point;
  final int level;
  final DateTime? birthDate;

	const MyUserEntity({
		required this.userId,
		required this.email,
		required this.name, 
    required this.gender, 
    required this.weight, 
    required this.height, 
    required this.age, 
    required this.firstName, 
    required this.lastName, 
    required this.imageUrl, 
    required this.point, 
    required this.level, 
    this.birthDate,
	});

	Map<String, Object?> toDocument() {
		return {
			'userId': userId,
			'email': email,
			'username': name,
      'gender': gender, 
      'weight': weight, 
      'height': height, 
      'age': age,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'point': point,
      'level': level,
      'birthDate': birthDate?.millisecondsSinceEpoch,
		};
	}

	static MyUserEntity fromDocument(Map<String, dynamic> doc) {
		return MyUserEntity(
			userId: doc['userId'], 
			email: doc['email'], 
			name: doc['username'], 
      gender: doc['gender'], 
      weight: doc['weight'], 
      height: doc['height'], 
      age: doc['age'] ?? 0, 
      firstName: doc['firstName'],
      lastName: doc['lastName'], 
      imageUrl: doc['imageUrl'], 
      point: doc['point'] ?? 0,
      level: doc['level'] ?? 0,
      birthDate: doc['birthDate'] != null ? DateTime.fromMillisecondsSinceEpoch(doc['birthDate']) : null,

		);
	}

	@override
	List<Object?> get props => [userId, email, name, weight, height, gender, age];

}