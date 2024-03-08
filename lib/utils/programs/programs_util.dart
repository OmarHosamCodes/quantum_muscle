// ignore_for_file: use_build_context_synchronously, strict_raw_type

import 'package:quantum_muscle/library.dart';

/// This class provides utility methods for managing programs.
class ProgramUtil extends Utils {
  /// Adds a program to the database.
  ///
  /// The [context] parameter specifies the build context.
  /// The [programName] parameter specifies the name of the program.
  /// The [programsLength] parameter specifies the length of the programs list.
  /// The [formKey] parameter specifies the form key for validation.
  ///
  /// Throws an exception if an error occurs.
  Future<void> addProgram({
    required BuildContext context,
    required String programName,
    required int programsLength,
    required GlobalKey<FormState> formKey,
  }) async {
    // Validate the form
    if (!formKey.currentState!.validate()) return;

    // Check if the programs length has reached the limit
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

      // Log the event to Firebase Analytics
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addProgram,
      );

      // Create a new program model
      final programModel = ProgramModel(
        id: const Uuid().v8(),
        name: programName,
        trainerId: userUid!,
        traineesIds: [],
        workouts: [],
        creationDate: Timestamp.now(),
        restDayOrDays: [],
      );

      // Create a batch to perform multiple operations atomically
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

      // Commit the batch
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

  /// Deletes a program from the database.
  ///
  /// The [context] parameter specifies the build context.
  /// The [programId] parameter specifies the ID of the program to delete.
  /// The [traineesIds] parameter specifies the list of trainee IDs associated
  ///  with the program.
  /// Throws an exception if an error occurs.
  Future<void> deleteProgram({
    required BuildContext context,
    required String programId,
    required List traineesIds,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      // Log the event to Firebase Analytics
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.removeProgram,
      );

      // Create a batch to perform multiple operations atomically
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

      // Remove the program from the trainees' lists
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

      // Commit the batch
      await batch.commit();

      while (context.canPop()) {
        QmLoader.closeLoader(context: context);
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

  /// Sends a program request to a trainee.
  ///
  /// The [context] parameter specifies the build context.
  /// The [traineeId] parameter specifies the ID of the trainee.
  /// The [programRequestId] parameter specifies the ID of the program request.
  ///
  /// Throws an exception if an error occurs.
  Future<void> sendRequest({
    required BuildContext context,
    required String traineeId,
    required String programRequestId,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      // Log the event to Firebase Analytics
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.sendRequest,
      );

      // Start a chat with the trainee
      await ChatUtil().startChat(
        userId: traineeId,
        context: context,
      );

      // Get the chat ID for the trainee
      final userDocRef = firebaseFirestore
          .collection(DBPathsConstants.usersPath)
          .doc(traineeId);
      final chatIdQuery = await userDocRef.get().then(
            (value) => (value.data()![UserModel.chatsKey] as List).firstWhere(
              (element) => (element as Map).containsValue(userUid),
            ),
          ) as Map<String, dynamic>;

      // Get the chat ID
      final chatId = chatIdQuery.keys.first;

      // Add a request message to the chat
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

  /// Accepts a program request from a trainee.
  ///
  /// The [context] parameter specifies the build context.
  /// The [chatId] parameter specifies the ID of the chat.
  /// The [programId] parameter specifies the ID of the program.
  /// The [messageId] parameter specifies the ID of the message.
  ///
  /// Throws an exception if an error occurs.
  Future<void> acceptRequest({
    required BuildContext context,
    required String chatId,
    required String programId,
    required String messageId,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      // Log the event to Firebase Analytics
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.acceptRequest,
      );

      // Create a batch to perform multiple operations atomically
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

      // Remove the request message from the chat
      await ChatUtil().removeMessage(
        chatId: chatId,
        messageId: messageId,
        context: context,
      );

      // Change the route to the programs page
      RoutingController().changeRoute(Routes.programsR);

      QmLoader.closeLoader(context: context);
    } catch (e) {
      openQmDialog(
        context: context,
        title: S.current.Failed,
        message: e.toString(),
      );
    }
  }

  /// Adds a workout to a program.
  ///
  /// The [context] parameter specifies the build context.
  /// The [programId] parameter specifies the ID of the program.
  /// The [workout] parameter specifies the workout model to add.
  /// The [ref] parameter specifies the widget reference.
  ///
  /// Throws an exception if an error occurs.
  Future<void> addWorkoutToProgram({
    required BuildContext context,
    required String programId,
    required WorkoutModel workout,
    required WidgetRef ref,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      // Log the event to Firebase Analytics
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addProgramWorkout,
      );

      // Check if the workout already exists in the program
      final programDocRef = firebaseFirestore
          .collection(DBPathsConstants.programsPath)
          .doc(programId);
      final workoutExists = await programDocRef.get().then(
            (value) =>
                (value.data()![ProgramModel.workoutsKey] as List<dynamic>)
                    .contains('${workout.name}-${workout.id}'),
          );

      if (!workoutExists) {
        // Create a batch to perform multiple operations atomically
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

        // Get the exercises for the workout
        final exercises = ref
            .watch(exercisesProvider('${workout.name}-${workout.id}'))
            .maybeWhen(
              data: (exercises) => exercises,
              orElse: () => <ExerciseModel>[],
            );

        // Add the exercises to the workout
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

        // Commit the batch
        await batch.commit();

        QmLoader.closeLoader(context: context);

        // Invalidate and read the providers
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

  /// Deletes a workout from a program.
  ///
  /// The [workoutCollectionName] parameter specifies
  /// the name of the workout collection.
  /// The [context] parameter specifies the build context.
  /// The [programId] parameter specifies the ID of the program.
  ///
  /// Throws an exception if an error occurs.
  Future<void> deleteWorkoutToProgram({
    required String workoutCollectionName,
    required BuildContext context,
    required String programId,
  }) async {
    QmLoader.openLoader(context: context);
    try {
      // Log the event to Firebase Analytics
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.removeProgramWorkout,
      );

      // Create a batch to perform multiple operations atomically
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

  /// Adds exercises to a program workout.
  ///
  /// The [context] parameter specifies the build context.
  /// The [workoutCollectionName] parameter specifies the name
  /// of the workout collection.
  /// The [programId] parameter specifies the ID of the program.
  /// The [programName] parameter specifies the name of the program.
  /// The [exerciseName] parameter specifies the name of the exercise.
  /// The [exerciseTarget] parameter specifies the target of the exercise.
  /// The [content] parameter specifies the content of the exercise.
  /// The [contentType] parameter specifies the type of the content.
  /// The [isLink] parameter specifies whether the content is a link or not.
  ///
  /// Throws an exception if an error occurs.
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

  /// Deletes an exercise from a program workout.
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

  /// Adds a set to a program workout.
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
}
