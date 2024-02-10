import '/library.dart';

final generalAnalyticsProvider =
    StreamProvider.family<GeneralAnalyticsModel, String>((ref, id) async* {
  UserModel userData = ref.watch(userProvider(id)).maybeWhen(
        data: (user) => user,
        orElse: () => UserModel.empty(),
      );
  List<ProgramModel> programs = ref.watch(programsProvider).maybeWhen(
        data: (programs) => programs,
        orElse: () => [
          ProgramModel.empty(),
        ],
      );
  List<WorkoutModel> workouts = ref.watch(workoutsProvider).maybeWhen(
        data: (workouts) => workouts,
        orElse: () => [
          WorkoutModel.empty(),
        ],
      );
  int getTotalTrainees(List<ProgramModel> programs) {
    int totalPrograms = 0;
    for (var program in programs) {
      totalPrograms += program.traineesIds.length;
    }
    return totalPrograms;
  }

  // final client = Client();
  // final url = Uri.parse('http://localhost:8080/');
  // final headers = {'Content-Type': 'application/json'};
  // late final request = Request('GET', url);
  // request.headers.addAll(headers);
  // final response = await client.send(request);
  // print(request.body);
  int totalTrainees = getTotalTrainees(programs);

  getTotalExercises(List<WorkoutModel> workouts) {
    int totalExercises = 0;
    for (var workout in workouts) {
      totalExercises += workout.exercises.length;
    }
    return totalExercises;
  }

  int totalExercises = getTotalExercises(workouts);
  GeneralAnalyticsModel analytics = GeneralAnalyticsModel(
    totalPrograms: userData.programs.length,
    totalTrainees: totalTrainees,
    totalWorkouts: workouts.length,
    totalExercises: totalExercises,
  );
  yield analytics;
});
