import '/library.dart';

class RoutingController {
  static final router = GoRouter(
    initialLocation: Routes.initR,
    routes: [
      GoRoute(
        path: Routes.initR,
        builder: (context, state) => const RoutingScreen(),
        routes: [
          GoRoute(
            name: Routes.workoutRootR,
            path: Routes.workoutDetailsR,
            builder: (context, state) {
              return WorkoutDetailsScreen(
                workoutId: state.pathParameters['workoutId']!,
                arguments: state.extra! as Map<String, dynamic>,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.authR,
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
