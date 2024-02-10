import '/library.dart';

void openAddImage({
  required BuildContext context,
  required WidgetRef ref,
  required int indexToInsert,
}) {
  showModalBottomSheet(
    backgroundColor: ColorConstants.secondaryColor,
    context: context,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * .9,
      minHeight: MediaQuery.of(context).size.height * .9,
    ),
    builder: (context) {
      return _AddImageWidget(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        indexToInsert: indexToInsert,
      );
    },
  );
}

class _AddImageWidget extends StatelessWidget {
  const _AddImageWidget({
    required this.height,
    required this.indexToInsert,
    required this.width,
  });
  final double height;
  final double width;
  final int indexToInsert;

  @override
  Widget build(BuildContext context) {
    final imageNameTextController = TextEditingController();
    final imageDescriptionTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer(
                builder: (_, ref, __) {
                  final imageWatcher = ref.watch(addImageProvider) ??
                      SimpleConstants.emptyString;
                  return QmBlock(
                    isNormal: true,
                    onTap: () => Utils().chooseImageFromStorage(
                      ref: ref,
                      provider: addImageProvider,
                    ),
                    color: ColorConstants.backgroundColor,
                    width: width,
                    height: height * .2,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    child: QmImageMemory(
                      source: imageWatcher,
                      fallbackIcon: EvaIcons.plus,
                    ),
                  );
                },
              ),
              const Spacer(),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    QmTextField(
                      fieldColor: ColorConstants.disabledColor,
                      controller: imageNameTextController,
                      height: height * .1,
                      width: double.maxFinite,
                      hintText: S.current.AddImageName,
                      validator: (value) {
                        if (ValidationController.validateName(value!) ==
                            false) {
                          return S.current.EnterValidName;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    QmTextField(
                      fieldColor: ColorConstants.disabledColor,
                      controller: imageDescriptionTextController,
                      height: height * .35,
                      width: double.maxFinite,
                      isExpanded: true,
                      hintText: S.current.AddImageDescription,
                      validator: (value) {
                        if (ValidationController.validateDescription(value!) ==
                            false) {
                          return S.current.EnterValidDescription;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Consumer(
                builder: (_, ref, __) {
                  final imageWatcher = ref.watch(addImageProvider);
                  return QmBlock(
                    onTap: () => ProfileUtil().addContent(
                      formKey: formKey,
                      context: context,
                      ref: ref,
                      indexToInsert: indexToInsert,
                      contentURL: imageWatcher!,
                      title: imageNameTextController.text,
                      description: imageDescriptionTextController.text,
                    ),
                    height: height * .1,
                    width: double.maxFinite,
                    child: QmText(
                      text: S.current.AddImage,
                      maxWidth: double.maxFinite,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
