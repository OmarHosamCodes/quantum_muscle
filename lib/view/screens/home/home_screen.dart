import '/library.dart';

final userFutureProvider = FutureProvider.family<DocumentSnapshot, String>(
  (ref, id) async => await Utils.instants.firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(id)
      .get(),
);

final workoutsStreamProvider =
    StreamProvider.family<QuerySnapshot<WorkoutModel>?, String>(
  (ref, id) => Utils.instants.firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(Utils().userUid)
      .collection(DBPathsConstants.usersUserWorkoutsPath)
      .withConverter(
        fromFirestore: WorkoutModel.fromMap,
        toFirestore: (workout, _) => workout.toMap(),
      )
      .orderBy(
        WorkoutModel.creationDateKey,
        descending: true,
      )
      .get()
      .asStream(),
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .045,
                  vertical: height * .025,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .05,
                ),
                child: Container(
                  height: height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorConstants.primaryColor,
                      width: 3,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      QmText(
                        text: S.current.Slogan,
                        maxWidth: 150,
                      ),
                      SizedBox(
                        width: width * .05,
                      ),
                      Image.asset(
                        AssetPathConstants.mainVectorImgPath,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop() ? width * .06 : width * .05,
                  vertical: height * .025,
                ),
                child: Row(
                  children: [
                    QmText(text: S.current.Workouts),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  final workoutsSnapshot = ref
                      .watch(workoutsStreamProvider(Utils.instants.userUid!));

                  return workoutsSnapshot.when(
                    data: (data) {
                      if (data!.docs.isEmpty) {
                        return BigAddWorkout(width: width, height: height);
                      } else {
                        return GridView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * .05,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isDesktop()
                                ? 4
                                : isTablet()
                                    ? 3
                                    : 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.1,
                          ),
                          itemCount: data.docs.length + 1,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (index == data.docs.length) {
                              return SmallAddWorkout(
                                width: width,
                                height: height,
                              );
                            } else {
                              final workout = data.docs[index].data();
                              final workoutName = workout.name;
                              final workoutExercises = workout.exercises;
                              final workoutImgUrl = workout.imgUrl;
                              final workoutCreationDate = workout.creationDate;
                              final workoutId = workout.id;

                              return QmBlock(
                                padding: const EdgeInsets.all(10),
                                width: 0,
                                height: 0,
                                isGradient: false,
                                onTap: () => context.pushNamed(
                                  Routes.workoutRootR,
                                  extra: {
                                    WorkoutModel.nameKey: workoutName,
                                    WorkoutModel.imgUrlKey: workoutImgUrl,
                                    WorkoutModel.exercisesKey: workoutExercises,
                                    WorkoutModel.creationDateKey:
                                        workoutCreationDate,
                                    WorkoutModel.idKey: workoutId,
                                    "index": index,
                                  },
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: QmText(
                                            text: workoutName,
                                            maxWidth: double.maxFinite,
                                          ),
                                        ),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: QmText(
                                            text: Utils()
                                                .timeAgo(workoutCreationDate),
                                            isSeccoundary: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Hero(
                                        tag: workoutId,
                                        child: Image(
                                          image: CachedNetworkImageProvider(
                                              workoutImgUrl),
                                          fit: BoxFit.scaleDown,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.add_a_photo_outlined,
                                              color:
                                                  ColorConstants.secondaryColor,
                                            );
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const QmCircularProgressIndicator();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                      }
                    },
                    loading: () => const QmCircularProgressIndicator(),
                    error: (e, s) =>
                        BigAddWorkout(width: width, height: height),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
