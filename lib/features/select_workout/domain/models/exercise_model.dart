class ExerciseMedia {
  ExerciseMedia({
    required this.image,
    required this.video,
    required this.animation,
  });
  String image;
  String video;
  String animation;

  factory ExerciseMedia.fromJson(Map<String, dynamic> json) {
    return ExerciseMedia(
      image: json['imageUrl'] as String,
      video: json['videoUrl'] as String,
      animation: json['animationUrl'] as String,
    );
  }
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
      mediaDocId: List<String>.from(json['exerciseMediaDocId']),
      amout: json['amout'] as int,
      time: json['time'] as int,
      level: json['level'] as int,
      partFocus: List<String>.from(json['partFocus']),
      priority: json['priority'] as int,
    );
  }

  void setMedia(List<ExerciseMedia> media) {
    this.media = media;
  }
}
