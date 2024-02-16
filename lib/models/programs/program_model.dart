import 'package:quantum_muscle/library.dart';

class ProgramModel {
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

  ProgramModel.empty()
      : isHovered = false,
        name = '',
        id = '',
        trainerId = '',
        traineesIds = [],
        workouts = [],
        creationDate = Timestamp.now(),
        restDayOrDays = [];
  factory ProgramModel.fromMap(Map<String, dynamic> map) => ProgramModel(
        name: map[nameKey] as String,
        id: map[idKey] as String,
        trainerId: map[trainerIdKey] as String,
        traineesIds: (map[traineesIdsKey] as List<dynamic>).cast<String>(),
        workouts: (map[workoutsKey] as List<dynamic>).cast<String>(),
        creationDate: map[creationDateKey] as Timestamp,
        restDayOrDays: (map[restDayOrDaysKey] as List<dynamic>).cast<String>(),
      );
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

  static const String nameKey = 'name';
  static const String trainerIdKey = 'trainerId';
  static const String traineesIdsKey = 'traineesIds';
  static const String workoutsKey = 'workouts';
  static const String idKey = 'id';
  static const String creationDateKey = 'creationDate';
  static const String modelKey = 'ProgramModel';
  static const String restDayOrDaysKey = 'restDayOrDays';
  bool isHovered;

  String name;
  String id;
  String trainerId;
  List<String> traineesIds;
  List<String> workouts;
  List<String> restDayOrDays;
  Timestamp creationDate;

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
