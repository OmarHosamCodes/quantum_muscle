import 'package:quantum_muscle/library.dart';

/// A class that contains the theme used in the application.
class ThemeController {
  /// The theme used in the application.
  static ThemeData theme = ThemeData(
    pageTransitionsTheme: NoTransitionsOnWeb(),
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: ColorConstants.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.accentColor,
      onPrimary: ColorConstants.textColor,
      onSecondary: ColorConstants.textColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      dragHandleColor: ColorConstants.accentColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorConstants.iconColor),
      backgroundColor: Colors.transparent,
    ),
    tabBarTheme: const TabBarTheme(
      dividerColor: ColorConstants.accentColor,
      labelColor: ColorConstants.textColor,
      unselectedLabelColor: ColorConstants.accentColor,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorConstants.accentColor,
          width: 2,
        ),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.all<bool>(true),
      thumbColor: MaterialStateProperty.all<Color>(
        ColorConstants.disabledColor,
      ),
      trackColor: MaterialStateProperty.all<Color>(
        ColorConstants.disabledColor,
      ),
      radius: const Radius.circular(10),
      thickness: MaterialStateProperty.all<double>(8),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ColorConstants.disabledColor,
      shape: RoundedRectangleBorder(),
      endShape: RoundedRectangleBorder(),
    ),
  );
}
