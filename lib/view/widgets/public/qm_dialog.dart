import '/library.dart';

void openQmDialog({
  required BuildContext context,
  required String title,
  required String message,
}) =>
    showDialog(
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
    return AlertDialog.adaptive(
      title: QmText(
        text: title,
        isHeadline: true,
      ),
      content: QmText(
        text: message,
        isSeccoundary: true,
      ),
      backgroundColor: ColorConstants.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: SimpleConstants.borderRadius,
      ),
    );
  }
}
