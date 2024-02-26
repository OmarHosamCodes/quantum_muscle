// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quantum_muscle/library.dart';

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
                  onEditingComplete: () => programUtil.sendRequest(
                    context: context,
                    traineeId: traineeIdTextController.text,
                    // ref: ref,
                    programRequestId: programRequestId,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Consumer(
              builder: (_, ref, __) {
                return QmButton.text(
                  onPressed: () => programUtil.sendRequest(
                    context: context,
                    traineeId: traineeIdTextController.text,
                    // ref: ref,
                    programRequestId: programRequestId,
                  ),
                  text: S.current.SendRequest,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
