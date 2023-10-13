class ExerciseMedia {
  ExerciseMedia({
    required this.image,
    required this.video,
    required this.animation,
  });
  String image;
  String video;
  String animation;
}

class ExerciseModel {
  ExerciseModel(
      {required this.name,
      required this.description,
      required this.mediaDocId,
      required this.amout,
      required this.time,
      required this.level,
      required this.partFocus,
      required this.priority})
      : media = [];
  String name;
  String description;
  List<String> mediaDocId;
  List<ExerciseMedia>? media;
  int amout;
  int time;
  int level;
  int priority;
  List<String> partFocus;

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      name: json['name'] as String,
      description: json['description'] as String,
      mediaDocId: json['exerciseMediaDocId'] as List<String>,
      amout: json['amout'] as int,
      time: json['time'] as int,
      level: json['level'] as int,
      partFocus: json['partFocus'] as List<String>,
      priority: json['priority'] as int,
    );
  }
}
