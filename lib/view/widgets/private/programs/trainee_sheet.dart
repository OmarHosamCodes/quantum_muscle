// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quantum_muscle/library.dart';

void openAddTraineeSheet(
  BuildContext context, {
  required String programRequestId,
}) {
  showModalBottomSheet<void>(
    backgroundColor: ColorConstants.secondaryColor,
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            QmText(
              text: S.current.AddTrainee,
            ),
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
                    ref: ref,
                    programRequestId: programRequestId,
                  ),
                );
              },
            ),
            Consumer(
              builder: (_, ref, __) {
                return QmBlock(
                  onTap: () => programUtil.sendRequest(
                    context: context,
                    traineeId: traineeIdTextController.text,
                    ref: ref,
                    programRequestId: programRequestId,
                  ),
                  width: width * 0.8,
                  height: height * 0.1,
                  child: QmText(
                    text: S.current.SendRequest,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
