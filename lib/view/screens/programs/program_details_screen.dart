import 'package:quantum_muscle/library.dart';

class ProgramDetailsScreen extends StatelessWidget {
  const ProgramDetailsScreen({
    required this.arguments,
    super.key,
  });
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    final program = arguments[ProgramModel.modelKey] as ProgramModel;
    final isTrainee = arguments['isTrainee'] as bool;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isDesktop() {
      if (ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)) return false;
      return true;
    }

    bool isTablet() {
      if (ResponsiveBreakpoints.of(context).smallerThan(TABLET)) return false;
      return true;
    }

    return Scaffold(
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
                  QmIconButton(
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
                        text: Utils().timeAgo(program.creationDate),
                        isSeccoundary: true,
                      ),
                    ],
                  ),
                  Visibility.maintain(
                    visible: program.trainerId == Utils().userUid,
                    child: Consumer(
                      builder: (_, ref, __) {
                        return FittedBox(
                          child: Column(
                            children: [
                              QmIconButton(
                                onPressed: () => ProgramsUtil().deleteProgram(
                                  context: context,
                                  programId: program.id,
                                  traineesIds: program.traineesIds,
                                  ref: ref,
                                ),
                                icon: EvaIcons.trash,
                              ),
                              QmIconButton(
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
              visible: program.trainerId == Utils().userUid!,
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
                              (index) => const QmShimmerRound(
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
                  const Divider(
                    thickness: 1,
                    color: ColorConstants.primaryColor,
                  ),
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
                                color: ColorConstants.secondaryColor,
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
                                      child: QmImageNetwork(
                                        source: workout.imageURL,
                                        fallbackIcon: EvaIcons.plus,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: QmText(
                                      text: workout.name,
                                      maxWidth: double.maxFinite,
                                      overflow: TextOverflow.clip,
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
                  loading: () => GridView.builder(
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
                    itemBuilder: (context, index) => const QmShimmer(
                      width: 100,
                      height: 100,
                      radius: 10,
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
