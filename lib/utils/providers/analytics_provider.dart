import 'package:quantum_muscle/library.dart';

/// analytics provider for general analytics
final generalAnalyticsProvider =
    FutureProvider.family<GeneralAnalyticsModel, String>(
  (ref, id) async {
    final userData = ref.watch(userProvider(id)).maybeWhen(
          data: (user) => user,
          orElse: UserModel.empty,
        );

    final programs = ref.watch(programsProvider).maybeWhen(
          data: (programs) => programs,
          orElse: () => [ProgramModel.empty()],
        );

    final workouts = ref.watch(workoutsProvider).maybeWhen(
          data: (workouts) => workouts,
          orElse: () => [WorkoutModel.empty()],
        );

    int getTotalTrainees(List<ProgramModel> programs) => programs.fold(
          0,
          (total, program) => total + program.traineesIds.length,
        );

    int getTotalExercises(List<WorkoutModel> workouts) =>
        workouts.fold(0, (total, workout) => total + workout.exercises.length);

    final totalTrainees = getTotalTrainees(programs);
    final totalExercises = getTotalExercises(workouts);

    final analytics = GeneralAnalyticsModel(
      totalPrograms: userData.programs.length,
      totalTrainees: totalTrainees,
      totalWorkouts: workouts.length,
      totalExercises: totalExercises,
    );

    return analytics;
  },
);
