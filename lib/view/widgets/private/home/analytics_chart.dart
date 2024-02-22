import 'package:quantum_muscle/library.dart';

class GeneralAnalyticsChart extends StatefulWidget {
  const GeneralAnalyticsChart({
    required this.totalPrograms,
    required this.totalTrainees,
    required this.totalWorkouts,
    required this.totalExercises,
    super.key,
  });
  final int totalPrograms;
  final int totalTrainees;
  final int totalWorkouts;
  final int totalExercises;

  @override
  State<GeneralAnalyticsChart> createState() => _GeneralAnalyticsChartState();
}

class _GeneralAnalyticsChartState extends State<GeneralAnalyticsChart> {
  int touchedIndex = -1;
  late int semiTotal = widget.totalWorkouts +
      widget.totalExercises +
      widget.totalTrainees +
      widget.totalPrograms;

  late int total = semiTotal != 0 ? semiTotal : 100;
  late double tProgramsRatio =
      ((widget.totalPrograms / total) * 100).floorToDouble();
  late double tTraineesRatio =
      ((widget.totalTrainees / total) * 100).floorToDouble();
  late double tWorkoutsRatio =
      ((widget.totalWorkouts / total) * 100).floorToDouble();
  late double tExercisesRatio =
      ((widget.totalExercises / total) * 100).floorToDouble();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
                swapAnimationDuration: SimpleConstants.slowAnimationDuration,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: ColorConstants.primaryColor,
                text: S.current.Programs,
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              Indicator(
                color: ColorConstants.accentColor,
                text: S.current.Trainees
                    .substring(0, S.current.Trainees.length - 1),
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              Indicator(
                color: ColorConstants.disabledColor,
                text: S.current.Workouts
                    .substring(0, S.current.Workouts.length - 1),
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              Indicator(
                color: ColorConstants.textSeccondaryColor,
                text: S.current.Exercises,
                isSquare: true,
              ),
              const SizedBox(
                height: 4,
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      4,
      (i) {
        final isTouched = i == touchedIndex;
        final radius = isTouched ? 60.0 : 50.0;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: ColorConstants.primaryColor,
              value: tProgramsRatio,
              title: widget.totalPrograms.toString(),
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: 20,
                fontFamily: SimpleConstants.fontFamily,
                color: ColorConstants.textColor,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: ColorConstants.accentColor,
              value: tTraineesRatio,
              title: widget.totalTrainees.toString(),
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: 20,
                fontFamily: SimpleConstants.fontFamily,
                color: ColorConstants.textColor,
              ),
            );
          case 2:
            return PieChartSectionData(
              color: ColorConstants.disabledColor,
              value: tWorkoutsRatio,
              title: widget.totalWorkouts.toString(),
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: 20,
                fontFamily: SimpleConstants.fontFamily,
                color: ColorConstants.textColor,
              ),
            );
          case 3:
            return PieChartSectionData(
              color: ColorConstants.textSeccondaryColor,
              value: tExercisesRatio,
              title: widget.totalExercises.toString(),
              radius: radius,
              titleStyle: const TextStyle(
                fontSize: 20,
                fontFamily: SimpleConstants.fontFamily,
                color: ColorConstants.textColor,
              ),
            );

          default:
            throw Error();
        }
      },
    );
  }
}
