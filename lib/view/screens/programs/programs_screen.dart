import '/library.dart';

final programsProvider = FutureProvider<List<ProgramModel>>((ref) async {
  final userRef = ref.watch(userFutureProvider(Utils().userUid!));
  final programsFeildAtUser = userRef
      .whenData<List>(
          (value) => value.get(UserModel.programsKey) as List<dynamic>)
      .value;

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

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * .6,
            child: Consumer(
              builder: (context, ref, child) {
                final programsFuture = ref.watch(programsProvider);
                return programsFuture.when(
                  data: (data) {
                    return ProgramsShowcase(
                      width: width,
                      height: height,
                      programs: data,
                    );
                  },
                  loading: () => const Center(
                    child: QmCircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.NoPrograms),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: height * .4,
              child: const WorkoutsScreen(),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
