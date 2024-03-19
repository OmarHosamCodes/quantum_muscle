import 'package:quantum_muscle/library.dart';

/// Provider for the forget password notifier and state.
final forgetPasswordProvider =
    StateNotifierProvider<ForgetPasswordNotifier, ForgetPasswordState>(
  (ref) => ForgetPasswordNotifier(),
);
