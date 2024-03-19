import 'package:quantum_muscle/library.dart';

/// A widget that displays a loader indicator.
class QmLoader extends StatelessWidget {
  /// Creates a loader indicator.
  ///
  /// The [key] parameter is used to specify a [Key] that uniquely identifies
  /// this widget in the widget tree.
  ///
  /// The [value] parameter is used to specify the progress value of the loader.
  const QmLoader.indicator({super.key, this.value});

  /// Opens the loader dialog.
  ///
  /// The [context] parameter is the build context.
  static void openLoader({required BuildContext context}) => showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Dialog(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          child: Center(
            child: QmLoader.indicator(),
          ),
        ),
      );

  /// Closes the loader dialog.
  ///
  /// The [context] parameter is the build context.
  static void closeLoader({required BuildContext context}) => context.pop();

  /// Loader Closes outomaticaly after 3 seconds
  static void openAndCloseLoaderWithDelay({required BuildContext context}) {
    openLoader(context: context);

    Future.delayed(
      const Duration(seconds: 3),
      () => closeLoader(context: context),
    );
  }

  /// The progress value of the loader.
  final double? value;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorConstants.accentColor,
      value: value,
    );
  }
}
