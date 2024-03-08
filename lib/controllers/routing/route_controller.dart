import 'package:quantum_muscle/library.dart';

/// A class that contains the routes used in the application.
class RoutingController {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  /// The router used in the application.
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.homeR,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
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
            name: Routes.chatsRootR,
            path: Routes.chatsR,
            builder: (context, state) => ChatsScreen(
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: Routes.myProfileR,
            builder: (context, state) => ProfileScreen(
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: Routes.searchR,
            builder: (context, state) => SearchScreen(
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: Routes.programsR,
            builder: (context, state) => ProgramsScreen(
              key: state.pageKey,
            ),
          ),
        ],
      ),
      GoRoute(
        name: Routes.programRootR,
        path: Routes.programDetailsR,
        builder: (context, state) => ProgramDetailsScreen(
          key: state.pageKey,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        name: Routes.profileRootR,
        path: Routes.profileR,
        builder: (context, state) => SearchedProfileScreen(
          key: state.pageKey,
          userId: state.pathParameters[UserModel.idKey]!,
        ),
      ),
      GoRoute(
        name: Routes.workoutRootR,
        path: Routes.workoutDetailsR,
        builder: (context, state) => WorkoutDetailsScreen(
          key: state.pageKey,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        name: Routes.editProfileRootR,
        path: Routes.profileEditR,
        builder: (context, state) => EditProfileScreen(
          key: state.pageKey,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        name: Routes.chatRootR,
        path: Routes.chatR,
        builder: (context, state) => ChatScreen(
          key: state.pageKey,
          chatId: state.pathParameters[ChatModel.idKey]!,
          chatUserId: state.pathParameters[ChatModel.userIdKey]!,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        name: Routes.contentRootR,
        path: Routes.contentDetailsR,
        builder: (context, state) => ContentDetailsScreen(
          key: state.pageKey,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        name: Routes.addContentRootR,
        path: Routes.addContentR,
        builder: (context, state) => AddContentScreen(
          key: state.pageKey,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
      GoRoute(
        name: Routes.addWorkoutRootR,
        path: Routes.addWorkoutR,
        builder: (context, state) => AddWorkoutScreen(
          key: state.pageKey,
        ),
      ),
      GoRoute(
        name: Routes.addExerciseRootR,
        path: Routes.addExerciseR,
        builder: (context, state) => AddExerciseScreen(
          key: state.pageKey,
        ),
      ),
    ],
    errorBuilder: (context, state) => RoutingErrorScreen(
      key: state.pageKey,
      error: state.error.toString(),
    ),
  );

  /// The navigator used in the application.
  void changeDrawerRoute(String route, BuildContext context) {
    router.go(route);
    context.pop();
  }

  /// The navigator used in the application.
  void changeRoute(
    String route,
  ) =>
      router.go(route);
}
