// ignore_for_file: use_build_context_synchronously

import '/library.dart';

class ProgramsUtil extends Utils {
  Future<void> addProgram({
    required BuildContext context,
    required String programName,
    required WidgetRef ref,
    required int programsLength,
  }) async {
    openQmLoaderDialog(context: context);
    if (programsLength >= 5) {
      context.pop();
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: S.current.YouReachedTheLimitOfPrograms,
      );
    } else {
      try {
        firebaseAnalytics.logEvent(
            name: AnalyticsEventNamesConstants.addProgram);
        final programModel = ProgramModel(
          id: const Uuid().v4().substring(0, 16),
          name: programName,
          trainerId: userUid!,
          traineesIds: [],
          workouts: [],
          creationDate: Timestamp.now(),
          restDayOrDays: [],
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
        ref.invalidate(userProvider(userUid!));
        ref.read(userProvider(userUid!));
        context.pop();
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

  Future<void> deleteProgram({
    required BuildContext context,
    required String programId,
    required List traineesIds,
    required WidgetRef ref,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.removeProgram);
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

      while (context.canPop()) {
        context.pop();
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

  Future<void> sendRequest({
    required BuildContext context,
    required String traineeId,
    required WidgetRef ref,
    required String programRequestId,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.sendRequest);
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
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.acceptRequest);
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
    openQmLoaderDialog(context: context);
    try {
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addProgramWorkout);

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

  Future<void> deleteWorkoutToProgram({
    required String workoutCollectionName,
    required BuildContext context,
    required String programId,
  }) async {
    openQmLoaderDialog(context: context);
    try {
      firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.removeProgramWorkout,
      );

      await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .delete();
      await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .update({
        ProgramModel.workoutsKey:
            FieldValue.arrayRemove([workoutCollectionName])
      });
      while (context.canPop()) {
        context.pop();
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

  Future<void> addSetToProgramWorkout({
    required String workoutCollectionName,
    required String exerciseDocName,
    required WidgetRef ref,
    required int indexToInsert,
    required String programId,
    required BuildContext context,
  }) async {
    try {
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addProgramSet);
      await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): S.current.WeightXReps,
          },
        },
        SetOptions(
          merge: true,
        ),
      );
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> addExerciesToProgramWorkout({
    required BuildContext context,
    required WidgetRef ref,
    required String workoutCollectionName,
    required String programId,
    required String programName,
    required String exerciseName,
    required String exerciseTarget,
    required String content,
    required String contentType,
    required bool isLink,
  }) async {
    openQmLoaderDialog(context: context);

    if (user != null) {
      try {
        firebaseAnalytics.logEvent(
            name: AnalyticsEventNamesConstants.addProgramExercise);
        final id = const Uuid().v4().toString().substring(0, 12);
        if (isLink) {
          ExerciseModel exercise = ExerciseModel(
            id: id,
            name: exerciseName,
            target: exerciseTarget,
            sets: {
              '0': S.current.WeightXReps,
            },
            contentURL: content,
            contentType: ExerciseContentType.image,
            creationDate: Timestamp.now(),
          );
          await firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId)
              .collection(DBPathsConstants.workoutsPath)
              .doc(workoutCollectionName)
              .collection(DBPathsConstants.exercisesPath)
              .doc("${exercise.name}-${exercise.target}-${exercise.id}")
              .set(exercise.toMap(), SetOptions(merge: true));

          await firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId)
              .collection(DBPathsConstants.workoutsPath)
              .doc(workoutCollectionName)
              .set(
            {
              WorkoutModel.exercisesKey: FieldValue.arrayUnion(
                [
                  "${exercise.name}-${exercise.target}-${exercise.id}",
                ],
              ),
            },
            SetOptions(merge: true),
          );
        } else {
          ExerciseModel exercise = ExerciseModel(
            id: id,
            name: exerciseName,
            target: exerciseTarget,
            sets: {
              '0': S.current.WeightXReps,
            },
            contentURL: '',
            contentType: ExerciseContentType.image,
            creationDate: Timestamp.now(),
          );
          Reference storageRef = firebaseStorage
              .ref()
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.programsPath)
              .child(programName)
              .child(workoutCollectionName)
              .child(DBPathsConstants.exercisesPath)
              .child("${exercise.name}-${exercise.target}-${exercise.id}.png");

          await storageRef.putString(content, format: PutStringFormat.base64);

          exercise.contentURL = await storageRef.getDownloadURL();

          await firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId)
              .collection(DBPathsConstants.workoutsPath)
              .doc(workoutCollectionName)
              .collection(DBPathsConstants.exercisesPath)
              .doc("${exercise.name}-${exercise.target}-${exercise.id}")
              .set(exercise.toMap(), SetOptions(merge: true));

          await firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId)
              .collection(DBPathsConstants.workoutsPath)
              .doc(workoutCollectionName)
              .set(
            {
              WorkoutModel.exercisesKey: FieldValue.arrayUnion(
                [
                  "${exercise.name}-${exercise.target}-${exercise.id}",
                ],
              ),
            },
            SetOptions(merge: true),
          );
        }
        ref.read(exerciseImageBytesProvider.notifier).state = null;
        context.pop();
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

  Future<void> changeSetToProgramWorkout({
    required GlobalKey<FormState>? formKey,
    required String workoutCollectionName,
    required String exerciseDocName,
    required BuildContext context,
    required WidgetRef ref,
    required String programId,
    required int indexToInsert,
    required String reps,
    required String weight,
  }) async {
    bool isValid = formKey!.currentState!.validate();
    if (!isValid) return;
    try {
      firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.changeProgramSet);
      await firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): "$weight x $reps",
          },
        },
        SetOptions(
          merge: true,
        ),
      );
      context.pop();
    } catch (e) {
      context.pop();
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }

    addSetToProgramWorkout(
      workoutCollectionName: workoutCollectionName,
      exerciseDocName: exerciseDocName,
      ref: ref,
      indexToInsert: indexToInsert + 1,
      programId: programId,
      context: context,
    );
  }
}
