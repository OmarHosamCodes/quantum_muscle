import 'package:quantum_muscle/library.dart';

/// Screen to show the details of a program.
class ProgramDetailsScreen extends StatelessWidget {
  /// const constructor for the [ProgramDetailsScreen]
  const ProgramDetailsScreen({
    required this.arguments,
    super.key,
  });

  /// arguments
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    final program = arguments[ProgramModel.modelKey] as ProgramModel;
    final isTrainee = arguments['isTrainee'] as bool;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isDesktop() => !ResponsiveBreakpoints.of(context).smallerThan(DESKTOP);

    bool isTablet() => !ResponsiveBreakpoints.of(context).smallerThan(TABLET);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //? App Bar
            SizedBox(
              height: height * 0.2,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QmButton.icon(
                    icon: EvaIcons.arrowBack,
                    onPressed: () => context.pop(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QmText(
                        text: program.name,
                      ),
                      QmText(
                        text: utils.timeAgo(program.creationDate),
                        isSeccoundary: true,
                      ),
                    ],
                  ),
                  Visibility.maintain(
                    visible: program.trainerId == utils.userUid,
                    child: Consumer(
                      builder: (_, ref, __) {
                        return FittedBox(
                          child: Column(
                            children: [
                              QmButton.icon(
                                onPressed: () => programUtil.deleteProgram(
                                  programId: program.id,
                                  traineesIds: program.traineesIds,
                                  ref: ref,
                                ),
                                icon: EvaIcons.trash,
                              ),
                              QmButton.icon(
                                onPressed: () => openAddTraineeSheet(
                                  context,
                                  programRequestId: program.id,
                                ),
                                icon: EvaIcons.personAdd,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            //? Trainees Avatars
            Visibility(
              visible: program.trainerId == utils.userUid!,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (_, ref, __) {
                      final programTraineesAvatarsFuture =
                          ref.watch(programTraineesAvatarsProvider(program.id));
                      return programTraineesAvatarsFuture.when(
                        data: (data) {
                          return SizedBox(
                            height: height * 0.1,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: data
                                  .map(
                                    (imageUrl) => QmAvatar(
                                      radius: 20,
                                      imageUrl: imageUrl,
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                        loading: () => SizedBox(
                          height: height * 0.1,
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              5,
                              (index) => const QmShimmer.round(
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        error: (error, stackTrace) =>
                            QmText(text: error.toString()),
                      );
                    },
                  ),
                  const QmDivider(),
                ],
              ),
            ),
            Consumer(
              builder: (_, ref, __) {
                final programWorkoutsWatcher =
                    ref.watch(programWorkoutsProvider(program.id));
                return programWorkoutsWatcher.when(
                  data: (programWorkouts) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: programWorkouts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop()
                            ? 3
                            : isTablet()
                                ? 2
                                : 1,
                      ),
                      itemBuilder: (context, index) {
                        final workout = programWorkouts[index];
                        return GestureDetector(
                          onTap: () => context.pushNamed(
                            Routes.workoutRootR,
                            extra: {
                              WorkoutModel.modelKey: workout,
                              'showAddButton': !isTrainee,
                              'programId': program.id,
                              'programName': program.name,
                            },
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstants.accentColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: width * .2,
                              height: height * .2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Hero(
                                      tag: workout.id,
                                      child: QmImage.smart(
                                        source: workout.imageURL,
                                        fallbackIcon: EvaIcons.plus,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: QmText(
                                      text: workout.name,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop()
                            ? 3
                            : isTablet()
                                ? 2
                                : 1,
                      ),
                      itemBuilder: (context, index) =>
                          const QmShimmer.rectangle(
                        width: 100,
                        height: 100,
                        radius: 10,
                      ),
                    ),
                  ),
                  error: (error, stackTrace) =>
                      Center(child: QmText(text: error.toString())),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
