import '/library.dart';

class ThemeController {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
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
          width: 2.0,
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
      thickness: MaterialStateProperty.all<double>(5),
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
