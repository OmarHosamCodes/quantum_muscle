import '../../../library.dart';

class BigAddWorkout extends StatefulWidget {
  const BigAddWorkout({
    super.key,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;

  @override
  State<BigAddWorkout> createState() => _BigAddWorkoutState();
}

class _BigAddWorkoutState extends State<BigAddWorkout> {
  late double height = widget.height * .2;
  bool isAnimated = false;
  bool isExpanded = false;
  final workoutNameTextController = TextEditingController();
  final workoutDescriptionTextController = TextEditingController();
  static const double inputsWidth = 250;
  @override
  Widget build(BuildContext context) {
    return QmBlock(
      isAnimated: isAnimated,
      onTap: () {
        setState(() {
          height = widget.height * .4;
          isAnimated = true;
        });
        Future.delayed(const Duration(milliseconds: 250),
            () => setState(() => isExpanded = true));
      },
      margin: EdgeInsets.symmetric(
        horizontal: widget.width * .05,
      ),
      height: height,
      width: widget.width * .9,
      child: Center(
        child: isExpanded
            ? Row(
                children: [
                  QmBlock(
                    onTap: () {},
                    color: ColorConstants.backgroundColor,
                    width: widget.width * .3,
                    height: widget.height * .9,
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      color: ColorConstants.secondaryColor,
                    ),
                  ),
                  SizedBox(width: widget.width * .05),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        QmTextField(
                          height: widget.height * .1,
                          width: inputsWidth,
                          controller: workoutNameTextController,
                          hintText: S.of(context).AddWorkoutName,
                        ),
                        QmTextField(
                          height: widget.height * .1,
                          width: inputsWidth,
                          controller: workoutDescriptionTextController,
                          hintText: S.of(context).AddWorkoutDescription,
                        ),
                        QmBlock(
                          onTap: () {},
                          height: widget.height * .1,
                          width: inputsWidth,
                          child: QmText(
                            text: S.of(context).AddWorkout,
                            maxWidth: double.maxFinite,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: widget.width * .05),
                ],
              )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 500))
                .shimmer()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    EvaIcons.plusCircleOutline,
                    color: ColorConstants.secondaryColor,
                  ),
                  SizedBox(
                    width: widget.width * .05,
                  ),
                  QmText(
                    text: S.of(context).AddWorkout,
                    maxWidth: widget.width,
                  ),
                ],
              ),
      ),
    );
  }
}
