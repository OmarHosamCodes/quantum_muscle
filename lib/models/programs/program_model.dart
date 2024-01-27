import 'package:quantum_muscle/library.dart';

class ProgramModel {
  static const String nameKey = "name";
  static const String trainerIdKey = "trainerId";
  static const String traineesIdsKey = "traineesIds";
  static const String workoutsKey = "workouts";
  static const String idKey = "id";
  static const String creationDateKey = "creationDate";
  static const String modelKey = "ProgramModel";

  bool isHovered;

  String name;
  String id;
  String trainerId;
  List traineesIds;
  List workouts;
  Timestamp creationDate;

  ProgramModel({
    this.isHovered = false,
    required this.name,
    required this.id,
    required this.trainerId,
    required this.traineesIds,
    required this.workouts,
    required this.creationDate,
  });
  ProgramModel.empty()
      : isHovered = false,
        name = "",
        id = "",
        trainerId = "",
        traineesIds = [],
        workouts = [],
        creationDate = Timestamp.now();
  factory ProgramModel.fromMap(Map<String, dynamic> map) => ProgramModel(
        name: map[nameKey],
        id: map[idKey],
        trainerId: map[trainerIdKey],
        traineesIds: map[traineesIdsKey],
        workouts: map[workoutsKey],
        creationDate: map[creationDateKey],
      );

  Map<String, dynamic> toMap() => {
        nameKey: name,
        idKey: id,
        trainerIdKey: trainerId,
        traineesIdsKey: traineesIds,
        workoutsKey: workouts,
        creationDateKey: creationDate,
      };
}
