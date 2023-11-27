import '/library.dart';

class ThemeController {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorConstants.backgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorConstants.secondaryColor),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ColorConstants.secondaryColor,
      unselectedLabelColor: ColorConstants.secondaryColor,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: ColorConstants.primaryColor,
          width: 2.0,
        ),
      ),
    ),
  );
}
