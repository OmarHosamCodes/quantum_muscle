import 'package:quantum_muscle/library.dart';

final programsProvider = FutureProvider<List<ProgramModel>>((ref) async {
  final userRef = ref.watch(userProvider(Utils().userUid!));
  final programs =
      // ignore: strict_raw_type
      userRef.maybeWhen(
    data: (user) {
      if (user.programs.isEmpty) {
        return Future.value(<ProgramModel>[]);
      }
      return Utils()
          .firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .where(
            ProgramModel.idKey,
            whereIn: user.programs,
          )
          .get()
          .then(
            (event) =>
                event.docs.map((e) => ProgramModel.fromMap(e.data())).toList(),
          );
    },
    orElse: () => Future.value(<ProgramModel>[]),
  );

  return programs;
});

final programWorkoutsProvider =
    FutureProvider.family<List<WorkoutModel>, String>((ref, programId) async {
  final programWorkouts = await Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(programId)
      .collection(DBPathsConstants.workoutsPath)
      .get()
      .then(
        (workouts) => workouts.docs
            .map((workout) => WorkoutModel.fromMap(workout.data()))
            .toList(),
      );
  return programWorkouts;
});

final programExercisesProvider =
    FutureProvider.family<List<ExerciseModel>, (String, String)>(
        (ref, requiredData) async {
  final programExercises = await Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(requiredData.$1)
      .collection(DBPathsConstants.workoutsPath)
      .doc(requiredData.$2)
      .collection(DBPathsConstants.exercisesPath)
      .get()
      .then(
        (event) =>
            event.docs.map((e) => ExerciseModel.fromMap(e.data())).toList(),
      );
  return programExercises;
});

final programTraineesAvatarsProvider =
    FutureProvider.family<List<String?>, String>((ref, programId) async {
  final programTrainees = await Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(programId)
      .get()
      .then(
        (program) => program.get(ProgramModel.traineesIdsKey) as List<dynamic>,
      );
  final programTraineesAvatars = await Future.wait(
    programTrainees
        .map(
          (traineeId) => Utils()
              .firebaseFirestore
              .collection(DBPathsConstants.usersPath)
              .doc(traineeId as String?)
              .get()
              .then(
                (trainee) =>
                    trainee.get(UserModel.profileImageURLKey) as String?,
              ),
        )
        .toList(),
  );
  return programTraineesAvatars;
});
