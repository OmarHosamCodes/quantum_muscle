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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 175,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: SimpleConstants.borderRadius,
                  border: Border.all(
                    color: ColorConstants.accentColor,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: QmText.simple(
                    text: S.current.Slogan,
                    isHeadline: true,
                  ),
                ),
              ),
              Consumer(
                builder: (_, ref, __) {
                  final generalAnalytics =
                      ref.watch(generalAnalyticsProvider(utils.userUid!));

                  return generalAnalytics.maybeWhen(
                    data: (analytics) {
                      int getValue(int? value) {
                        if (value == null || value == 0) {
                          return 1;
                        } else {
                          return value;
                        }
                      }

                      final tPrograms = getValue(analytics.totalPrograms);
                      final tTrainees = getValue(analytics.totalTrainees);
                      final tWorkouts = getValue(analytics.totalWorkouts);
                      final tExercises = getValue(analytics.totalExercises);

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
