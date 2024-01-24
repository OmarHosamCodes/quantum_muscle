import '/library.dart';

final programs2Provider = StreamProvider<List<ProgramModel>>((ref) async* {
  final userRef = ref.watch(userProvider(Utils().userUid!));
  final programsFeildAtUser =
      userRef.whenData<List>((value) => value.programs).value!;
  List<ProgramModel> programs = [];
  for (var program in programsFeildAtUser) {
    final programRef = Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.programsPath)
        .doc(program);
    final programData =
        await programRef.get().then((program) => program.data());
    final programModel = ProgramModel.fromMap(programData!);
    programs.add(programModel);
  }
  yield programs;
});

final programsProvider = StreamProvider<List<ProgramModel>>((ref) async* {
  final userRef = ref.watch(userProvider(Utils().userUid!));
  final programsFieldAtUser =
      userRef.whenData<List>((value) => value.programs).value!;
  Stream<List<ProgramModel>> programs = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .where(
        ProgramModel.idKey,
        whereIn: programsFieldAtUser,
      )
      .snapshots()
      .map((event) =>
          event.docs.map((e) => ProgramModel.fromMap(e.data())).toList());
  yield* programs;
});

final programWorkoutsProvider =
    StreamProvider.family<List<WorkoutModel>, String>((ref, programId) async* {
  Stream<List<WorkoutModel>> programWorkouts = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(programId)
      .collection(DBPathsConstants.workoutsPath)
      .snapshots()
      .map((workouts) => workouts.docs
          .map((workout) => WorkoutModel.fromMap(workout.data()))
          .toList());
  yield* programWorkouts;
});

final programExercisesProvider =
    StreamProvider.family<List<ExerciseModel>, (String, String)>(
        (ref, requiredData) async* {
  Stream<List<ExerciseModel>> programExercises = Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(requiredData.$1)
      .collection(DBPathsConstants.workoutsPath)
      .doc(requiredData.$2)
      .collection(DBPathsConstants.exercisesPath)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => ExerciseModel.fromMap(e.data())).toList());
  yield* programExercises;
});

final programTraineesAvatarsProvider =
    StreamProvider.family<List<String?>, String>((ref, programId) async* {
  final programTrainees = await Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.programsPath)
      .doc(programId)
      .get()
      .then((program) =>
          program.get(ProgramModel.traineesIdsKey) as List<dynamic>);
  final programTraineesAvatars = await Future.wait(
    programTrainees
        .map(
          (traineeId) async => await Utils()
              .firebaseFirestore
              .collection(DBPathsConstants.usersPath)
              .doc(traineeId)
              .get()
              .then((trainee) =>
                  trainee.get(UserModel.profileImageKey) as String?),
        )
        .toList(),
  );
  yield programTraineesAvatars;
});
