import 'package:quantum_muscle/library.dart';

/// add content screen
class AddContentScreen extends StatefulWidget {
  /// const constructor for the [AddContentScreen]
  const AddContentScreen({
    required this.arguments,
    super.key,
  });

  /// arguments
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
    bool isTablet() {
      return ResponsiveBreakpoints.of(context).largerThan(MOBILE);
    }

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: isTablet()
            ? EdgeInsets.symmetric(
                vertical: 20,
                horizontal: width * .2,
              )
            : const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (_, ref, __) {
                final addImage = ref
                        .watch(
                          chooseProvider,
                        )
                        .addImage ??
                    SimpleConstants.emptyString;

                return QmBlock(
                  onTap: () async =>
                      ref.read(chooseProvider.notifier).setAddImage(
                            (await profileUtil.chooseImageFromStorage())!,
                          ),
                  width: width,
                  height: height * .2,
                  borderRadius: BorderRadius.circular(10),
                  child: QmImage.smart(
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
                    width: double.infinity,
                    child: QmTextField(
                      textInputAction: TextInputAction.next,
                      fieldColor: ColorConstants.disabledColor,
                      controller: imageNameTextController,
                      hintText: S.current.Name,
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
                    width: double.infinity,
                    height: 200,
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return QmTextField(
                          textInputAction: TextInputAction.go,
                          fieldColor: ColorConstants.disabledColor,
                          controller: imageDescriptionTextController,
                          isExpanded: true,
                          hintText: S.current.Description,
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
                final addImage = ref
                    .watch(
                      chooseProvider,
                    )
                    .addImage;
                return QmBlock(
                  color: ColorConstants.accentColor,
                  onTap: () => profileUtil.addContent(
                    formKey: formKey,
                    context: context,
                    ref: ref,
                    indexToInsert: indexToInsert,
                    contentURL: addImage!,
                    title: imageNameTextController.text,
                    description: imageDescriptionTextController.text,
                  ),
                  height: height * .1,
                  width: double.maxFinite,
                  child: QmText(
                    text: S.current.Add,
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
