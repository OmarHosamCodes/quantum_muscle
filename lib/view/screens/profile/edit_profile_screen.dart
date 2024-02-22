import 'package:quantum_muscle/library.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({required this.arguments, super.key});
  final Map<String, dynamic> arguments;

  UserModel get user => arguments[UserModel.modelKey] as UserModel;
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textFieldWidth = width * .8;
    final nameTextcontroller = TextEditingController(text: user.name);
    final bioTextcontroller = TextEditingController(text: user.bio);
    final weightTextcontroller =
        TextEditingController(text: user.weight.values.last.toString());
    final heightTextcontroller = TextEditingController(
      text: user.height.values.last.toString(),
    );
    final ageTextcontroller = TextEditingController(
      text: user.age.toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: QmText(
          text: S.current.EditProfile,
        ),
        actions: [
          Consumer(
            builder: (_, ref, __) {
              final profileImage = ref
                  .watch(
                    chooseProvider,
                  )
                  .profileImage;
              return QmButton.icon(
                onPressed: () {
                  if (!(profileImage!.isEmpty &&
                      nameTextcontroller.text == user.name &&
                      (bioTextcontroller.text == user.bio ||
                          bioTextcontroller.text.isEmpty))) {
                    profileUtil.updateProfile(
                      context: context,
                      userName: nameTextcontroller.text,
                      userBio: bioTextcontroller.text,
                      ref: ref,
                      formKey: formKey,
                    );
                  }
                },
                icon: EvaIcons.checkmark,
              );
            },
          ),
        ],
      ),
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Consumer(
              builder: (_, ref, __) {
                final profileImage = ref
                        .watch(
                          chooseProvider,
                        )
                        .profileImage ??
                    SimpleConstants.emptyString;
                return GestureDetector(
                  onTap: () async =>
                      ref.read(chooseProvider.notifier).setProfileImage(
                            (await profileUtil.chooseImageFromStorage())!,
                          ),
                  child: Center(
                    child: Stack(
                      children: [
                        QmAvatar(
                          radius: 65,
                          imageUrl: profileImage.isEmpty
                              ? user.profileImageURL
                              : profileImage,
                          isNetworkImage: profileImage.isEmpty,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: ColorConstants.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              EvaIcons.camera,
                              color: ColorConstants.iconColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    width: textFieldWidth,
                    child: QmTextField(
                      textInputAction: TextInputAction.next,
                      controller: nameTextcontroller,
                      hintText: S.current.Name,
                      maxLength: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: textFieldWidth,
                    child: QmTextField(
                      textInputAction: TextInputAction.next,
                      controller: bioTextcontroller,
                      hintText: S.current.Bio,
                      isExpanded: true,
                    ),
                  ),
                  SizedBox(
                    width: textFieldWidth,
                    child: QmTextField(
                      textInputAction: TextInputAction.next,
                      controller: weightTextcontroller,
                      hintText: S.current.Weight,
                      maxLength: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: textFieldWidth,
                    child: QmTextField(
                      textInputAction: TextInputAction.done,
                      controller: heightTextcontroller,
                      hintText: S.current.Height,
                      isExpanded: true,
                    ),
                  ),
                  SizedBox(
                    width: textFieldWidth,
                    child: QmTextField(
                      textInputAction: TextInputAction.done,
                      controller: ageTextcontroller,
                      hintText: S.current.Age,
                      maxLength: 3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
