// ignore_for_file: use_build_context_synchronously

import '/library.dart';

final userProfileImageProvider = StateProvider<String?>((ref) => null);
final addImageProvider = StateProvider<String?>((ref) => null);

class ProfileUtil extends Utils {
  late final userRef =
      firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid);
  File? imageFileToUpload;
  File? get getImageFileToUpload => imageFileToUpload!;
  set setImageFileToUpload(File imageFileToUpload) =>
      this.imageFileToUpload = imageFileToUpload;

  Future<void> updateProfile({
    required String? userName,
    required String? userBio,
    required String? userProfileImage,
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    openQmLoaderDialog(context: context);
    if (user != null) {
      try {
        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child('${UserModel.profileImageKey}.png');
        storageRef
            .putString(userProfileImage!, format: PutStringFormat.base64)
            .then(
          (_) async {
            await userRef.set(
              {
                UserModel.nameKey: userName,
                UserModel.bioKey: userBio,
                UserModel.profileImageKey: await storageRef.getDownloadURL(),
              },
              SetOptions(merge: true),
            );
            ref.invalidate(userFutureProvider);
            ref.read(userFutureProvider(Utils().userUid!));
            ref.read(userProfileImageProvider.notifier).state = null;
            ref.invalidate(userProfileImageProvider);
            ref.read(userProfileImageProvider);
            context.go(Routes.myProfileR);
            context.pop();
          },
        );
      } on FirebaseException catch (e) {
        context.pop();

        openQmDialog(
          context: context,
          title: S.of(context).Failed,
          message: e.message!,
        );
      }
    }
  }

  static Future<void> chooseImage({
    required WidgetRef ref,
    required StateProvider<String?> provider,
    required BuildContext context,
  }) async {
    openQmLoaderDialog(context: context);
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        final imageXFile = XFile(image.path);
        ref.read(provider.notifier).state =
            base64Encode(await imageXFile.readAsBytes());
        context.pop();
      } else if (await Permission.storage.request().isGranted) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        final imageFile = File(image!.path);

        ref.read(provider.notifier).state =
            base64Encode(await imageFile.readAsBytes());
        context.pop();
      } else {
        await Permission.storage.request();
        context.pop();
      }
    }
  }

  Future<void> addImage({
    required UserImageModel userImageModel,
    required BuildContext context,
    required WidgetRef ref,
    required String imageFile,
    required int indexToInsert,
    required GlobalKey<FormState> formKey,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    openQmLoaderDialog(context: context);

    await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(userUid)
        .set(
      {
        "images": FieldValue.arrayUnion(
          [
            {
              "img$indexToInsert": userImageModel.toMap(),
            },
          ],
        ),
      },
      SetOptions(merge: true),
    );
    ref.invalidate(userFutureProvider);
    ref.read(userFutureProvider(Utils().userUid!));
    ref.read(addImageProvider.notifier).state = SimpleConstants.emptyString;

    context.pop();
  }

  followOrUnFollow({
    required String userId,
    required BuildContext context,
    required WidgetRef ref,
    required bool isFollowing,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      if (isFollowing) {
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid)
            .set(
          {
            UserModel.followingKey: FieldValue.arrayRemove([userId])
          },
          SetOptions(merge: true),
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .set(
          {
            UserModel.followersKey: FieldValue.arrayRemove([userUid])
          },
          SetOptions(merge: true),
        );
        context.pop();
        ref.invalidate(userFutureProvider);
        ref.read(userFutureProvider(Utils().userUid!));
        ref.read(userFutureProvider(userId));
      } else if (!isFollowing) {
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid)
            .update({
          UserModel.followingKey: FieldValue.arrayUnion([userId])
        });
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .update({
          UserModel.followersKey: FieldValue.arrayUnion([userUid])
        });
        context.pop();
        ref.invalidate(userFutureProvider);

        ref.read(userFutureProvider(Utils().userUid!));
        ref.read(userFutureProvider(userId));
      }
    } on FirebaseException catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.message!,
      );
    }
  }
}
