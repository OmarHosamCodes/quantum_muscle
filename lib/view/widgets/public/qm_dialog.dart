import '/library.dart';

void openQmLoaderDialog({required BuildContext context}) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const _QmLoaderDialog(),
    );

class _QmLoaderDialog extends StatelessWidget {
  const _QmLoaderDialog();

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Center(
        child: QmCircularProgressIndicator(),
      ),
    );
  }
}

class QmCircularProgressIndicator extends StatelessWidget {
  const QmCircularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: ColorConstants.primaryColor,
    );
  }
}

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
      backgroundColor: ColorConstants.primaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
