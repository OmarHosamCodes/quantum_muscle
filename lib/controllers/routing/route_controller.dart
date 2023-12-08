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
            path: Routes.myProfileR,
            builder: (context, state) => ProfileScreen(
              key: state.pageKey,
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.authR,
        builder: (context, state) => AuthScreen(
          key: state.pageKey,
        ),
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
      GoRoute(
        name: Routes.editProfileRootR,
        path: Routes.profileEditR,
        builder: (context, state) => EditProfileScreen(
          key: state.pageKey,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
    ],
    errorBuilder: (context, state) => RoutingErrorScreen(
      key: state.pageKey,
      exception: state.error.toString(),
    ),
  );
  void changeRoute(int index) {
    switch (index) {
      case 0:
        router.go(Routes.homeR);
        break;
      case 1:
        router.go(Routes.chatR);
        break;
      case 2:
        router.go(Routes.myProfileR);
        break;
      case 3:
        router.go(Routes.authR);
        break;
    }
  }
}
