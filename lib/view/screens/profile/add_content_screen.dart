import 'package:quantum_muscle/library.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({
    required this.arguments,
    super.key,
  });
  final Map<String, dynamic> arguments;
  @override
  Widget build(BuildContext context) {
    final imageNameTextController = TextEditingController();
    final imageDescriptionTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final indexToInsert = arguments['indexToInsert'] as int;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * .2, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (_, ref, __) {
                final imageWatcher =
                    ref.watch(addImageProvider) ?? SimpleConstants.emptyString;
                return QmBlock(
                  onTap: () => Utils().chooseImageFromStorage(
                    ref: ref,
                    provider: addImageProvider,
                  ),
                  color: ColorConstants.disabledColor,
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
            const SizedBox(height: 15),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QmTextField(
                    fieldColor: ColorConstants.disabledColor,
                    controller: imageNameTextController,
                    height: height * .1,
                    width: double.maxFinite,
                    hintText: S.current.AddImageName,
                    validator: (value) {
                      if (ValidationController.validateName(value!) == false) {
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
    );
  }
}
