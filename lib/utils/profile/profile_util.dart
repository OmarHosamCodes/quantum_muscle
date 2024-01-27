// ignore_for_file: use_build_context_synchronously

import '/library.dart';

final userProfileImageProvider = StateProvider<String?>((ref) => null);
final addImageProvider = StateProvider<String?>((ref) => null);

class ProfileUtil extends Utils {
  late final userRef =
      firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid);
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
        firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.changeProfile,
        );
        Reference storageRef = firebaseStorage
            .ref()
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child('${UserModel.profileImageURLKey}.png');
        storageRef
            .putString(userProfileImage!, format: PutStringFormat.base64)
            .then(
          (_) async {
            await userRef.set(
              {
                UserModel.nameKey: userName,
                UserModel.bioKey: userBio,
                UserModel.profileImageURLKey: await storageRef.getDownloadURL(),
              },
              SetOptions(merge: true),
            );
            ref.invalidate(userProvider);
            ref.read(userProvider(Utils().userUid!));
            ref.read(userProfileImageProvider.notifier).state = null;
            ref.invalidate(userProfileImageProvider);
            ref.read(userProfileImageProvider);
            context.go(Routes.myProfileR);
            context.pop();
          },
        );
      } catch (e) {
        context.pop();

        openQmDialog(
          context: context,
          title: S.of(context).Failed,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> addContent({
    required BuildContext context,
    required WidgetRef ref,
    required String contentURL,
    required int indexToInsert,
    required GlobalKey<FormState> formKey,
    required String title,
    required String description,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addContent,
      );
      openQmLoaderDialog(context: context);
      final id = const Uuid().v8();

      Reference storageRef = firebaseStorage
          .ref()
          .child(DBPathsConstants.usersPath)
          .child(userUid!)
          .child('$title$id.png');
      await storageRef.putString(contentURL, format: PutStringFormat.base64);
      ContentModel content = ContentModel(
        id: const Uuid().v8(),
        title: title,
        contentURL: await storageRef.getDownloadURL(),
        creationDate: Timestamp.now(),
        description: description,
        likes: [],
        comments: {},
      );
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .collection(DBPathsConstants.contentPath)
          .doc(content.id)
          .set(content.toMap());

      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .update({
        UserModel.contentKey: FieldValue.arrayUnion([content.id])
      });
      while (context.canPop()) {
        context.pop();
      }
      ref.invalidate(contentProvider);
      ref.read(contentProvider(Utils().userUid!));
      ref.read(addImageProvider.notifier).state = SimpleConstants.emptyString;
    } catch (e) {
      while (context.canPop()) {
        context.pop();
      }
      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> followOrUnFollow({
    required String userId,
    required BuildContext context,
    required WidgetRef ref,
    required bool isFollowing,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      if (isFollowing) {
        firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.unfollow,
        );
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
        ref.invalidate(userProvider);
        ref.read(userProvider(Utils().userUid!));
        ref.read(userProvider(userId));
      } else if (!isFollowing) {
        firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.follow,
        );
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
        ref.invalidate(userProvider);
        ref.read(userProvider(Utils().userUid!));
        ref.read(userProvider(userId));
      }
    } catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> likeOrDislikeContent({
    required String userId,
    required BuildContext context,
    required WidgetRef ref,
    required bool isLiked,
    required String contentDocID,
  }) async {
    try {
      firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addLike,
      );
      if (isLiked) {
        firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.removeLike,
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .collection(DBPathsConstants.contentPath)
            .doc(contentDocID)
            .set(
          {
            ContentModel.likesKey: FieldValue.arrayRemove([userUid])
          },
          SetOptions(merge: true),
        );
      } else {
        firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addLike,
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .collection(DBPathsConstants.contentPath)
            .doc(contentDocID)
            .set(
          {
            ContentModel.likesKey: FieldValue.arrayUnion([userUid])
          },
          SetOptions(merge: true),
        );
      }

      ref.invalidate(contentProvider);
      ref.read(contentProvider(userId));
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.toString(),
      );
    }
  }
}
