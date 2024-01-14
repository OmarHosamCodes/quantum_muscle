import '/library.dart';

void openAddTraineeSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: ColorConstants.secondaryColor,
    context: context,
    builder: (context) => const AddTraineeSheet(),
  );
}

class AddTraineeSheet extends StatelessWidget {
  const AddTraineeSheet({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final traineeIdTextController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QmText(
            text: S.current.AddTrainee,
          ),
          QmTextField(
            width: width * 0.8,
            height: height * 0.1,
            hintText: S.current.AddTraineeId,
            controller: traineeIdTextController,
          ),
          Consumer(builder: (context, ref, _) {
            return QmBlock(
              onTap: () => ProgramsUtil().sendRequest(
                context: context,
                traineeId: traineeIdTextController.text,
                ref: ref,
              ),
              width: width * 0.8,
              height: height * 0.1,
              child: QmText(
                text: S.current.SendRequest,
              ),
            );
          }),
        ],
      ),
    );
  }
}
