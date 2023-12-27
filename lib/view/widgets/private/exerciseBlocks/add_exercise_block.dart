import '/library.dart';

class AddExerciseTile extends StatelessWidget {
  const AddExerciseTile({
    super.key,
    required this.width,
    required this.height,
    required this.indexToInsert,
    required this.workoutName,
  });
  final double width;
  final double height;
  final int indexToInsert;
  final String workoutName;

  @override
  Widget build(BuildContext context) {
    final exerciseNameTextController = TextEditingController();
    final exerciseTargetTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Consumer(
      builder: (context, ref, _) {
        final imageRef = ref.watch(exerciseImageBytesProvider);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SlimyCard(
            onTap: () {
              if (exerciseTargetTextController.text.isNotEmpty &&
                  exerciseNameTextController.text.isNotEmpty &&
                  imageRef.isNotEmpty) {
                ExerciseUtil().addExercise(
                  context: context,
                  formKey: formKey,
                  workoutName: workoutName,
                  exerciseName: exerciseNameTextController.text,
                  exerciseTarget: exerciseTargetTextController.text,
                  ref: ref,
                  indexToInsert: indexToInsert,
                  imageFile: base64.encode(imageRef),
                );
              }
            },
            color: ColorConstants.primaryColor,
            topCardHeight: height >= 150 ? 150 : height * 0.2,
            bottomCardHeight: width >= 150 ? 150 : height * 0.2,
            borderRadius: 10,
            topCardWidget: QmBlock(
              width: width * .9,
              height: height * .2,
              isNormal: true,
              onTap: () => ExerciseUtil.chooseExerciseImageFromStorage(
                ref: ref,
                provider: exerciseImageBytesProvider,
              ),
              child: Image(
                image: MemoryImage(imageRef!),
                fit: BoxFit.scaleDown,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.add,
                    color: ColorConstants.secondaryColor,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
