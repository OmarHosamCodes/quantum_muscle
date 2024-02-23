import 'package:quantum_muscle/library.dart';

final generalAnalyticsProvider =
    FutureProvider.family<GeneralAnalyticsModel, String>((ref, id) async {
  final userData = ref.watch(userProvider(id)).maybeWhen(
        data: (user) => user,
        orElse: UserModel.empty,
      );
  final programs = ref.watch(programsProvider).maybeWhen(
        data: (programs) => programs,
        orElse: () => [
          ProgramModel.empty(),
        ],
      );
  final workouts = ref.watch(workoutsProvider).maybeWhen(
        data: (workouts) => workouts,
        orElse: () => [
          WorkoutModel.empty(),
        ],
      );
  int getTotalTrainees(List<ProgramModel> programs) {
    var totalPrograms = 0;
    for (final program in programs) {
      totalPrograms += program.traineesIds.length;
    }
    return totalPrograms;
  }

  final totalTrainees = getTotalTrainees(programs);

  int getTotalExercises(List<WorkoutModel> workouts) {
    var totalExercises = 0;
    for (final workout in workouts) {
      totalExercises += workout.exercises.length;
    }
    return totalExercises;
  }

  final totalExercises = getTotalExercises(workouts);
  final analytics = GeneralAnalyticsModel(
    totalPrograms: userData.programs.length,
    totalTrainees: totalTrainees,
    totalWorkouts: workouts.length,
    totalExercises: totalExercises,
  );
  return analytics;
});
