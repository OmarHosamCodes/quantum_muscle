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
