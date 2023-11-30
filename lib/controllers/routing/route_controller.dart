import '/library.dart';

final _firebaseAuth = FirebaseAuth.instance;
final _user = _firebaseAuth.currentUser;

class RoutingController {
  static final router = GoRouter(
    initialLocation: RouteNameConstants.routingPage,
    routes: [
      GoRoute(
        path: RouteNameConstants.routingPage,
        builder: (context, state) => const RoutingScreen(),
        routes: [
          GoRoute(
            name: RouteNameConstants.workoutPageName,
            path: RouteNameConstants.workoutDetailsPage,
            builder: (context, state) => WorkoutDetailsScreen(
              workoutId: state.pathParameters['workoutId']!,
            ),
          ),
          GoRoute(
            name: RouteNameConstants.loginPage,
            path: RouteNameConstants.loginPage,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            name: RouteNameConstants.registerPage,
            path: RouteNameConstants.registerPage,
            builder: (context, state) => const RegisterScreen(),
          ),
        ],
      ),
    ],
  );
}
