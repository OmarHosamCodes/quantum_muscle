import '/library.dart';

// final programsProvider = FutureProvider.family((ref, id) async {
//   final userRef = ref.watch(userFutureProvider(Utils().userUid!));
//   final programsList =userRef.whenData((value) =>
//    value.get('programs') as List<dynamic> ).valueOrNull;
//   final programs = programsList!.map((e) => Program.fromJson(e)).toList();
//   return programs;
// });

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          ref.watch(localeStateProvider.notifier).state;
          return child!;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * .6,
              child: Consumer(
                builder: (context, ref, child) {
                  //  final programsFuture =  ref.watch(programsProvider);
                  return child!;
                },
                child: ProgramsShowcase(
                  width: width,
                  height: height,
                ),
              ),
            ),
            SizedBox(
              height: height * .3,
              width: width,
              child: const WorkoutsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
