/// Represents the state of the forget password functionality.
class ForgetPasswordState {
  /// Creates a new instance of [ForgetPasswordState].
  ForgetPasswordState({
    required this.isEmailSent,
    required this.countDown,
  });

  /// Indicates whether the email has been sent successfully.
  bool isEmailSent;

  /// The countdown value for the reset password functionality.
  int countDown;

  /// Creates a copy of the current [ForgetPasswordState] instance with
  /// the provided changes.
  ForgetPasswordState copyWith({
    bool? isEmailSent,
    int? countDown,
  }) {
    return ForgetPasswordState(
      isEmailSent: isEmailSent ?? this.isEmailSent,
      countDown: countDown ?? this.countDown,
    );
  }
}
