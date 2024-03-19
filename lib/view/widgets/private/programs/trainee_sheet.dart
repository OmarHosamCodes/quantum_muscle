import 'package:quantum_muscle/library.dart';

/// A widget that represents a sheet for adding trainees to a program.
void openAddTraineeSheet(
  BuildContext context, {
  required String programRequestId,
}) {
  showModalBottomSheet<void>(
    backgroundColor: ColorConstants.accentColor,
    context: context,
    builder: (context) => _AddTraineeSheet(
      programRequestId: programRequestId,
    ),
  );
}

class _AddTraineeSheet extends StatelessWidget {
  const _AddTraineeSheet({
    required this.programRequestId,
  });
  final String programRequestId;

  static final traineeIdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (_, WidgetRef ref, __) {
                return QmTextField(
                  textInputAction: TextInputAction.go,
                  fieldColor: ColorConstants.disabledColor,
                  hintText: S.current.AddTraineeId,
                  controller: traineeIdTextController,
                  onEditingComplete: _sendRequest,
                );
              },
            ),
            const SizedBox(height: 10),
            QmButton.text(
              onPressed: _sendRequest,
              text: S.current.SendRequest,
            ),
          ],
        ),
      ),
    );
  }

  void _sendRequest() {
    programUtil.sendRequest(
      traineeId: traineeIdTextController.text,
      programRequestId: programRequestId,
    );
  }
}
