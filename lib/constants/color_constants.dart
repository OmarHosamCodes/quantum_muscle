import 'package:quantum_muscle/library.dart';

/// A class that contains constants for colors used in the application.
class ColorConstants {
  //? Main

  /// The primary color used in the application.
  static const Color primaryColor = Color(0xFF191919);

  /// The accent color used in the application.
  static const Color accentColor = Color(0xFF5a189a);

  /// The disabled color used in the application.
  static const Color disabledColor = Color(0xFF240046);

  /// The background color used in the application.
  static const Color backgroundColor = Color(0xFF0F0F0F);

  //? Secondary

  /// The color used for icons in the application.
  static const Color iconColor = Color(0xFFf0f0f0);

  /// The color used for text in the application.
  static const Color textColor = Color(0xFFf0f0f0);

  /// The secondary color used for text in the application.
  static const Color textSecondaryColor = Color(0xCCF0F0F0);

  /// The error color used in the application.
  static const Color errorColor = Color(0xFFF44336);

  /// The color used for logout in the application.
  static const Color logoutColor = errorColor;

  /// The color used for hints in the application.
  static const Color hintColor = backgroundColor;

  /// The color used for text in the drawer in the application.
  static const Color drawerTextColor = backgroundColor;

  /// The color used for text fields in the application.
  static const Color textFieldColor = primaryColor;

  /// The color used for the user's chat bubble in the application.
  static const Color userChatBubbleColor = primaryColor;

  /// The color used for the other user's chat bubble in the application.
  static const Color otherChatBubbleColor = accentColor;

  /// The color used for the user's chat bubble text in the application.
  static const Color userChatBubbleTextColor = textColor;

  /// The color used for the server's chat bubble in the application.
  static const Color serverChatBubbleColor = disabledColor;

  /// The color used for likes in the application.
  static const Color likeColor = errorColor;
}
