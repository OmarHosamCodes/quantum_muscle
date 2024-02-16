import 'package:quantum_muscle/library.dart';
import 'package:quantum_muscle/view/widgets/private/home/analytics_chart.dart';

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
                    children: [
                      QmText(
                        text: S.current.Slogan,
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
                      ref.watch(generalAnalyticsProvider(utils.userUid!));

                  return generalAnalytics.maybeWhen(
                    data: (analytics) {
                      final tPrograms = analytics.totalPrograms ?? 0;
                      final tTrainees = analytics.totalTrainees ?? 0;
                      final tWorkouts = analytics.totalWorkouts ?? 0;
                      final tExercises = analytics.totalExercises ?? 0;

                      return SizedBox(
                        height: height * .5,
                        width: width * .9,
                        child: GeneralAnalyticsChart(
                          totalPrograms: tPrograms,
                          totalTrainees: tTrainees,
                          totalWorkouts: tWorkouts,
                          totalExercises: tExercises,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
