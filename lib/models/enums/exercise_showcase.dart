import '/library.dart';

enum ExerciseShowcase {
  image,
  video,
  gif,
  none,
}

extension ExerciseShowcaseExtension on ExerciseShowcase {
  String get name {
    switch (this) {
      case ExerciseShowcase.image:
        return ExerciseShowcaseConstants.image;
      case ExerciseShowcase.video:
        return ExerciseShowcaseConstants.video;
      case ExerciseShowcase.gif:
        return ExerciseShowcaseConstants.gif;
      case ExerciseShowcase.none:
        return ExerciseShowcaseConstants.none;
    }
  }
}
