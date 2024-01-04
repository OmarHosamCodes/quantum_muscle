import '/library.dart';

class AddExerciseTile extends StatelessWidget {
  const AddExerciseTile({
    super.key,
    required this.width,
    required this.height,
    required this.indexToInsert,
    required this.workoutName,
    required this.id,
  });
  final double width;
  final double height;
  final int indexToInsert;
  final String workoutName;
  final String id;

  @override
  Widget build(BuildContext context) {
    final exerciseNameTextController = TextEditingController();
    final exerciseTargetTextController = TextEditingController();
    final ExerciseUtil exerciseUtil = ExerciseUtil.instance;
    final formKey = GlobalKey<FormState>();
    return Consumer(
      builder: (context, ref, _) {
        final exerciseImageRef = ref.watch(exerciseImageBytesProvider);

        return SlimyCard(
          onTap: () async {
            bool isValid = formKey.currentState!.validate();
            if (isValid) {
              await exerciseUtil.addExercise(
                formKey: formKey,
                context: context,
                ref: ref,
                workoutName: workoutName,
                workoutId: id,
                exerciseName: exerciseNameTextController.text,
                exerciseTarget: exerciseTargetTextController.text,
                indexToInsert: indexToInsert,
                showcaseFile: base64Encode(exerciseImageRef),
                showcaseType: ExerciseShowcaseConstants.image,
              );
            }
          },
          color: ColorConstants.primaryColor,
          topCardHeight: height >= 150 ? 150 : height * 0.2,
          bottomCardHeight: height >= 150 ? 150 : height * 0.2,
          borderRadius: 10,
          topCardWidget: QmBlock(
            width: width * .9,
            height: height * .2,
            isNormal: true,
            onTap: () => exerciseUtil.chooseImageFromStorage(
              ref: ref,
              provider: exerciseImageBytesProvider,
            ),
            child: Image(
              image: MemoryImage(exerciseImageRef!),
              fit: BoxFit.scaleDown,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.add,
                  color: ColorConstants.iconColor,
                );
              },
            ),
          ),
          bottomCardWidget: FittedBox(
            fit: BoxFit.fill,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  QmTextField(
                    height: height * .2,
                    width: width,
                    controller: exerciseNameTextController,
                    hintText: S.current.EnterExerciseName,
                    fontSize: 25,
                    validator: (value) {
                      if (!ValidationController.validateName(value!)) {
                        return S.current.EnterExerciseName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  QmTextField(
                    height: height * .2,
                    width: width,
                    controller: exerciseTargetTextController,
                    hintText: S.current.EnterExerciseTarget,
                    fontSize: 25,
                    validator: (value) {
                      if (!ValidationController.validateName(value!)) {
                        return S.current.EnterExerciseTarget;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
