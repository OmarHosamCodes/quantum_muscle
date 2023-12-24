// ignore_for_file: use_build_context_synchronously

import '/library.dart';

final userProfileImageProvider = StateProvider<String?>((ref) => '');
final addImageProvider = StateProvider<String?>((ref) => '');

class ProfileUtil extends Utils {
  late final userRef = firebaseFirestore.collection('users').doc(userUid);
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
  }) async {
    openQmLoaderDialog(context: context);
    await userRef.update({
      'name': userName,
      'bio': userBio,
      'image': userProfileImage,
    });
    ref.invalidate(userFutureProvider);
    ref.read(userFutureProvider(Utils().userUid!));
    ref.read(userProfileImageProvider.notifier).state = '';
    context.go(Routes.myProfileR);
    context.pop();
  }

  static Future<void> chooseImage({
    required WidgetRef ref,
    required StateProvider<String?> provider,
  }) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        final imageXFile = XFile(image.path);
        ref.read(provider.notifier).state =
            base64Encode(await imageXFile.readAsBytes());
      } else if (await Permission.storage.request().isGranted) {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        final imageFile = File(image!.path);

        ref.read(provider.notifier).state =
            base64Encode(await imageFile.readAsBytes());
      } else {
        await Permission.storage.request();
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
    ref.read(addImageProvider.notifier).state = '';

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
        ref.invalidate(searchedProfileFutureProvider);
        ref.read(userFutureProvider(Utils().userUid!));
        ref.read(searchedProfileFutureProvider(userId));
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
        ref.invalidate(searchedProfileFutureProvider);
        ref.read(userFutureProvider(Utils().userUid!));
        ref.read(searchedProfileFutureProvider(userId));
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
