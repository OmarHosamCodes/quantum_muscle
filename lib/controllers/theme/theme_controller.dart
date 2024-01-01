import '/library.dart';

class ThemeController {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorConstants.iconColor),
      backgroundColor: Colors.transparent,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ColorConstants.textColor,
      unselectedLabelColor: ColorConstants.disabledColor,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorConstants.secondaryColor,
          width: 2.0,
        ),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.all<bool>(true),
      thumbColor: MaterialStateProperty.all<Color>(
        ColorConstants.primaryColor,
      ),
      trackColor: MaterialStateProperty.all<Color>(
        ColorConstants.secondaryColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: ColorConstants.disabledColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      endShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  );
}
