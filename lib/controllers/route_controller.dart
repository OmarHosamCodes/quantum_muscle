import '/library.dart';

final router = GoRouter(
  initialLocation: RouteNameConstants.loginPage,
  routes: [
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
  ],
);
