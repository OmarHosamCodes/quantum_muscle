import '/library.dart';

void openAddTraineeSheet(BuildContext context,
    {required String programRequestId}) {
  showModalBottomSheet(
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
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final traineeIdTextController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QmText(
            text: S.current.AddTrainee,
          ),
          QmTextField(
            fieldColor: ColorConstants.disabledColor,
            width: width * 0.8,
            height: height * 0.1,
            hintText: S.current.AddTraineeId,
            controller: traineeIdTextController,
          ),
          Consumer(
            builder: (_, ref, __) {
              return QmBlock(
                onTap: () => ProgramsUtil().sendRequest(
                  context: context,
                  traineeId: traineeIdTextController.text,
                  ref: ref,
                  programRequestId: programRequestId,
                ),
                width: width * 0.8,
                height: height * 0.1,
                child: QmText(
                  text: S.current.SendRequest,
                  maxWidth: double.maxFinite,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
