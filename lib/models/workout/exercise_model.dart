import 'package:quantum_muscle/library.dart';

/// Represents an exercise model.
class ExerciseModel {
  /// Creates a new instance of [ExerciseModel].
  ExerciseModel({
    required this.id,
    required this.name,
    required this.target,
    required this.sets,
    required this.contentURL,
    required this.contentType,
    required this.creationDate,
  });

  /// Creates an instance of [ExerciseModel] from a map.
  factory ExerciseModel.fromMap(Map<String, dynamic> map) => ExerciseModel(
        id: map[idKey] as String,
        name: map[nameKey] as String,
        target: map[targetKey] as String,
        sets: map[setsKey] as Map<String, dynamic>,
        contentURL: map[contentURLKey] as String,
        contentType: ExerciseContentType.values.firstWhere(
          (element) => element.name == map[contentTypeKey] as String,
        ),
        creationDate: map[creationDateKey] as Timestamp,
      );

  /// The unique identifier of the exercise.
  final String id;

  /// The name of the exercise.
  final String name;

  /// The target area of the exercise.
  final String target;

  /// The sets of the exercise.
  final Map<String, dynamic> sets;

  /// The content URL of the exercise.
  String contentURL;

  /// The content type of the exercise.
  final ExerciseContentType contentType;

  /// The creation date of the exercise.
  final Timestamp creationDate;

  /// The key for the 'id' field in the map.
  static const String idKey = 'id';

  /// The key for the 'name' field in the map.
  static const String nameKey = 'name';

  /// The key for the 'target' field in the map.
  static const String targetKey = 'target';

  /// The key for the 'sets' field in the map.
  static const String setsKey = 'sets';

  /// The key for the 'contentURL' field in the map.
  static const String contentURLKey = 'contentURL';

  /// The key for the 'contentType' field in the map.
  static const String contentTypeKey = 'contentType';

  /// The key for the 'creationDate' field in the map.
  static const String creationDateKey = 'creationDate';

  /// Converts the [ExerciseModel] instance to a map.
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
