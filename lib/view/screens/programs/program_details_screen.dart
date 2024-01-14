import '/library.dart';

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

class ProgramDetailsScreen extends StatelessWidget {
  const ProgramDetailsScreen({
    super.key,
    required this.arguments,
  });
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    final program = arguments[ProgramModel.modelKey] as ProgramModel;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.2,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QmIconButton(
                    icon: EvaIcons.arrowBack,
                    onPressed: () => context.pop(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      builder: (context, ref, _) {
                        return FittedBox(
                          child: Column(
                            children: [
                              QmIconButton(
                                onPressed: () => ProgramsUtil().deleteProgram(
                                  context: context,
                                  programId: program.id,
                                  traineesIds: program.traineesIds as List,
                                  ref: ref,
                                ),
                                icon: EvaIcons.trash,
                              ),
                              QmIconButton(
                                onPressed: () => openAddTraineeSheet(context),
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
            Visibility(
              visible: program.trainerId == Utils().userUid,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (context, ref, _) {
                      final programTraineesAvatarsFuture =
                          ref.watch(programTraineesAvatarsProvider(program.id));
                      return programTraineesAvatarsFuture.when(
                        data: (data) {
                          return SizedBox(
                            height: height * 0.1,
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: data
                                  .map((imageUrl) => QmAvatar(
                                        radius: 20.0,
                                        imageUrl: imageUrl,
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                        loading: () => const QmCircularProgressIndicator(),
                        error: (error, stackTrace) =>
                            QmText(text: error.toString()),
                      );
                    },
                  ),
                  const Divider(
                    thickness: 1.0,
                    color: ColorConstants.primaryColor,
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: program.workouts!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final workoutData = program.workouts![index];
                final workout = WorkoutModel.fromMap(workoutData);
                return GestureDetector(
                  onTap: () => context.push(
                    Routes.workoutRootR,
                    extra: {
                      WorkoutModel.modelKey: workout,
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.secondaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: width * .2,
                      height: height * .2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Hero(
                              tag: workout.id,
                              child: Image(
                                image:
                                    CachedNetworkImageProvider(workout.imgUrl),
                                fit: BoxFit.scaleDown,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: ColorConstants.secondaryColor,
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const QmCircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.loose,
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
            )
          ],
        ),
      ),
    );
  }
}
