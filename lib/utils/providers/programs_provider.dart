import '/library.dart';

final programsProvider = FutureProvider<List<ProgramModel>>((ref) async {
  final userRef = ref.watch(userProvider(Utils().userUid!));
  final programsFeildAtUser =
      userRef.whenData<List>((value) => value.programs).value;

  List<ProgramModel> programs = await Future.wait(
    programsFeildAtUser!
        .map(
          (programId) async => await Utils()
              .firebaseFirestore
              .collection(UserModel.programsKey)
              .doc(programId)
              .get()
              .then((program) => ProgramModel.fromMap(program.data()!)),
        )
        .toList(),
  );

  return programs;
});
final programTraineesAvatarsProvider =
    FutureProvider.family<List<String?>, String>((ref, programId) async {
  final programTrainees = await Utils()
      .firebaseFirestore
      .collection(UserModel.programsKey)
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
  return programTraineesAvatars;
});
