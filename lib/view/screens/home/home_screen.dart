import '../../../library.dart';

final userFutureProvider = FutureProvider<DocumentSnapshot>(
  (ref) async => FirebaseFirestore.instance
      .collection(DBPathsConstants.usersPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get(),
);
final workoutsStreamProvider = StreamProvider<QuerySnapshot<WorkoutModel>>(
  (ref) => FirebaseFirestore.instance
      .collection(DBPathsConstants.usersPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection(DBPathsConstants.usersUserworkoutsPath)
      .withConverter(
        fromFirestore: WorkoutModel.fromMap,
        toFirestore: (workout, _) => workout.toMap(),
      )
      .get()
      .asStream(),
);
final futureStateProvider =
    StateProvider<FutureStatus>((ref) => FutureStatus.loading);

enum FutureStatus { loading, error, data }

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
                ).animate().shimmer(
                      duration: const Duration(
                        seconds: 3,
                      ),
                    ),
              ),
              Container(
                height: height * .2,
                width: isDesktop() ? width * .6 : width * .9,
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
                builder: (context, ref, child) {
                  final streamSnapshot = ref.watch(workoutsStreamProvider);

                  final workouts = streamSnapshot.whenOrNull(
                    data: (data) {
                      if (data.docs.isEmpty) {
                        return FutureStatus.error;
                      } else {
                        return FutureStatus.data;
                      }
                    },
                    loading: () => FutureStatus.loading,
                    error: (e, s) => FutureStatus.error,
                  );
                  if (workouts == FutureStatus.data) {
                    final data =
                        workouts as QuerySnapshot<Map<String, dynamic>>;
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
                        childAspectRatio: 2,
                      ),
                      itemCount: data.docs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const QmBlock(
                          height: 0,
                          width: 0,
                          child: Center(),
                        );
                      },
                    );
                  } else if (workouts == FutureStatus.error) {
                    //todo gradient animation
                    return BigAddWorkout(width: width, height: height);
                  } else {
                    return const QmCircularProgressIndicator();
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
