import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
	final String userId;
	final String email;
	final String name;
  final String gender;
  final String weight;
  final String height;
  final String age;

	const MyUserEntity({
		required this.userId,
		required this.email,
		required this.name, 
    required this.gender, 
    required this.weight, 
    required this.height, 
    required this.age
	});

	Map<String, Object?> toDocument() {
		return {
			'userId': userId,
			'email': email,
			'name': name,
      'gender': gender, 
      'weight': weight, 
      'height': height, 
      'age': age,
		};
	}

	static MyUserEntity fromDocument(Map<String, dynamic> doc) {
		return MyUserEntity(
			userId: doc['userId'], 
			email: doc['email'], 
			name: doc['name'], 
      gender: doc['gender'], 
      weight: doc['weight'], 
      height: doc['height'], 
      age: doc['age'],
//
		);
	}

	@override
	List<Object?> get props => [userId, email, name, weight, height, gender, age];

}