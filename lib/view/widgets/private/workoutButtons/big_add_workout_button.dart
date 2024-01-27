import '/library.dart';

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
  final workoutUtil = WorkoutUtil();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return QmBlock(
      isGradient: true,
      isAnimated: isAnimated,
      onTap: isExpanded
          ? null
          : () {
              setState(() {
                height = widget.height * .4;
                isAnimated = true;
              });
              Future.delayed(
                SimpleConstants.slowAnimationDuration,
                () => setState(
                  () => isExpanded = true,
                ),
              );
            },
      margin: EdgeInsets.symmetric(
        horizontal: widget.width * .05,
      ),
      height: height,
      width: widget.width * .9,
      child: Center(
        child: isExpanded
            ? Form(
                key: formKey,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Consumer(
                        builder: (_, ref, __) {
                          String? imageWatcher =
                              ref.watch(workoutImageBytesProvider) ?? '';
                          return QmBlock(
                            borderRadius: SimpleConstants.borderRadius,
                            isNormal: true,
                            isAnimated: true,
                            onTap: () => workoutUtil.chooseImageFromStorage(
                              ref: ref,
                              provider: workoutImageBytesProvider,
                            ),
                            color: ColorConstants.backgroundColor,
                            width: widget.width * .3,
                            height: widget.height * .9,
                            child: QmImageMemory(
                              source: imageWatcher,
                              fallbackIcon: EvaIcons.plus,
                            ),
                          ).animate().fadeIn(
                                duration:
                                    SimpleConstants.verySlowAnimationDuration,
                              );
                        },
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
                            hintText: S.current.AddWorkoutName,
                            validator: (value) {
                              if (ValidationController.validateName(value!) ==
                                  false) {
                                return S.current.EnterValidName;
                              }
                              return null;
                            },
                          ),
                          Consumer(
                            builder: (_, ref, __) {
                              final imageWatcher =
                                  ref.watch(workoutImageBytesProvider);
                              return QmBlock(
                                isGradient: false,
                                color: ColorConstants.primaryColor,
                                onTap: () => workoutUtil.addWorkout(
                                  context: context,
                                  formKey: formKey,
                                  workoutName: workoutNameTextController.text,
                                  imageFile: imageWatcher!,
                                  ref: ref,
                                ),
                                height: widget.height * .1,
                                width: inputsWidth,
                                child: QmText(
                                  text: S.current.AddWorkout,
                                  maxWidth: widget.width * .5,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: widget.width * .05),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    EvaIcons.plusCircleOutline,
                    color: ColorConstants.iconColor,
                  ),
                  SizedBox(
                    width: widget.width * .05,
                  ),
                  QmText(
                    text: S.current.AddWorkout,
                    maxWidth: widget.width * .5,
                  ),
                ],
              ),
      ),
    );
  }
}
