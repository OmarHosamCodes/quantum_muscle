import '/library.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.width,
    required this.height,
    required this.exercise,
    required this.workoutCollectionName,
    required this.workoutAndExercises,
  });

  final double width;
  final double height;
  final ExerciseModel exercise;
  final String workoutCollectionName;
  final Map<String, List<dynamic>> workoutAndExercises;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return SlimyCard(
      onTap: () {},
      color: ColorConstants.primaryColor,
      topCardHeight: height >= 150 ? 150 : height * 0.2,
      bottomCardHeight: height >= 150 ? 150 : height * 0.2,
      borderRadius: 10,
      width: 300,
      topCardWidget: Stack(
        alignment: Alignment.center,
        children: [
          QmBlock(
            width: width,
            height: height,
            borderRadius: BorderRadius.circular(10),
            color: ColorConstants.disabledColor.withOpacity(.3),
          ),
          Image(
            image: CachedNetworkImageProvider(exercise.showcaseUrl),
            fit: BoxFit.scaleDown,
            errorBuilder: (context, error, stackTrace) => QmIconButton(
              icon: EvaIcons.alertCircle,
              onPressed: () => openQmDialog(
                  context: context,
                  title: S.current.Failed,
                  message: error.toString()),
            ),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: QmCircularProgressIndicator(),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 5,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: QmText(
                    text: exercise.name,
                    overflow: TextOverflow.fade,
                    maxWidth: width * .3,
                  ),
                ),
                QmText(
                  text: exercise.target,
                  overflow: TextOverflow.fade,
                  isSeccoundary: true,
                  maxWidth: width * .25,
                ),
              ],
            ),
          ),
          // QmRowOrStack(
          //   condition: isDesktop(),
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [

          //   ],
          // ),
        ],
      ),
      bottomCardWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            flex: 1,
            child: QmIconButton(
              onPressed: () => pageController.previousPage(
                duration: SimpleConstants.fastAnimationDuration,
                curve: Curves.ease,
              ),
              icon: EvaIcons.arrowBack,
            ),
          ),
          Consumer(builder: (context, ref, _) {
            return ref.watch(exercisesProvider(workoutAndExercises)).when(
                  data: (exercises) => Flexible(
                    flex: 2,
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: exercise.sets.length + 1,
                      itemBuilder: (context, index) {
                        if (index == exercise.sets.length) {
                          return QmIconButton(
                            onPressed: () => ExerciseUtil().addSet(
                              workoutCollectionName: workoutCollectionName,
                              exerciseDocName:
                                  "${exercise.name}${exercise.target}${exercise.id}",
                            ),
                            icon: EvaIcons.plus,
                          );
                        }
                        String set = exercise.sets[index];
                        return QmBlock(
                          isGradient: true,
                          onTap: () => openQmDialog(
                            context: context,
                            title: set,
                            message: set,
                          ),
                          width: width * .2,
                          height: height * .3,
                          child: QmText(
                            text: set,
                          ),
                        );
                      },
                    ),
                  ),
                  loading: () =>
                      const Center(child: QmCircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: QmText(text: error.toString())),
                );
          }),
          QmIconButton(
            onPressed: () => pageController.nextPage(
              duration: SimpleConstants.fastAnimationDuration,
              curve: Curves.ease,
            ),
            icon: EvaIcons.arrowForward,
          ),
        ],
      ),
    );
  }
}
