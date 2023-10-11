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
  ExerciseModel({
    required this.name,
    required this.description,
    required this.media,
    required this.amout,
    required this.time,
    required this.level,
    required this.partFocus,
  });
  String name;
  String description;
  List<ExerciseMedia> media;
  int amout;
  int time;
  int level;
  List<String> partFocus;
}
