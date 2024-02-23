// ignore_for_file: use_build_context_synchronously, strict_raw_type

import 'package:quantum_muscle/library.dart';

class ProgramUtil extends Utils {
  Future<void> addProgram({
    required BuildContext context,
    required String programName,
    required int programsLength,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) return;

    if (programsLength >= 5) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: S.current.YouReachedTheLimitOfPrograms,
      );
      return;
    }

    try {
      QmLoader.openLoader(context: context);
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addProgram,
      );
      final programModel = ProgramModel(
        id: const Uuid().v8(),
        name: programName,
        trainerId: userUid!,
        traineesIds: [],
        workouts: [],
        creationDate: Timestamp.now(),
        restDayOrDays: [],
      );

      final batch = firebaseFirestore.batch()
        ..set(
          firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programModel.id),
          programModel.toMap(),
          SetOptions(merge: true),
        )
        ..update(
          firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid),
          {
            UserModel.programsKey: FieldValue.arrayUnion([programModel.id]),
          },
        );

      await batch.commit();

      QmLoader.closeLoader(context: context);
    } catch (e) {
      QmLoader.closeLoader(context: context);
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> deleteProgram({
    required BuildContext context,
    required String programId,
    required List traineesIds,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.removeProgram,
      );

      final batch = firebaseFirestore.batch()
        ..delete(
          firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId),
        )
        ..update(
          firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid),
          {
            UserModel.programsKey: FieldValue.arrayRemove([programId]),
          },
        );

      for (final traineeId in traineesIds) {
        batch.update(
          firebaseFirestore
              .collection(DBPathsConstants.usersPath)
              .doc(traineeId as String?),
          {
            UserModel.programsKey: FieldValue.arrayRemove([programId]),
          },
        );
      }

      await batch.commit();

      while (context.canPop()) {
        QmLoader.closeLoader(context: context);
      }

      // ref
      //   ..invalidate(programsProvider)
      //   ..read(programsProvider)
      //   ..invalidate(userProvider(userUid!))
      //   ..read(userProvider(userUid!));
    } catch (e) {
      QmLoader.closeLoader(context: context);
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
    required String programRequestId,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.sendRequest,
      );

      await ChatUtil().startChat(
        userId: traineeId,
        context: context,
      );

      final userDocRef = firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(traineeId);
      final chatIdQuery = await userDocRef.get().then(
            (value) => (value.data()![UserModel.chatsKey] as List).firstWhere(
              (element) => (element as Map).containsValue(userUid),
            ),
          );

      // ignore: avoid_dynamic_calls
      final chatId = chatIdQuery.keys.first as String;

      await ChatUtil().addRequestMessage(
        chatId: chatId,
        message: S.current.WillYouJoinProgram,
        programRequestId: programRequestId,
      );

      QmLoader.closeLoader(context: context);
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
    required String programId,
    required String messageId,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.acceptRequest,
      );

      final batch = firebaseFirestore.batch()
        ..update(
          firebaseFirestore.collection(DBPathsConstants.usersPath).doc(userUid),
          {
            UserModel.programsKey: FieldValue.arrayUnion([programId]),
          },
        )
        ..update(
          firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId),
          {
            ProgramModel.traineesIdsKey: FieldValue.arrayUnion([userUid]),
          },
        );
      await batch.commit();

      await ChatUtil().removeMessage(
        chatId: chatId,
        messageId: messageId,
        context: context,
      );

      RoutingController().changeRoute(4);

      // ref
      //   ..invalidate(programsProvider)
      //   ..read(programsProvider)
      //   ..invalidate(userProvider(userUid!))
      //   ..read(userProvider(userUid!));

      QmLoader.closeLoader(context: context);
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
    QmLoader.openLoader(context: context);
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addProgramWorkout,
      );

      final programDocRef = firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId);
      final workoutExists = await programDocRef.get().then(
            (value) =>
                (value.data()![ProgramModel.workoutsKey] as List<dynamic>)
                    .contains('${workout.name}-${workout.id}'),
          );

      if (!workoutExists) {
        final batch = firebaseFirestore.batch()
          ..update(
            programDocRef,
            {
              ProgramModel.workoutsKey:
                  FieldValue.arrayUnion(['${workout.name}-${workout.id}']),
            },
          )
          ..set(
            programDocRef
                .collection(DBPathsConstants.workoutsPath)
                .doc('${workout.name}-${workout.id}'),
            workout.toMap(),
            SetOptions(merge: true),
          );

        final exercises = ref
            .watch(exercisesProvider('${workout.name}-${workout.id}'))
            .maybeWhen(
              data: (exercises) => exercises,
              orElse: () => <ExerciseModel>[],
            );

        for (final exercise in exercises) {
          batch.set(
            programDocRef
                .collection(DBPathsConstants.workoutsPath)
                .doc('${workout.name}-${workout.id}')
                .collection(DBPathsConstants.exercisesPath)
                .doc('${exercise.name}-${exercise.target}-${exercise.id}'),
            exercise.toMap(),
            SetOptions(merge: true),
          );
        }

        await batch.commit();

        QmLoader.closeLoader(context: context);
        ref
          ..invalidate(programsProvider)
          ..read(programsProvider)
          ..invalidate(userProvider(userUid!))
          ..read(userProvider(userUid!));
      } else {
        QmLoader.closeLoader(context: context);
        openQmDialog(
          context: context,
          title: S.current.TryAgain,
          message: S.current.WorkoutAlreadyExistsInProgram,
        );
      }
    } catch (e) {
      QmLoader.closeLoader(context: context);
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
    QmLoader.openLoader(context: context);
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.removeProgramWorkout,
      );

      final batch = firebaseFirestore.batch()
        ..delete(
          firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId)
              .collection(DBPathsConstants.workoutsPath)
              .doc(workoutCollectionName),
        )
        ..update(
          firebaseFirestore
              .collection(DBPathsConstants.programsPath)
              .doc(programId),
          {
            ProgramModel.workoutsKey:
                FieldValue.arrayRemove([workoutCollectionName]),
          },
        );
      await batch.commit();

      while (context.canPop()) {
        QmLoader.closeLoader(context: context);
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

  Future<void> addExerciesToProgramWorkout({
    required BuildContext context,
    required String workoutCollectionName,
    required String programId,
    required String programName,
    required String exerciseName,
    required String exerciseTarget,
    required String content,
    required String contentType,
    required bool isLink,
  }) async {
    QmLoader.openLoader(context: context);

    if (user != null) {
      try {
        await firebaseAnalytics.logEvent(
          name: AnalyticsEventNamesConstants.addProgramExercise,
        );
        final id = const Uuid().v8();
        final exercise = ExerciseModel(
          id: id,
          name: exerciseName,
          target: exerciseTarget,
          sets: {'0': S.current.WeightXReps},
          contentURL: '',
          contentType: ExerciseContentType.image,
          creationDate: Timestamp.now(),
        );

        if (isLink) {
          exercise.contentURL = content;
        } else {
          final storageRef = firebaseStorage
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.programsPath)
              .child(programName)
              .child(workoutCollectionName)
              .child(DBPathsConstants.exercisesPath)
              .child('${exercise.name}-${exercise.target}-${exercise.id}.png');

          await storageRef.putString(content, format: PutStringFormat.base64);
          exercise.contentURL = await storageRef.getDownloadURL();
        }

        final batch = firebaseFirestore.batch()
          ..set(
            firebaseFirestore
                .collection(DBPathsConstants.programsPath)
                .doc(programId)
                .collection(DBPathsConstants.workoutsPath)
                .doc(workoutCollectionName)
                .collection(DBPathsConstants.exercisesPath)
                .doc('${exercise.name}-${exercise.target}-${exercise.id}'),
            exercise.toMap(),
            SetOptions(merge: true),
          )
          ..update(
            firebaseFirestore
                .collection(DBPathsConstants.programsPath)
                .doc(programId)
                .collection(DBPathsConstants.workoutsPath)
                .doc(workoutCollectionName),
            {
              WorkoutModel.exercisesKey: FieldValue.arrayUnion(
                ['${exercise.name}-${exercise.target}-${exercise.id}'],
              ),
            },
          );
        await batch.commit();

        QmLoader.closeLoader(context: context);
      } catch (e) {
        QmLoader.closeLoader(context: context);
        openQmDialog(
          context: context,
          title: S.current.Failed,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> addSetToProgramWorkout({
    required String workoutCollectionName,
    required String exerciseDocName,
    required int indexToInsert,
    required String programId,
    required BuildContext context,
  }) async {
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addProgramSet,
      );

      final programDocRef = firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId);
      final exerciseDocRef = programDocRef
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName);

      await exerciseDocRef.set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): S.current.WeightXReps,
          },
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  Future<void> changeSetToProgramWorkout({
    required GlobalKey<FormState> formKey,
    required String workoutCollectionName,
    required String exerciseDocName,
    required BuildContext context,
    required String programId,
    required int indexToInsert,
    required String reps,
    required String weight,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.changeProgramSet,
      );

      final exerciseDocRef = firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName);

      await exerciseDocRef.set(
        {
          ExerciseModel.setsKey: {
            indexToInsert.toString(): '$weight x $reps',
          },
        },
        SetOptions(
          merge: true,
        ),
      );
      QmLoader.closeLoader(context: context);
    } catch (e) {
      QmLoader.closeLoader(context: context);
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }

    await addSetToProgramWorkout(
      workoutCollectionName: workoutCollectionName,
      exerciseDocName: exerciseDocName,
      indexToInsert: indexToInsert + 1,
      programId: programId,
      context: context,
    );
  }
}
