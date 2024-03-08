import 'package:quantum_muscle/library.dart';

/// Represents a program model.
class ProgramModel {
  /// Creates a new instance of [ProgramModel].
  ProgramModel({
    required this.name,
    required this.id,
    required this.trainerId,
    required this.traineesIds,
    required this.workouts,
    required this.creationDate,
    required this.restDayOrDays,
    this.isHovered = false,
  });

  /// Creates an empty instance of [ProgramModel].
  ProgramModel.empty()
      : isHovered = false,
        name = '',
        id = '',
        trainerId = '',
        traineesIds = [],
        workouts = [],
        creationDate = Timestamp.now(),
        restDayOrDays = [];

  /// Creates a [ProgramModel] instance from a map.
  factory ProgramModel.fromMap(Map<String, dynamic> map) => ProgramModel(
        name: map[nameKey] as String,
        id: map[idKey] as String,
        trainerId: map[trainerIdKey] as String,
        traineesIds: (map[traineesIdsKey] as List<dynamic>).cast<String>(),
        workouts: (map[workoutsKey] as List<dynamic>).cast<String>(),
        creationDate: map[creationDateKey] as Timestamp,
        restDayOrDays: (map[restDayOrDaysKey] as List<dynamic>).cast<String>(),
      );

  /// The name of the program.
  String name;

  /// The ID of the program.
  String id;

  /// The ID of the trainer associated with the program.
  String trainerId;

  /// The IDs of the trainees associated with the program.
  List<String> traineesIds;

  /// The workouts included in the program.
  List<String> workouts;

  /// The creation date of the program.
  Timestamp creationDate;

  /// The rest day or days of the program.
  List<String> restDayOrDays;

  /// Indicates whether the program is currently being hovered.
  bool isHovered;

  /// Creates a copy of the [ProgramModel] with optional changes.
  ProgramModel copyWith({
    String? name,
    String? id,
    String? trainerId,
    List<String>? traineesIds,
    List<String>? workouts,
    Timestamp? creationDate,
    List<String>? restDayOrDays,
    bool? isHovered,
  }) {
    return ProgramModel(
      name: name ?? this.name,
      id: id ?? this.id,
      trainerId: trainerId ?? this.trainerId,
      traineesIds: traineesIds ?? this.traineesIds,
      workouts: workouts ?? this.workouts,
      creationDate: creationDate ?? this.creationDate,
      restDayOrDays: restDayOrDays ?? this.restDayOrDays,
      isHovered: isHovered ?? this.isHovered,
    );
  }

  /// The key for the program name in the map.
  static const String nameKey = 'name';

  /// The key for the trainer ID in the map.
  static const String trainerIdKey = 'trainerId';

  /// The key for the trainees IDs in the map.
  static const String traineesIdsKey = 'traineesIds';

  /// The key for the workouts in the map.
  static const String workoutsKey = 'workouts';

  /// The key for the program ID in the map.
  static const String idKey = 'id';

  /// The key for the creation date in the map.
  static const String creationDateKey = 'creationDate';

  /// The key for the program model name in the map.
  static const String modelKey = 'ProgramModel';

  /// The key for the rest day or days in the map.
  static const String restDayOrDaysKey = 'restDayOrDays';

  /// Converts the [ProgramModel] instance to a map.
  Map<String, dynamic> toMap() => {
        nameKey: name,
        idKey: id,
        trainerIdKey: trainerId,
        traineesIdsKey: traineesIds,
        workoutsKey: workouts,
        creationDateKey: creationDate,
        restDayOrDaysKey: restDayOrDays,
      };
}
