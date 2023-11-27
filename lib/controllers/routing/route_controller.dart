import '/library.dart';

class RoutingController {
  final router = GoRouter(
    initialLocation: RouteNameConstants.routingPage,
    routes: [
      GoRoute(
        path: RouteNameConstants.routingPage,
        builder: (context, state) => const RoutingScreen(),
      ),
      GoRoute(
        path: RouteNameConstants.forgotPasswordPage,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteNameConstants.loginPage,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNameConstants.registerPage,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNameConstants.homePage,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
