import '/library.dart';

class SmallAddWorkout extends StatelessWidget {
  const SmallAddWorkout({
    super.key,
    required this.width,
    required this.height,
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
      onTap: () => showModalBottomSheet(
        backgroundColor: ColorConstants.secondaryColor,
        context: context,
        builder: (context) => AddWorkoutBottomSheet(
          height: vHeight,
        ),
      ),
      child: QmIconButton(
        icon: EvaIcons.plus,
        onPressed: () => showModalBottomSheet(
          backgroundColor: ColorConstants.secondaryColor,
          context: context,
          builder: (context) => AddWorkoutBottomSheet(
            height: vHeight,
          ),
        ),
      ),
    );
  }
}

class AddWorkoutBottomSheet extends StatelessWidget {
  const AddWorkoutBottomSheet({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    final workoutNameTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final workoutUtil = WorkoutUtil();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final imageRef = ref.watch(workoutImageBytesProvider) ?? '';
              return QmBlock(
                isNormal: true,
                onTap: () => workoutUtil.chooseImageFromStorage(
                  ref: ref,
                  provider: workoutImageBytesProvider,
                ),
                color: ColorConstants.backgroundColor,
                width: double.maxFinite,
                height: height * .2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image(
                  image: MemoryImage(
                    base64Decode(imageRef),
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      EvaIcons.plus,
                      color: ColorConstants.iconColor,
                    );
                  },
                ),
              );
            },
          ),
          Form(
            key: formKey,
            child: QmTextField(
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
            builder: (context, ref, _) {
              final imageRef = ref.watch(workoutImageBytesProvider);
              return QmBlock(
                isGradient: true,
                onTap: () => workoutUtil.addWorkout(
                  formKey: formKey,
                  context: context,
                  workoutName: workoutNameTextController.text,
                  imageFile: imageRef!,
                  ref: ref,
                ),
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
