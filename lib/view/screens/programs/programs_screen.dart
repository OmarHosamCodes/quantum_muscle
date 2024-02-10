import '/library.dart';

class ProgramsScreen extends ConsumerStatefulWidget {
  const ProgramsScreen({super.key});

  @override
  ConsumerState<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends ConsumerState<ProgramsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(_, () {
        ref.read(programsProvider);
        ref.invalidate(programsProvider);
      });
    });
  }

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
                    height: height * .4,
                    child: ProgramsShowcase(
                      width: width,
                      height: height,
                      programs: programs,
                      isTrainee: isTrainee(),
                    ),
                  ),
                  loading: () => SizedBox(
                    height: height * .4,
                    child: ResponsiveGridView.builder(
                      gridDelegate: const ResponsiveGridDelegate(
                        crossAxisSpacing: 10,
                        crossAxisExtent: 200,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.0,
                        maxCrossAxisExtent: 200,
                        minCrossAxisExtent: 100,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .05,
                      ),
                      itemCount: 4,
                      shrinkWrap: false,
                      itemBuilder: (context, index) => const QmShimmer(
                        width: 150,
                        height: 300,
                        radius: 10,
                      ),
                    ),
                  ),
                  orElse: () => SizedBox(
                    height: height * .4,
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
            const SizedBox(height: 20),
            SizedBox(
              height: height * .4,
              child: const WorkoutShowcase(),
            ),
          ],
        ),
      ),
    );
  }
}
