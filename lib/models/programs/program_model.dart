class ProgramModel {
  static const String nameKey = "name";
  static const String trainerIdKey = "trainerId";
  static const String traineesIdsKey = "traineesIds";
  static const String workoutsKey = "workouts";
  static const String idKey = "id";

  String name;
  String id;
  String trainerId;
  List? traineesIds;
  List? workouts;

  ProgramModel({
    required this.name,
    required this.id,
    required this.trainerId,
    this.traineesIds,
    this.workouts,
  });

  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      name: map[nameKey],
      id: map[idKey],
      trainerId: map[trainerIdKey],
      traineesIds: map[traineesIdsKey],
      workouts: map[workoutsKey],
    );
  }

  Map<String, dynamic> toMap() => {
        nameKey: name,
        idKey: id,
        trainerIdKey: trainerId,
        traineesIdsKey: traineesIds,
        workoutsKey: workouts,
      };
}
