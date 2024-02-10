import '/library.dart';

class WorkoutBlock extends StatelessWidget {
  const WorkoutBlock({
    super.key,
    required this.width,
    required this.height,
    required this.workout,
  });

  final double width;
  final double height;
  final WorkoutModel workout;

  @override
  Widget build(BuildContext context) {
    return QmBlock(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(10),
      width: width * .2,
      height: height * .2,
      isGradient: false,
      onTap: () => context.pushNamed(
        Routes.workoutRootR,
        extra: {
          WorkoutModel.modelKey: workout,
          "showAddButton": true,
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
                  text: workout.name,
                  maxWidth: double.maxFinite,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: QmText(
                  text: Utils().timeAgo(workout.creationDate),
                  isSeccoundary: true,
                ),
              ),
            ],
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Draggable<WorkoutModel>(
              data: workout,
              feedback: QmBlock(
                padding: const EdgeInsets.all(10),
                color: ColorConstants.secondaryColor,
                width: width * .2,
                height: height * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Hero(
                        tag: workout.id,
                        child: QmImageNetwork(
                          source: workout.imageURL,
                          fallbackIcon: EvaIcons.plus,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: QmText(
                        text: workout.name,
                        maxWidth: double.maxFinite,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              child: Hero(
                tag: workout.id,
                child: QmImageNetwork(
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
