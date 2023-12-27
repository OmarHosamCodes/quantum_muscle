import '/library.dart';

final userFutureProvider = FutureProvider.family<DocumentSnapshot, String>(
  (ref, id) async => await Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(id)
      .get(),
);
final workoutsStreamProvider = StreamProvider<QuerySnapshot<WorkoutModel>?>(
  (ref) => Utils()
      .firebaseFirestore
      .collection(DBPathsConstants.usersPath)
      .doc(Utils().userUid)
      .collection(DBPathsConstants.usersUserWorkoutsPath)
      .withConverter(
        fromFirestore: WorkoutModel.fromMap,
        toFirestore: (workout, _) => workout.toMap(),
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
              Consumer(
                builder: (context, ref, child) {
                  final userFutureSanpshot =
                      ref.watch(userFutureProvider(Utils().userUid!));
                  final user = userFutureSanpshot.whenOrNull(
                    data: (data) {
                      if (data.exists) {
                        return ProviderStatus.data;
                      } else {
                        return ProviderStatus.none;
                      }
                    },
                    loading: () => ProviderStatus.loading,
                    error: (e, s) => ProviderStatus.error,
                  );
                  if (user == ProviderStatus.loading) {
                    return const QmCircularProgressIndicator();
                  } else if (user == ProviderStatus.error ||
                      user == ProviderStatus.none) {
                    return QmText(
                      text: "${S.current.Hi}, ${S.current.UserNamePlaceHolder}",
                      maxWidth: double.maxFinite,
                    );
                  } else {
                    final data = userFutureSanpshot.value
                        as DocumentSnapshot<Map<String, dynamic>>;
                    return QmText(
                      text:
                          "${S.current.Hi}, ${data.get(DBPathsConstants.usersUserNamePath)}",
                      maxWidth: double.maxFinite,
                    );
                  }
                },
              ),
              //? search bar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .045,
                  vertical: height * .025,
                ),
                // child: const HomeSearchBar(),
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
                  final streamSnapshot = ref.watch(workoutsStreamProvider);

                  final workouts = streamSnapshot.when(
                    data: (data) {
                      if (data!.docs.isEmpty) {
                        return ProviderStatus.none;
                      } else {
                        return data;
                      }
                    },
                    loading: () => ProviderStatus.loading,
                    error: (e, s) => ProviderStatus.error,
                  );

                  if (workouts == ProviderStatus.error ||
                      workouts == ProviderStatus.none) {
                    //todo gradient animation
                    return BigAddWorkout(width: width, height: height);
                  } else if (workouts == ProviderStatus.loading) {
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
                          final workoutName = workout.workoutName ??
                              SimpleConstants.emptyString;
                          final workoutExercises =
                              workout.workoutExercises ?? [];
                          final workoutImage = workout.workoutImgEncoded;
                          final workoutCreationDate =
                              workout.workoutCreationDate;
                          final workoutId = workout.workoutId ?? 'Invalid id';
                          final workoutImageBytes = base64Decode(workoutImage!);

                          return QmBlock(
                            padding: const EdgeInsets.all(10),
                            width: 0,
                            height: 0,
                            isGradient: false,
                            onTap: () => context.goNamed(
                              Routes.workoutRootR,
                              pathParameters: {
                                WorkoutModel.workoutIdKey: workoutId,
                              },
                              extra: {
                                WorkoutModel.workoutNameKey: workoutName,
                                WorkoutModel.workoutImgEncodedKey:
                                    workoutImageBytes,
                                WorkoutModel.workoutExercisesKey:
                                    workoutExercises,
                                WorkoutModel.workoutCreationDateKey:
                                    workoutCreationDate,
                              },
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        text: workoutCreationDate!,
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
