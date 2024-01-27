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
              builder: (_, ref, __) {
                ref.watch(localeProvider);
                final programsWatcher = ref.watch(programsProvider);
                final userWatcher = ref.watch(userProvider(Utils().userUid!));
                bool isTrainee() {
                  return userWatcher.maybeWhen(
                    data: (user) => user.type == UserType.trainee,
                    orElse: () => true,
                  );
                }

                return programsWatcher.maybeWhen(
                  data: (programs) => SizedBox(
                    height: height * .5,
                    child: ProgramsShowcase(
                      width: width,
                      height: height,
                      programs: programs,
                      isTrainee: isTrainee(),
                    ),
                  ),
                  loading: () => const Center(
                    child: QmCircularProgressIndicator(),
                  ),
                  orElse: () => SizedBox(
                    height: height * .5,
                    child: ProgramsShowcase(
                      width: width,
                      height: height,
                      programs: const [],
                      isTrainee: isTrainee(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: height * .5,
              child: const WorkoutsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
