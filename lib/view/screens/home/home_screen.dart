import 'package:fl_chart/fl_chart.dart';

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
                builder: (context, ref, _) {
                  final generalAnalytics = ref.watch(generalAnalyticsProvider(
                      Utils().userUid ?? SimpleConstants.emptyString));

                  return generalAnalytics.maybeWhen(
                    // todo fix this
                    data: (data) => AspectRatio(
                      aspectRatio: 1.0,
                      child: PieChart(
                        PieChartData(sections: [
                          PieChartSectionData(
                            color: ColorConstants.primaryColor,
                            value: data.totalPrograms!.toDouble(),
                            title: data.totalPrograms.toString(),
                            radius: 40,
                          ),
                          PieChartSectionData(
                            color: ColorConstants.secondaryColor,
                            value: data.totalClients!.toDouble(),
                            title: data.totalClients.toString(),
                            radius: 40,
                          ),
                          PieChartSectionData(
                            color: ColorConstants.disabledColor,
                            value: data.totalWorkouts!.toDouble(),
                            title: data.totalWorkouts.toString(),
                            radius: 40,
                          ),
                          PieChartSectionData(
                            color: ColorConstants.primaryColor,
                            value: data.totalExercises!.toDouble(),
                            title: data.totalExercises.toString(),
                            radius: 40,
                          ),
                          PieChartSectionData(
                            color: ColorConstants.secondaryColor,
                            value: data.totalFollowers!.toDouble(),
                            title: data.totalFollowers.toString(),
                            radius: 40,
                          ),
                        ], centerSpaceRadius: 10),
                        swapAnimationDuration:
                            const Duration(milliseconds: 150),
                      ),
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
