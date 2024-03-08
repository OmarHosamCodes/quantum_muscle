import 'package:quantum_muscle/library.dart';

/// A class that contains simple constants used in the application.
class SimpleConstants {
  /// An empty string constant.
  static const String emptyString = '';

  /// The default font family used in the application.
  static const String fontFamily = 'ubuntu';

  /// The locale code for English.
  static const String englishLocale = 'en';

  /// The locale code for Arabic.
  static const String arabicLocale = 'ar';

  /// The duration for fast animations, in milliseconds.
  static const Duration fastAnimationDuration = Duration(milliseconds: 250);

  /// The duration for slow animations, in milliseconds.
  static const Duration slowAnimationDuration = Duration(milliseconds: 350);

  /// The duration for very slow animations, in milliseconds.
  static const Duration verySlowAnimationDuration = Duration(milliseconds: 500);

  /// The duration for disabled animations, which is zero.
  static const Duration disabledDuration = Duration.zero;

  /// The border radius used in the application.
  static BorderRadius borderRadius = BorderRadius.circular(10);
}
