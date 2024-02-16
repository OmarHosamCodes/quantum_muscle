import 'package:quantum_muscle/library.dart';

class ThemeController {
  static ThemeData theme = ThemeData(
    pageTransitionsTheme: NoTransitionsOnWeb(),
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: ColorConstants.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: ColorConstants.primaryColor,
      secondary: ColorConstants.secondaryColor,
      onPrimary: ColorConstants.textColor,
      onSecondary: ColorConstants.textColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorConstants.iconColor),
      backgroundColor: Colors.transparent,
    ),
    tabBarTheme: const TabBarTheme(
      dividerColor: ColorConstants.secondaryColor,
      labelColor: ColorConstants.textColor,
      unselectedLabelColor: ColorConstants.secondaryColor,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorConstants.secondaryColor,
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
