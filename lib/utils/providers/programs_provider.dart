import 'package:quantum_muscle/library.dart';

final programsProvider = StreamProvider<List<ProgramModel>>((ref) async* {
  final userRef = ref.watch(userProvider(Utils().userUid!));
  final programs =
      // ignore: strict_raw_type
      userRef.maybeWhen(
    data: (user) {
      if (user.programs.isEmpty) {
        return Stream.value(<ProgramModel>[]);
      }
      return Utils()
          .firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .where(
            ProgramModel.idKey,
            whereIn: user.programs,
          )
          .snapshots()
          .map(
            (event) =>
                event.docs.map((e) => ProgramModel.fromMap(e.data())).toList(),
          );
    },
    orElse: () => Stream.value(<ProgramModel>[]),
  );

  yield* programs;
});

final programWorkoutsProvider =
    StreamProvider.family<List<WorkoutModel>, String>((ref, programId) async* {
  final programWorkouts = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(programId)
      .collection(DBPathsConstants.workoutsPath)
      .snapshots()
      .map(
        (workouts) => workouts.docs
            .map((workout) => WorkoutModel.fromMap(workout.data()))
            .toList(),
      );
  yield* programWorkouts;
});

final programExercisesProvider =
    StreamProvider.family<List<ExerciseModel>, (String, String)>(
        (ref, requiredData) async* {
  final programExercises = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(requiredData.$1)
      .collection(DBPathsConstants.workoutsPath)
      .doc(requiredData.$2)
      .collection(DBPathsConstants.exercisesPath)
      .snapshots()
      .map(
        (event) =>
            event.docs.map((e) => ExerciseModel.fromMap(e.data())).toList(),
      );
  yield* programExercises;
});

final programTraineesAvatarsProvider =
    StreamProvider.family<List<String?>, String>((ref, programId) async* {
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
  yield programTraineesAvatars;
});
