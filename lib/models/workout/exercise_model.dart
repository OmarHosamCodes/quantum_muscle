import '/library.dart';

class ExerciseModel {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String targetKey = 'target';
  static const String setsKey = 'sets';
  static const String showcaseUrlKey = 'showcaseUrl';
  static const String showcaseTypeKey = 'showcaseType';

  String id;
  String name;
  String target;
  String showcaseUrl;
  List<dynamic> sets;
  ExerciseShowcase showcaseType;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.target,
    required this.sets,
    required this.showcaseUrl,
    required this.showcaseType,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) => ExerciseModel(
      id: map[idKey],
      name: map[nameKey],
      target: map[targetKey],
      sets: map[setsKey],
      showcaseUrl: map[showcaseUrlKey],
      showcaseType: ExerciseShowcase.values.firstWhere(
        (element) => element.name == map[showcaseTypeKey],
      ));

  Map<String, dynamic> toMap() => {
        idKey: id,
        nameKey: name,
        targetKey: target,
        setsKey: sets,
        showcaseUrlKey: showcaseUrl,
        showcaseTypeKey: showcaseType.name,
      };
}
