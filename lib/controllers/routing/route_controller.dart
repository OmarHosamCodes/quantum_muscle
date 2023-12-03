import '/library.dart';

class RoutingController {
  static String initR = '/';
  static String homeR = '/home';
  static String authR = '/auth';
  static String workoutRootR = 'workout';
  static String workoutDetailsR = 'workout/:workoutId';

  static final router = GoRouter(
    initialLocation: initR,
    routes: [
      GoRoute(
        path: initR,
        builder: (context, state) => const RoutingScreen(),
        routes: [
          GoRoute(
            name: workoutRootR,
            path: workoutDetailsR,
            builder: (context, state) {
              final width = MediaQuery.of(context).size.width;
              final height = MediaQuery.of(context).size.height;
              return WorkoutDetailsScreen(
                workoutId: state.pathParameters['workoutId']!,
                arguments: state.extra! as Map<String, dynamic>,
                width: width,
                height: height,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: authR,
        builder: (context, state) => AuthScreen(
          key: state.pageKey,
        ),
      ),
    ],
    errorBuilder: (context, state) => RoutingErrorScreen(
      key: state.pageKey,
      exception: state.error.toString(),
    ),
  );
}
