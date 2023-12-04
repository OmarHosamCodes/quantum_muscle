import '/library.dart';

class RoutingController {
  static final router = GoRouter(
    initialLocation: Routes.homeR,
    routes: [
      ShellRoute(
        builder: (context, state, child) => RoutingScreen(
          state: state,
          child: child,
        ),
        routes: [
          GoRoute(
            path: Routes.homeR,
            builder: (context, state) => HomeScreen(
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: Routes.chatR,
            builder: (context, state) => ChatScreen(
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: Routes.profileR,
            builder: (context, state) => ProfileScreen(
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: Routes.authR,
            pageBuilder: (context, state) => NoTransitionPage(
              child: AuthScreen(
                key: state.pageKey,
              ),
            ),
          ),
        ],
      ),
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
    errorBuilder: (context, state) => RoutingErrorScreen(
      key: state.pageKey,
      exception: state.error.toString(),
    ),
  );
}
