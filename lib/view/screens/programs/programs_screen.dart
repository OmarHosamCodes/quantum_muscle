import 'package:quantum_muscle/library.dart';

/// Screen to show the programs.
class ProgramsScreen extends StatelessWidget {
  /// const constructor for the [ProgramsScreen]
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     ref
      //       ..invalidate(programsProvider)
      //       ..invalidate(userProvider(utils.userUid!));
      //   },
      //   child: const Icon(EvaIcons.refresh),
      // ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Consumer(
            builder: (_, ref, __) {
              ref.watch(localeProvider);
              final programsWatcher = ref.watch(programsProvider);
              final userWatcher = ref.watch(userProvider(utils.userUid!));
              bool isTrainee() {
                return userWatcher.maybeWhen(
                  data: (user) => user.type == UserType.trainee,
                  orElse: () => true,
                );
              }

              return programsWatcher.when(
                data: (programs) {
                  if (programs.isEmpty) {
                    return Flexible(
                      child: ProgramsShowcase(
                        width: width,
                        height: height,
                        programs: const [],
                        isTrainee: isTrainee(),
                      ),
                    );
                  }
                  return Flexible(
                    child: ProgramsShowcase(
                      width: width,
                      height: height,
                      programs: programs,
                      isTrainee: isTrainee(),
                    ),
                  );
                },
                error: (error, _) => const SizedBox(),
                loading: () => Flexible(
                  child: ResponsiveGridView.builder(
                    gridDelegate: const ResponsiveGridDelegate(
                      crossAxisSpacing: 10,
                      crossAxisExtent: 200,
                      mainAxisSpacing: 10,
                      maxCrossAxisExtent: 200,
                      minCrossAxisExtent: 100,
                    ),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .05,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) => const QmShimmer.rectangle(
                      width: 150,
                      height: 300,
                      radius: 10,
                    ),
                  ),
                ),
              );
            },
          ),
          const Flexible(child: WorkoutsShowcase()),
        ],
      ),
    );
  }
}
