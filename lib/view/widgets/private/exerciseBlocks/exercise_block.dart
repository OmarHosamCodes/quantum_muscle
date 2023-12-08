import '/library.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
    required this.width,
    required this.height,
  });

  final ExerciseModel exercise;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SlimyCard(
        color: ColorConstants.primaryColor,
        topCardHeight: height >= 150 ? 150 : height * 0.2,
        bottomCardHeight: width >= 125 ? 125 : height * 0.2,
        borderRadius: 10,
        topCardWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: MemoryImage(base64Decode(exercise.exerciseImgEncoded!)),
                fit: BoxFit.scaleDown,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.primaryColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QmText(
                  text: exercise.exerciseName ?? 'null',
                ),
                QmText(
                  text: exercise.exerciseTarget ?? 'null',
                  isSeccoundary: true,
                ),
              ],
            ),
          ],
        ),
        bottomCardWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: QmIconButton(
                onPressed: () => pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceOut,
                ),
                icon: EvaIcons.arrowBack,
              ),
            ),
            Flexible(
              flex: 2,
              child: PageView.builder(
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemCount: exercise.exerciseSets!.length,
                itemBuilder: (context, index) {
                  final set = exercise.exerciseSets![index];
                  return QmBlock(
                    isGradient: true,
                    onTap: () => openQmDialog(
                      context: context,
                      title: set,
                      message: set,
                    ),
                    width: width * .2,
                    height: height * .1,
                    child: QmText(
                      text: set,
                    ),
                  );
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: QmIconButton(
                onPressed: () => pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceIn,
                ),
                icon: EvaIcons.arrowForward,
              ),
            )
          ],
        ),
      ),
    );
  }
}
