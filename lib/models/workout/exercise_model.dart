import '/library.dart';

class ExerciseModel {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String targetKey = 'target';
  static const String setsKey = 'sets';
  static const String contentURLKey = 'contentURL';
  static const String contentTypeKey = 'contentType';
  static const String creationDateKey = 'creationDate';

  String id;
  String name;
  String target;
  String contentURL;
  Map<String, dynamic> sets;
  ExerciseContentType contentType;
  Timestamp creationDate = Timestamp.now();

  ExerciseModel({
    required this.id,
    required this.name,
    required this.target,
    required this.sets,
    required this.contentURL,
    required this.contentType,
    required this.creationDate,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) => ExerciseModel(
        id: map[idKey],
        name: map[nameKey],
        target: map[targetKey],
        sets: map[setsKey],
        contentURL: map[contentURLKey],
        contentType: ExerciseContentType.values.firstWhere(
          (element) => element.name == map[contentTypeKey],
        ),
        creationDate: map[creationDateKey],
      );

  Map<String, dynamic> toMap() => {
        idKey: id,
        nameKey: name,
        targetKey: target,
        setsKey: sets,
        contentURLKey: contentURL,
        contentTypeKey: contentType.name,
        creationDateKey: creationDate,
      };
}
