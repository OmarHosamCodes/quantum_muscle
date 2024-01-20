import '/library.dart';

class ExerciseModel {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String targetKey = 'target';
  static const String setsKey = 'sets';
  static const String showcaseUrlKey = 'showcaseUrl';
  static const String showcaseTypeKey = 'showcaseType';
  static const String creationDateKey = 'creationDate';

  String id;
  String name;
  String target;
  String showcaseUrl;
  List sets;
  ExerciseShowcase showcaseType;
  Timestamp creationDate = Timestamp.now();

  ExerciseModel({
    required this.id,
    required this.name,
    required this.target,
    required this.sets,
    required this.showcaseUrl,
    required this.showcaseType,
    required this.creationDate,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) => ExerciseModel(
        id: map[idKey],
        name: map[nameKey],
        target: map[targetKey],
        sets: map[setsKey],
        showcaseUrl: map[showcaseUrlKey],
        showcaseType: ExerciseShowcase.values.firstWhere(
          (element) => element.name == map[showcaseTypeKey],
        ),
        creationDate: map[creationDateKey],
      );

  Map<String, dynamic> toMap() => {
        idKey: id,
        nameKey: name,
        targetKey: target,
        setsKey: sets,
        showcaseUrlKey: showcaseUrl,
        showcaseTypeKey: showcaseType.name,
        creationDateKey: creationDate,
      };
}
