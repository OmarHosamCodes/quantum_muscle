import '../../../library.dart';

final userFutureProvider = FutureProvider<DocumentSnapshot>(
  (ref) async => FirebaseFirestore.instance
      .collection(DBPathsConstants.usersPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get(),
);
final workoutsStreamProvider = StreamProvider<QuerySnapshot<WorkoutModel>?>(
  (ref) => FirebaseFirestore.instance
      .collection(DBPathsConstants.usersPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(DBPathsConstants.usersUserWorkoutsPath)
      .withConverter(
        fromFirestore: WorkoutModel.fromMap,
        toFirestore: (workout, _) => workout.toMap(),
      )
      .get()
      .asStream(),
);
final futureStateProvider =
    StateProvider<FutureStatus>((ref) => FutureStatus.loading);

enum FutureStatus { loading, error, data, none }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final searchBarTextController = TextEditingController();
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
      appBar: AppBar(
        title: QmText(
          text: S.of(context).Home,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(EvaIcons.bellOutline),
          )
        ],
      ),
      drawer: isDesktop() ? null : const RoutingDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final futureSnapshot = ref.watch(userFutureProvider);
                  final user = futureSnapshot.whenOrNull(
                    data: (data) {
                      if (data.data() == null) {
                        return FutureStatus.error;
                      } else {
                        return FutureStatus.data;
                      }
                    },
                    loading: () => FutureStatus.loading,
                    error: (e, s) => FutureStatus.error,
                  );
                  if (user == FutureStatus.data) {
                    final data = futureSnapshot.value as DocumentSnapshot;
                    return QmText(
                      text:
                          "${S.of(context).Hi}, ${data.get(DBPathsConstants.usersUserNamePath)}",
                      maxWidth: double.maxFinite,
                    );
                  } else if (user == FutureStatus.error) {
                    return QmText(
                      text:
                          "${S.of(context).Hi}, ${S.of(context).UserNamePlaceHolder}",
                      maxWidth: double.maxFinite,
                    );
                  } else {
                    return const QmCircularProgressIndicator();
                  }
                },
              ),
              //? search bar
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .045,
                    vertical: height * .025,
                  ),
                  child: HomeSearchBar(
                    controller: searchBarTextController,
                  )),
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
                        text: S.of(context).Slogan,
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
                    QmText(text: S.of(context).Workouts),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, _) {
                  final streamSnapshot = ref.watch(workoutsStreamProvider);

                  final workouts = streamSnapshot.when(
                    data: (data) {
                      if (data!.docs.isEmpty) {
                        return FutureStatus.none;
                      } else {
                        return data;
                      }
                    },
                    loading: () => FutureStatus.loading,
                    error: (e, s) => FutureStatus.error,
                  );

                  if (workouts == FutureStatus.error ||
                      workouts == FutureStatus.none) {
                    //todo gradient animation
                    return BigAddWorkout(width: width, height: height);
                  } else if (workouts == FutureStatus.loading) {
                    return const QmCircularProgressIndicator();
                  } else {
                    final data = workouts as QuerySnapshot<WorkoutModel>?;

                    return GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * .05,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop()
                            ? 4
                            : isTablet()
                                ? 3
                                : 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: data!.docs.length + 1,
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
                          final workoutName = workout.workoutName ?? '';
                          final workoutExercises =
                              workout.workoutExercises ?? [];
                          final workoutImage = workout.workoutImgEncoded;
                          final workoutCreationDate =
                              workout.workoutCreationDate;
                          final workoutId = workout.workoutId ?? 'Invalid id';
                          final workoutImageBytes =
                              base64.decode(workoutImage!);

                          return QmBlock(
                            padding: const EdgeInsets.all(10),
                            width: 0,
                            height: 0,
                            isGradient: false,
                            onTap: () => context.goNamed(
                              Routes.workoutRootR,
                              pathParameters: {
                                'workoutId': workoutId,
                              },
                              extra: {
                                'workoutName': workoutName,
                                'workoutImage': workoutImageBytes,
                                'workoutExercises': workoutExercises,
                                'workoutCreationDate': workoutCreationDate,
                              },
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      QmText(
                                        text: workoutName,
                                        maxWidth: double.maxFinite,
                                      ),
                                      QmText(
                                        text: workoutCreationDate!,
                                        isSeccoundary: true,
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Hero(
                                    tag: workoutId,
                                    child: Image(
                                      image: MemoryImage(workoutImageBytes),
                                      fit: BoxFit.scaleDown,
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                              ],
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
