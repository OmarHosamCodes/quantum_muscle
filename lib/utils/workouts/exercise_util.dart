// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_equals_and_hash_code_on_mutable_classes
// ignore_for_file: use_build_context_synchronously, unused_result, avoid_print

import 'package:quantum_muscle/library.dart';

/// Utility class for the exercises.
class ExerciseUtil extends Utils {
  /// Adds an exercise to the workout.
  Future<void> add({
    required BuildContext context,
    required String workoutCollectionName,
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
          name: AnalyticsEventNamesConstants.addExercise,
        );
        final id = const Uuid().v8();
        final exercisesCollection = usersCollection
            .doc(userUid)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .collection(DBPathsConstants.exercisesPath);

        ExerciseModel exercise;

        if (isLink) {
          exercise = ExerciseModel(
            id: id,
            name: exerciseName,
            target: exerciseTarget,
            sets: {'0': S.current.WeightXReps},
            contentURL: content,
            contentType: ExerciseContentType.image,
            creationDate: Timestamp.now(),
          );
        } else {
          final storageRef = firebaseStorage
              .child(DBPathsConstants.usersPath)
              .child(userUid!)
              .child(DBPathsConstants.workoutsPath)
              .child(workoutCollectionName)
              .child(DBPathsConstants.exercisesPath)
              .child('$exerciseName$exerciseTarget$id.png');

          await storageRef.putString(content, format: PutStringFormat.base64);
          exercise = ExerciseModel(
            id: id,
            name: exerciseName,
            target: exerciseTarget,
            sets: {'0': S.current.WeightXReps},
            contentURL: await storageRef.getDownloadURL(),
            contentType: ExerciseContentType.image,
            creationDate: Timestamp.now(),
          );
        }

        await exercisesCollection
            .doc('${exercise.name}-${exercise.target}-${exercise.id}')
            .set(exercise.toMap(), SetOptions(merge: true));

        await usersCollection
            .doc(userUid)
            .collection(DBPathsConstants.workoutsPath)
            .doc(workoutCollectionName)
            .set(
          {
            WorkoutModel.exercisesKey: FieldValue.arrayUnion(
              [
                '${exercise.name}-${exercise.target}-${exercise.id}',
              ],
            ),
          },
          SetOptions(merge: true),
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
    }
  }

  /// Adds a set to the exercise.
  Future<void> addSet({
    required String workoutCollectionName,
    required String exerciseDocName,
    required int indexToInsert,
    required BuildContext context,
  }) async {
    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.addSet,
      );
      const setsKey = ExerciseModel.setsKey;
      final weightXReps = S.current.WeightXReps;

      await usersCollection
          .doc(userUid)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          setsKey: {
            indexToInsert.toString(): weightXReps,
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

  /// Changes the set.
  Future<void> changeSet({
    required GlobalKey<FormState> formKey,
    required String workoutCollectionName,
    required String exerciseDocName,
    required BuildContext context,
    required int indexToInsert,
    required String reps,
    required String weight,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      await firebaseAnalytics.logEvent(
        name: AnalyticsEventNamesConstants.changeSet,
      );

      const setsKey = ExerciseModel.setsKey;
      final setString = '$weight x $reps';

      await usersCollection
          .doc(userUid)
          .collection(DBPathsConstants.workoutsPath)
          .doc(workoutCollectionName)
          .collection(DBPathsConstants.exercisesPath)
          .doc(exerciseDocName)
          .set(
        {
          setsKey: {
            indexToInsert.toString(): setString,
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

    await addSet(
      workoutCollectionName: workoutCollectionName,
      exerciseDocName: exerciseDocName,
      indexToInsert: indexToInsert + 1,
      context: context,
    );
  }

  /// Deletes the exercise.
  Future<List<(String, List<ExerciseTemplate>)>> getPublic() async {
    final names = await firebaseFirestore
        .collection(DBPathsConstants.publicPath)
        .doc(DBPathsConstants.exercisesPath)
        .get()
        .then((value) => List<String>.from(value.data()!['names'] as List));

    final finalList = <(String, List<ExerciseTemplate>)>[];

    for (final name in names) {
      final value = await firebaseStorage
          .child(DBPathsConstants.publicPath)
          .child(DBPathsConstants.exercisesPath)
          .child(name)
          .list();
      final templates = <ExerciseTemplate>[];
      for (final item in value.items) {
        final url = await item.getDownloadURL();
        final exerciseName =
            item.name.replaceAll('-', ' ').replaceAll('.png', '');
        final exercise = ExerciseTemplate(
          name: exerciseName,
          image: url,
          target: name,
        );
        templates.add(exercise);
      }

      finalList.add((name, templates));
    }

    return finalList;
  }
}

/// Represents the state of adding an exercise.
class ExerciseTemplate {
  /// Creates a new instance of [ExerciseTemplate].
  ExerciseTemplate({
    required this.name,
    required this.image,
    required this.target,
  });

  /// Creates an empty instance of [ExerciseTemplate].
  ExerciseTemplate.empty({
    this.name = '',
    this.image = '',
    this.target = '',
  });

  /// The name of the exercise.
  final String name;

  /// The image of the exercise.
  final String image;

  /// The target of the exercise.
  final String target;

  /// Creates a copy of the current [ExerciseTemplate] instance with the provided values.
  ExerciseTemplate copyWith({
    String? name,
    String? image,
    String? target,
  }) {
    return ExerciseTemplate(
      name: name ?? this.name,
      image: image ?? this.image,
      target: target ?? this.target,
    );
  }

  @override
  bool operator ==(covariant ExerciseTemplate other) {
    if (identical(this, other)) return true;

    return other.name == name && other.image == image && other.target == target;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ target.hashCode;
}
