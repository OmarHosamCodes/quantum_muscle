// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

class ProfileUtil extends Utils {
  late final userRef =
      firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid);
  Future<void> updateProfile({
    required String? userName,
    required String? userBio,
    required BuildContext context,
    required WidgetRef ref,
    required GlobalKey<FormState> formKey,
  }) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    QmLoader.openLoader(context: context);
    if (user != null) {
      try {
        final profileImage = ref
            .read(
              chooseProvider,
            )
            .profileImage;
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.changeProfile,
        );
        final storageRef = firebaseStorage
            .child(DBPathsConstants.usersPath)
            .child(userUid!)
            .child('${UserModel.profileImageURLKey}.png');
        await storageRef
            .putString(profileImage!, format: PutStringFormat.base64)
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
            context
              ..go(Routes.myProfileR)
              ..pop();
          },
        );
      } catch (e) {
        QmLoader.closeLoader(context: context);

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
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addContent,
      );
      QmLoader.openLoader(context: context);
      final id = const Uuid().v8();

      final storageRef = firebaseStorage
          .child(DBPathsConstants.usersPath)
          .child(userUid!)
          .child('$title$id.png');
      await storageRef.putString(contentURL, format: PutStringFormat.base64);
      final content = ContentModel(
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
        UserModel.contentKey: FieldValue.arrayUnion([content.id]),
      });
      QmLoader.closeLoader(context: context);

      QmLoader.closeLoader(context: context);

      ref
        ..invalidate(contentProvider)
        ..read(contentProvider(Utils().userUid!));
    } catch (e) {
      QmLoader.closeLoader(context: context);

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
    QmLoader.openLoader(context: context);
    try {
      if (isFollowing) {
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.unfollow,
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid)
            .set(
          {
            UserModel.followingKey: FieldValue.arrayRemove([userId]),
          },
          SetOptions(merge: true),
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .set(
          {
            UserModel.followersKey: FieldValue.arrayRemove([userUid]),
          },
          SetOptions(merge: true),
        );
        QmLoader.closeLoader(context: context);
        ref
          ..invalidate(userProvider)
          ..read(userProvider(Utils().userUid!))
          ..read(userProvider(userId));
      } else if (!isFollowing) {
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.follow,
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userUid)
            .update({
          UserModel.followingKey: FieldValue.arrayUnion([userId]),
        });
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .update({
          UserModel.followersKey: FieldValue.arrayUnion([userUid]),
        });
        QmLoader.closeLoader(context: context);
        ref
          ..invalidate(userProvider)
          ..read(userProvider(Utils().userUid!))
          ..read(userProvider(userId));
      }
    } catch (e) {
      QmLoader.closeLoader(context: context);

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
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addLike,
      );
      if (isLiked) {
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.removeLike,
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .collection(DBPathsConstants.contentPath)
            .doc(contentDocID)
            .set(
          {
            ContentModel.likesKey: FieldValue.arrayRemove([userUid]),
          },
          SetOptions(merge: true),
        );
      } else {
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addLike,
        );
        await firebaseFirestore
            .collection(DBPathsConstants.usersPath)
            .doc(userId)
            .collection(DBPathsConstants.contentPath)
            .doc(contentDocID)
            .set(
          {
            ContentModel.likesKey: FieldValue.arrayUnion([userUid]),
          },
          SetOptions(merge: true),
        );
      }

      ref
        ..invalidate(contentProvider)
        ..read(contentProvider(userId));
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.of(context).Failed,
        message: e.toString(),
      );
    }
  }
}
