import 'package:quantum_muscle/library.dart';

class SmallAddWorkout extends StatelessWidget {
  const SmallAddWorkout({
    required this.width,
    required this.height,
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 5),
  });
  final double width;
  final double height;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final vHeight = MediaQuery.of(context).size.height;
    return QmBlock(
      width: width,
      height: height,
      margin: margin,
      isGradient: true,
      onTap: () => showModalBottomSheet<void>(
        backgroundColor: ColorConstants.secondaryColor,
        context: context,
        builder: (context) => _AddWorkoutBottomSheet(
          height: vHeight,
        ),
      ),
      child: QmIconButton(
        icon: EvaIcons.plus,
        onPressed: () => showModalBottomSheet<void>(
          backgroundColor: ColorConstants.secondaryColor,
          context: context,
          builder: (context) => _AddWorkoutBottomSheet(
            height: vHeight,
          ),
        ),
      ),
    );
  }
}

class _AddWorkoutBottomSheet extends StatelessWidget {
  const _AddWorkoutBottomSheet({required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    final workoutNameTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final workoutUtil = WorkoutUtil();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (_, ref, __) {
              final imageWatcher = ref.watch(workoutImageBytesProvider) ?? '';
              final networkImageWatcher =
                  ref.watch(workoutNetworkImageProvider) ?? '';

              return QmBlock(
                padding: const EdgeInsets.all(1),
                color: ColorConstants.backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: networkImageWatcher.isEmpty,
                      child: Flexible(
                        child: QmBlock(
                          onTap: () => workoutUtil.chooseImageFromStorage(
                            ref: ref,
                            provider: workoutImageBytesProvider,
                          ),
                          color: ColorConstants.backgroundColor,
                          width: 100,
                          height: height * .2,
                          borderRadius: BorderRadius.zero,
                          child: QmImageMemory(
                            source: imageWatcher,
                            fallbackIcon: EvaIcons.plus,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: imageWatcher.isEmpty,
                      child: Flexible(
                        child: Consumer(
                          builder: (_, WidgetRef ref, __) {
                            final publicWorkoutsWatcher =
                                ref.watch(publicWorkoutsProvider);
                            return publicWorkoutsWatcher.when(
                              data: (publicWorkouts) {
                                return QmBlock(
                                  onTap: () => context.push(Routes.addWorkoutR),
                                  color: ColorConstants.backgroundColor,
                                  width: 100,
                                  height: height * .2,
                                  borderRadius: BorderRadius.zero,
                                  child: QmImageNetwork(
                                    source: networkImageWatcher,
                                    fallbackIcon: EvaIcons.search,
                                  ),
                                );
                              },
                              error: (error, stackTrace) {
                                return QmText(text: error.toString());
                              },
                              loading: () => const Center(
                                child: QmCircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Form(
            key: formKey,
            child: QmTextField(
              fieldColor: ColorConstants.disabledColor,
              controller: workoutNameTextController,
              height: height * .1,
              width: double.maxFinite,
              hintText: S.current.AddWorkoutName,
              validator: (value) {
                if (ValidationController.validateName(value!) == false) {
                  return S.current.EnterValidName;
                }
                return null;
              },
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              final imageWatcher = ref.watch(workoutImageBytesProvider);
              final networkImageWatcher =
                  ref.watch(workoutNetworkImageProvider);
              return QmBlock(
                onTap: () {
                  if (networkImageWatcher != null) {
                    workoutUtil.addWorkout(
                      context: context,
                      formKey: formKey,
                      workoutName: workoutNameTextController.text,
                      image: networkImageWatcher,
                      ref: ref,
                      isLink: true,
                    );
                  } else {
                    workoutUtil.addWorkout(
                      formKey: formKey,
                      context: context,
                      workoutName: workoutNameTextController.text,
                      image: imageWatcher!,
                      ref: ref,
                      isLink: false,
                    );
                  }
                },
                height: height * .1,
                width: double.maxFinite,
                child: QmText(
                  text: S.current.AddWorkout,
                  maxWidth: double.maxFinite,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
