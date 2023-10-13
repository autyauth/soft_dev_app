class CoursesModel {
  final String description;
  final List<String> exerciseDocId;
  final String image;
  final String name;
  final List<CourseType> type;

  CoursesModel({
    required this.description,
    required this.exerciseDocId,
    required this.image,
    required this.name,
    required this.type,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      description: json['description'] as String,
      exerciseDocId: List<String>.from(json['exerciseDocId']),
      // exerciseDocId: json['exerciseDocId'],
      image: json['image'] as String,
      name: json['name'] as String,
      type: List<CourseType>.from(
        json['type'].map((type) => CourseType.fromJson(type)),
      ),
    );
  }
}

class CourseType {
  final String image;
  final String name;

  CourseType({
    required this.image,
    required this.name,
  });

  factory CourseType.fromJson(Map<String, dynamic> json) {
    return CourseType(
      image: json['image'] as String,
      name: json['name'] as String,
    );
  }
}
