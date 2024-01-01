import '/library.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.width,
    required this.height,
    required this.showcaseUrl,
    required this.name,
    required this.target,
    required this.sets,
  });

  final double width;
  final double height;
  final String showcaseUrl;
  final String name;
  final String target;
  final List sets;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    return SlimyCard(
      onTap: () {},
      color: ColorConstants.primaryColor,
      topCardHeight: height >= 150 ? 150 : height * 0.2,
      bottomCardHeight: height >= 125 ? 125 : height * 0.2,
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
            image: NetworkImage(showcaseUrl),
            fit: BoxFit.scaleDown,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(EvaIcons.alertCircle),
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
                    text: name,
                    overflow: TextOverflow.fade,
                    maxWidth: width * .3,
                  ),
                ),
                QmText(
                  text: target,
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
              itemCount: sets.length,
              itemBuilder: (context, index) {
                final set = sets[index];
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
                duration: SimpleConstants.fastAnimationDuration,
                curve: Curves.bounceIn,
              ),
              icon: EvaIcons.arrowForward,
            ),
          )
        ],
      ),
    );
  }
}
