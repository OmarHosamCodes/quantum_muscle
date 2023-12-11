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
    ref.read(userFutureProvider);
    ref.read(userProfileImageProvider.notifier).state = '';
    context.go(Routes.myProfileR);
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
    ref.read(userFutureProvider);
    ref.read(addImageProvider.notifier).state = '';

    context.pop();
  }

  followOrUnFollow({
    required String userId,
    required BuildContext context,
  }) async {
    openQmLoaderDialog(context: context);
    final userDoc = await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(userId)
        .get();
    final List userFollowers = userDoc.get(UserModel.followersKey);
    if (userFollowers.contains(userId)) {
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .update({
        UserModel.followersKey: FieldValue.arrayRemove([userId])
      });
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userId)
          .update({
        UserModel.followingKey: FieldValue.arrayRemove([userUid])
      });
    } else {
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .update({
        UserModel.followersKey: FieldValue.arrayUnion([userId])
      });
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userId)
          .update({
        UserModel.followingKey: FieldValue.arrayUnion([userUid])
      });
    }
  }
}
