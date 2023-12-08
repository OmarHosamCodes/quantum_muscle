import '/library.dart';

class SmallAddWorkout extends StatelessWidget {
  const SmallAddWorkout({
    super.key,
    required this.width,
    required this.height,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return QmBlock(
      width: width,
      height: height,
      isGradient: true,
      onTap: () => showModalBottomSheet(
        backgroundColor: ColorConstants.primaryColorDark,
        context: context,
        builder: (context) => AddWorkoutBottomSheet(
          height: height,
        ),
      ),
      child: QmIconButton(
        icon: EvaIcons.plus,
        onPressed: () => showModalBottomSheet(
          backgroundColor: ColorConstants.primaryColorDark,
          context: context,
          builder: (context) => AddWorkoutBottomSheet(
            height: height,
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
    final workoutUtile = WorkoutUtil();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final imageRef = ref.watch(imageBytesProvider);
              return QmBlock(
                isNormal: true,
                onTap: () => workoutUtile.chooseImageFromStorage(
                  ref,
                  imageBytesProvider,
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
                    imageRef!,
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.add_a_photo_outlined,
                      color: ColorConstants.secondaryColor,
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
              hintText: S.of(context).AddWorkoutName,
              validator: (value) {
                if (ValidationController.validateName(value!) == false) {
                  return S.of(context).EnterValidName;
                }
                return null;
              },
            ),
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
                  canPop: true,
                ),
                height: height * .1,
                width: double.maxFinite,
                child: QmText(
                  text: S.of(context).AddWorkout,
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
