import '/library.dart';

class RoutingController {
  static RoutingController get instants => RoutingController();
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
        builder: (context, state) => SearchedProfile(
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
          chatId: state.pathParameters['chatId']!,
          chatUserId: state.pathParameters['chatUserId']!,
          arguments: state.extra! as Map<String, dynamic>,
        ),
      ),
    ],
    errorBuilder: (context, state) => RoutingErrorScreen(
      key: state.pageKey,
    ),
  );
  void changeDrawerRoute(int index, BuildContext context) {
    switch (index) {
      case 0:
        router.go(Routes.homeR);
        context.pop();
        break;
      case 1:
        router.go(Routes.chatsR);
        context.pop();
        break;
      case 2:
        router.go(Routes.myProfileR);
        context.pop();
        break;
      case 3:
        router.go(Routes.searchR);
        context.pop();
        break;
      case 4:
        router.go(Routes.programsR);
        context.pop();
        break;
      case 5:
        router.go(Routes.authR);
        context.pop();
        break;
    }
  }

  void changeRoute(int index) {
    switch (index) {
      case 0:
        router.go(Routes.homeR);
        break;
      case 1:
        router.go(Routes.chatsR);
        break;
      case 2:
        router.go(Routes.myProfileR);
        break;
      case 3:
        router.go(Routes.searchR);
        break;
      case 4:
        router.go(Routes.programsR);
        break;
      case 5:
        router.go(Routes.authR);
        break;
    }
  }
}
