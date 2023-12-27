// ignore_for_file: use_build_context_synchronously, unused_result

import '/library.dart';

final exerciseImageBytesProvider =
    StateProvider<Uint8List?>((ref) => Uint8List(0));

class ExerciseUtil extends Utils {
  File? imageFileToUpload;
  File? get getImageFileToUpload => imageFileToUpload!;
  set setImageFileToUpload(File imageFileToUpload) =>
      this.imageFileToUpload = imageFileToUpload;

  static Future<void> chooseExerciseImageFromStorage(
      {required WidgetRef ref,
      required StateProvider<Uint8List?> provider}) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        final imageXFile = XFile(image.path);
        ref.read(provider.notifier).state = await imageXFile.readAsBytes();
      } else if (await Permission.storage.request().isGranted) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        final imageFile = File(image!.path);

        ref.read(provider.notifier).state = await imageFile.readAsBytes();
      } else {
        await Permission.storage.request();
      }
    }
  }

  Future<void> addExercise({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String workoutName,
    required String exerciseName,
    required String exerciseTarget,
    required String imageFile,
    required WidgetRef ref,
    required int indexToInsert,
  }) async {
    if (user != null) {
      try {
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;

        final exerciseModel = ExerciseModel(
          exerciseName: exerciseName,
          exerciseImgEncoded: imageFile,
          exerciseTarget: exerciseName,
          exerciseSets: [
            SimpleConstants.emptyString,
            SimpleConstants.emptyString,
            SimpleConstants.emptyString,
            SimpleConstants.emptyString,
          ],
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid)
            .collection(DBPathsConstants.usersUserWorkoutsPath)
            .doc(workoutName)
            .set(
          {
            'workoutExercises': FieldValue.arrayUnion(
              [
                {
                  "E$indexToInsert": exerciseModel.toMap(),
                }
              ],
            )
          },
          SetOptions(merge: true),
        );
        ref.invalidate(workoutsStreamProvider);
        ref.read(workoutsStreamProvider);
      } on FirebaseException catch (e) {
        openQmDialog(
          context: context,
          title: S.of(context).Failed,
          message: e.message!,
        );
      }
    }
  }
}
