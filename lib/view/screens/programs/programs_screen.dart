import '/library.dart';

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, _) {
                ref.watch(localeProvider);
                final programsWatcher = ref.watch(programsProvider);
                final userWatcher = ref.watch(userProvider(Utils().userUid!));
                bool isTrainee() {
                  if (userWatcher.valueOrNull!.type == UserType.trainee) {
                    return true;
                  } else {
                    return false;
                  }
                }

                return programsWatcher.when(
                  data: (data) => SizedBox(
                    height: height * .5,
                    child: ProgramsShowcase(
                      width: width,
                      height: height,
                      programs: data,
                      isTrainee: isTrainee(),
                    ),
                  ),
                  loading: () => const Center(
                    child: QmCircularProgressIndicator(),
                  ),
                  error: (error, stackTrace) => Center(
                    child: QmText(text: S.current.NoPrograms),
                  ),
                );
              },
            ),
            SizedBox(
              height: height * .5,
              child: const WorkoutsScreen(),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
