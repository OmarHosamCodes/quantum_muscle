import 'package:quantum_muscle/library.dart';

void openQmDialog({
  required BuildContext context,
  required String title,
  required String message,
}) =>
    showDialog<void>(
      context: context,
      builder: (context) => _QmDialog(
        title: title,
        message: message,
      ),
    );

class _QmDialog extends StatelessWidget {
  const _QmDialog({
    required this.title,
    required this.message,
  });
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstants.accentColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QmText(
              text: title,
              isHeadline: true,
            ),
            QmSimpleText(
              text: message,
              isSeccoundary: true,
            ),
          ],
        ),
      ),
      // shape: RoundedRectangleBorder(
      //   borderRadius: SimpleConstants.borderRadius,
      // ),
    );
  }
}
