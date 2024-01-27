import 'package:quantum_muscle/view/widgets/private/home/analytics_chart.dart';

import '/library.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                    borderRadius: SimpleConstants.borderRadius,
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
                        maxWidth: 140,
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
              Consumer(
                builder: (_, ref, __) {
                  final generalAnalytics =
                      ref.watch(generalAnalyticsProvider(Utils().userUid!));

                  return generalAnalytics.maybeWhen(
                    // todo fix this
                    data: (analytics) {
                      int tPrograms = analytics.totalPrograms ?? 0;
                      int tTrainees = analytics.totalTrainees ?? 0;
                      int tWorkouts = analytics.totalWorkouts ?? 0;
                      int tExercises = analytics.totalExercises ?? 0;

                      return SizedBox(
                        height: height * .5,
                        width: width * .9,
                        child: GeneralAnalyticsChart(
                          totalPrograms: tPrograms,
                          totalTrainees: tTrainees,
                          totalWorkouts: tWorkouts,
                          totalExercises: tExercises,
                        ).animate().fade(
                              duration: SimpleConstants.slowAnimationDuration,
                            ),
                      );
                    },
                    error: (error, stackTrace) => QmText(
                      text: error.toString(),
                    ),
                    orElse: () => QmText(
                      text: S.current.DefaultError,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
