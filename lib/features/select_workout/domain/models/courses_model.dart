class CoursesModel {
  final String description;
  List<String> exerciseDocId;
  final String image;
  final String name;
  final List<CourseType> type;
  bool isGlobal;
  final int level;

  CoursesModel({
    required this.description,
    required this.exerciseDocId,
    required this.image,
    required this.name,
    required this.type,
    required this.isGlobal,
    required this.level,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      description: json['description'],
      exerciseDocId: List<String>.from(json['exerciseDocId']),
      // exerciseDocId: json['exerciseDocId'],
      image: json['image'],
      name: json['name'],
      type: List<CourseType>.from(
        json['type'].map((type) => CourseType.fromJson(type)),
      ),
      isGlobal: json['isGlobal'] as bool,
      level: json['level'] as int,
    );
  }
  Map<String, Object> toJson() => {
        'description': description,
        'exerciseDocId': exerciseDocId,
        'image': image,
        'name': name,
        'type': type.map((e) => e.toJson()).toList(),
        'isGlobal': isGlobal,
        'level': level,
      };
  void setisGlobalIsFalse() {
    this.isGlobal = false;
  }

  void setCourseId(List<String> exerciseDocId) {
    this.exerciseDocId = exerciseDocId;
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
  Map<String, Object> toJson() => {
        'image': image,
        'name': name,
      };
}
