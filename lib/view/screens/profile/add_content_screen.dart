import 'package:quantum_muscle/library.dart';

class AddContentScreen extends StatefulWidget {
  const AddContentScreen({
    required this.arguments,
    super.key,
  });
  final Map<String, dynamic> arguments;

  @override
  State<AddContentScreen> createState() => _AddContentScreenState();
}

class _AddContentScreenState extends State<AddContentScreen> {
  final imageNameTextController = TextEditingController();
  final imageDescriptionTextController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final indexToInsert = widget.arguments['indexToInsert'] as int;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * .15, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (_, ref, __) {
                ref.watch(
                  chooseProvider.select((value) => value.addImage),
                );
                final addImage = ref
                    .read(
                      chooseProvider,
                    )
                    .addImage;

                return QmBlock(
                  onTap: () async =>
                      ref.read(chooseProvider.notifier).setAddImage(
                            (await profileUtil.chooseImageFromStorage())!,
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
                  child: QmImage.memory(
                    source: addImage,
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
                  SizedBox(
                    width: width * .8,
                    child: QmTextField(
                      textInputAction: TextInputAction.next,
                      fieldColor: ColorConstants.disabledColor,
                      controller: imageNameTextController,
                      hintText: S.current.AddImageName,
                      validator: (value) {
                        if (ValidationController.validateName(value!) ==
                            false) {
                          return S.current.EnterValidName;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: width * .8,
                    height: 200,
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return QmTextField(
                          textInputAction: TextInputAction.go,
                          fieldColor: ColorConstants.disabledColor,
                          controller: imageDescriptionTextController,
                          isExpanded: true,
                          hintText: S.current.AddImageDescription,
                          validator: (value) {
                            if (ValidationController.validateDescription(
                                  value!,
                                ) ==
                                false) {
                              return S.current.EnterValidDescription;
                            }
                            return null;
                          },
                          onEditingComplete: () => profileUtil.addContent(
                            formKey: formKey,
                            context: context,
                            ref: ref,
                            indexToInsert: indexToInsert,
                            contentURL: imageNameTextController.text,
                            title: imageNameTextController.text,
                            description: imageDescriptionTextController.text,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Consumer(
              builder: (_, ref, __) {
                ref.watch(
                  chooseProvider.select((value) => value.addImage),
                );
                final addImage = ref
                    .read(
                      chooseProvider,
                    )
                    .addImage;
                return QmBlock(
                  onTap: () => profileUtil.addContent(
                    formKey: formKey,
                    context: context,
                    ref: ref,
                    indexToInsert: indexToInsert,
                    contentURL: addImage,
                    title: imageNameTextController.text,
                    description: imageDescriptionTextController.text,
                  ),
                  height: height * .1,
                  width: double.maxFinite,
                  child: QmText(
                    text: S.current.AddImage,
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
