// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class ProgramsUtil extends Utils {
  Future<void> addProgram({
    required BuildContext context,
    required String programName,
    required WidgetRef ref,
  }) async {
    final programModel = ProgramModel(
      id: const Uuid().v4().substring(0, 16),
      name: programName,
      trainerId: userUid!,
      traineesIds: [],
      workouts: [],
      creationDate: Timestamp.now(),
    );

    await firebaseFirestore
        .collection(DBPathsConstants.programsPath)
        .doc(programModel.id)
        .set(
          programModel.toMap(),
          SetOptions(merge: true),
        );
    await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(userUid)
        .set(
      {
        UserModel.programsKey: FieldValue.arrayUnion(
          [programModel.id],
        ),
      },
      SetOptions(merge: true),
    );
    ref.invalidate(programsProvider);
    ref.read(programsProvider);
  }

  Future<void> deleteProgram({
    required BuildContext context,
    required String programId,
    required List traineesIds,
    required WidgetRef ref,
  }) async {
    openQmLoaderDialog(context: context);
    await firebaseFirestore
        .collection(DBPathsConstants.programsPath)
        .doc(programId)
        .delete();
    await firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .doc(userUid)
        .update({
      UserModel.programsKey: FieldValue.arrayRemove(
        [programId],
      ),
    });

    for (var traineeId in traineesIds) {
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(traineeId)
          .update({
        UserModel.programsKey: FieldValue.arrayRemove(
          [programId],
        ),
      });
    }
    ref.invalidate(programsProvider);
    ref.read(programsProvider);
    ref.invalidate(userProvider(userUid!));
    ref.read(userProvider(userUid!));
    while (context.canPop()) {
      context.pop();
    }
  }

  Future<void> sendRequest({
    required BuildContext context,
    required String traineeId,
    required WidgetRef ref,
    required String programRequestId,
  }) async {
    try {
      openQmLoaderDialog(context: context);
      ChatUtil().startChat(
        userId: traineeId,
        context: context,
        ref: ref,
      );
      final userDocRef = firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(traineeId);
      final chatId = await userDocRef.get().then((value) =>
          (value.data()![UserModel.chatsKey] as List)
              .where((element) => (element as Map).values.contains(userUid!)));
      ChatUtil().addRequestMessage(
        chatId: chatId.first.keys.first,
        message: S.current.WillYouJoinProgram,
        programRequestId: programRequestId,
      );
      context.pop();
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> acceptRequest({
    required BuildContext context,
    required String chatId,
    required WidgetRef ref,
    required String programId,
    required String messageId,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      await firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(userUid)
          .set({
        UserModel.programsKey: FieldValue.arrayUnion(
          [programId],
        )
      }, SetOptions(merge: true));
      await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .update(
        {
          ProgramModel.traineesIdsKey: FieldValue.arrayUnion(
            [userUid],
          )
        },
      );
      await ChatUtil().removeMessage(
        chatId: chatId,
        messageId: messageId,
        context: context,
      );
      RoutingController().changeRoute(4);

      ref.invalidate(programsProvider);
      ref.read(programsProvider);
      ref.invalidate(userProvider(userUid!));
      ref.read(userProvider(userUid!));
      context.pop();
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> addWorkoutToProgram({
    required BuildContext context,
    required String programId,
    required WorkoutModel workout,
    required WidgetRef ref,
  }) async {
    try {
      openQmLoaderDialog(context: context);

      if (await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .get()
          .then((value) => (value.data()![ProgramModel.workoutsKey]
                  as List<dynamic>)
              .where((element) => element == "${workout.name}-${workout.id}")
              .isEmpty)) {
        await firebaseFirestore
            .collection(DBPathsConstants.programsPath)
            .doc(programId)
            .set(
          {
            ProgramModel.workoutsKey: FieldValue.arrayUnion(
              ["${workout.name}-${workout.id}"],
            ),
          },
          SetOptions(merge: true),
        );
        await firebaseFirestore
            .collection(DBPathsConstants.programsPath)
            .doc(programId)
            .collection(DBPathsConstants.workoutsPath)
            .doc("${workout.name}-${workout.id}")
            .set(
              workout.toMap(),
              SetOptions(merge: true),
            );
        ref.watch(exercisesProvider("${workout.name}-${workout.id}")).maybeWhen(
          data: (exercises) async {
            for (var exercise in exercises) {
              await firebaseFirestore
                  .collection(DBPathsConstants.programsPath)
                  .doc(programId)
                  .collection(DBPathsConstants.workoutsPath)
                  .doc("${workout.name}-${workout.id}")
                  .collection(DBPathsConstants.exercisesPath)
                  .doc("${exercise.name}-${exercise.target}-${exercise.id}")
                  .set(
                    exercise.toMap(),
                    SetOptions(merge: true),
                  );
            }
          },
          orElse: () {
            return;
          },
        );

        context.pop();
      } else {
        context.pop();
        openQmDialog(
          context: context,
          title: S.current.TryAgain,
          message: S.current.WorkoutAlreadyExistsInProgram,
        );
      }
    } catch (e) {
      context.pop();

      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }
}
