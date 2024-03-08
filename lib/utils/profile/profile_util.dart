// ignore_for_file: use_build_context_synchronously

import 'package:quantum_muscle/library.dart';

/// utility class for profile related operations
class ProfileUtil extends Utils {
  /// Reference to the users collection in Firestore.

  late final userRef = usersCollection.doc(userUid);

  /// Updates the user's profile information.
  ///
  /// This method takes in the [userName], [userBio], [context], [ref],
  /// and [formKey] as required parameters.
  /// It validates the form using the [formKey] and
  /// updates the user's profile information in the Firestore database.
  /// If the user is not null, it uploads the profile image to Firebase Storage
  /// and updates the user document in Firestore.
  /// Finally, it invalidates the [userProvider],
  /// navigates to the user's profile page, and closes the current page.
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

  /// Adds content to the user's profile.
  ///
  /// This method takes in the [context], [ref], [contentURL], [indexToInsert], [formKey], [title], and [description] as required parameters.
  /// It validates the form using the [formKey] and adds the content to the user's profile in the Firestore database.
  /// It uploads the content to Firebase Storage and updates the user document in Firestore.
  /// Finally, it invalidates the [contentProvider] and reads the updated content for the user.
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

  /// Follows or unfollows a user.
  ///
  /// This method takes in the [userId], [context], [ref], and [isFollowing] as required parameters.
  /// It follows or unfollows the user based on the value of [isFollowing].
  /// It updates the following and followers lists in the Firestore database for both the current user and the target user.
  /// Finally, it invalidates the [userProvider] and reads the updated user information for both users.
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

  /// Likes or dislikes a content.
  ///
  /// This method takes in the [userId], [context], [ref], [isLiked], and [contentDocID] as required parameters.
  /// It likes or dislikes the content based on the value of [isLiked].
  /// It updates the likes list in the Firestore database for the content.
  /// Finally, it invalidates the [contentProvider] and reads the updated content for the user.
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
