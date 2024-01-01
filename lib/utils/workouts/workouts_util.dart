// ignore_for_file: use_build_context_synchronously

import '/library.dart';

final imageBytesProvider = StateProvider<Uint8List?>((ref) => Uint8List(0));

class WorkoutUtil extends Utils {
  static WorkoutUtil get instance => WorkoutUtil();
  File? imageFileToUpload;
  File? get getImageFileToUpload => imageFileToUpload!;
  set setImageFileToUpload(File imageFileToUpload) =>
      this.imageFileToUpload = imageFileToUpload;

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
    required WidgetRef ref,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    openQmLoaderDialog(context: context);

    if (user != null) {
      try {
        final id = const Uuid().v4().toString().substring(0, 12);

        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child(DBPathsConstants.usersUserWorkoutsPath)
            .child("$workoutName-$id")
            .child("$workoutName-showcase.png");

        storageRef.putString(imageFile, format: PutStringFormat.base64).then(
          (_) async {
            final workoutModel = WorkoutModel(
              id: id,
              name: workoutName,
              imgUrl: await storageRef.getDownloadURL(),
              exercises: [],
              creationDate: Timestamp.now(),
            );
            await firebaseFirestore
                .collection(DBPathsConstants.usersPath)
                .doc(userUid)
                .collection(DBPathsConstants.usersUserWorkoutsPath)
                .doc("$workoutName-$id")
                .set(
                  workoutModel.toMap(),
                  SetOptions(merge: true),
                )
                .then(
              (_) {
                ref.invalidate(workoutsStreamProvider);
                ref.read(workoutsStreamProvider(Utils.instants.userUid!));
                while (context.canPop()) {
                  context.pop();
                }
              },
            );
          },
        );
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
