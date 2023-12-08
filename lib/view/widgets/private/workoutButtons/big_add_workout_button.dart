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
  final workoutUtile = WorkoutUtil();
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
                const Duration(milliseconds: 350),
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
                        builder: (context, ref, _) {
                          final imageRef = ref.watch(imageBytesProvider);
                          return QmBlock(
                            borderRadius: BorderRadius.circular(10),
                            isNormal: true,
                            isAnimated: true,
                            onTap: () => workoutUtile.chooseImageFromStorage(
                              ref,
                              imageBytesProvider,
                            ),
                            color: ColorConstants.backgroundColor,
                            width: widget.width * .3,
                            height: widget.height * .9,
                            child: Image(
                              image: MemoryImage(
                                imageRef!,
                              ),
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.add_a_photo_outlined,
                                  color: ColorConstants.secondaryColor,
                                );
                              },
                            ),
                          ).animate().fadeIn(
                                duration: const Duration(milliseconds: 500),
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
                            hintText: S.of(context).AddWorkoutName,
                            validator: (value) {
                              if (ValidationController.validateName(value!) ==
                                  false) {
                                return S.of(context).EnterValidName;
                              }
                              return null;
                            },
                          ),
                          Consumer(
                            builder: (context, ref, _) {
                              final imageRef = ref.watch(imageBytesProvider);
                              return QmBlock(
                                isGradient: true,
                                onTap: () => workoutUtile.addWorkout(
                                  formKey: formKey,
                                  context: context,
                                  workoutName: workoutNameTextController.text,
                                  imageFile: base64.encode(imageRef!),
                                  ref: ref,
                                  canPop: false,
                                ),
                                height: widget.height * .1,
                                width: inputsWidth,
                                child: QmText(
                                  text: S.of(context).AddWorkout,
                                  maxWidth: double.maxFinite,
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
