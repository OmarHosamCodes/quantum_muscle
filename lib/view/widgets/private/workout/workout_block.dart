import 'package:quantum_muscle/library.dart';

class WorkoutBlock extends StatelessWidget {
  const WorkoutBlock({
    required this.width,
    required this.height,
    required this.workout,
    super.key,
  });

  final double width;
  final double height;
  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return QmBlock(
      padding: const EdgeInsets.all(10),
      onTap: () => context.pushNamed(
        Routes.workoutRootR,
        extra: {
          WorkoutModel.modelKey: workout,
          'showAddButton': true,
        },
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: QmText(
                  text: workout.name,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: QmText(
                  text: utils.timeAgo(workout.creationDate),
                  isSeccoundary: true,
                ),
              ),
            ],
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Draggable<WorkoutModel>(
              data: workout,
              feedback: QmBlock(
                height: 200,
                width: 200,
                padding: const EdgeInsets.all(10),
                color: ColorConstants.secondaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Hero(
                        tag: workout.id,
                        child: QmImage.network(
                          source: workout.imageURL,
                          fallbackIcon: EvaIcons.plus,
                        ),
                      ),
                    ),
                    Flexible(
                      child: QmText(
                        text: workout.name,
                      ),
                    ),
                  ],
                ),
              ),
              child: Hero(
                tag: workout.id,
                child: QmImage.network(
                  source: workout.imageURL,
                  fallbackIcon: EvaIcons.plus,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
