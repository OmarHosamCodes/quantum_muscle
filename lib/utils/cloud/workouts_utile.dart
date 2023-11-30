// ignore_for_file: use_build_context_synchronously

import '../../library.dart';

final imageBytesProvider = StateProvider<Uint8List?>((ref) => Uint8List(0));

class WorkoutUtile {
  File? imageFileToUpload;
  File? get getImageFileToUpload => imageFileToUpload!;
  set setImageFileToUpload(File imageFileToUpload) =>
      this.imageFileToUpload = imageFileToUpload;

  final firebaseAuth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  late User? user = firebaseAuth.currentUser;

  Future<void> chooseImageFromStorage(
      WidgetRef ref, StateProvider<Uint8List?> provider) async {
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

  Future<void> addWorkout({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String workoutName,
    required String imageFile,
  }) async {
    if (user != null) {
      try {
        final isValid = formKey.currentState!.validate();
        if (!isValid) return;

        // openQmLoaderDialog(context: context);
        final dateTime = DateTime.now();
        final perfectDateTime =
            "${dateTime.year}-${dateTime.month}-${dateTime.day}";
        final uniqueId = UniqueKey().toString().substring(0, 8);
        final workoutModel = WorkoutModel(
          workoutId: uniqueId,
          workoutName: workoutName,
          workoutImgEncoded: imageFile,
          workoutExercises: [],
          workoutCreationDate: perfectDateTime,
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(user!.uid)
            .collection(DBPathsConstants.usersUserworkoutsPath)
            .doc(workoutName)
            .set(workoutModel.toMap());
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(user!.uid)
            .update({"exercises": []});
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
