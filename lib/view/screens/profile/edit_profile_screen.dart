import 'package:quantum_muscle/library.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({required this.arguments, super.key});
  final Map<String, dynamic> arguments;

  UserModel get user => arguments[UserModel.modelKey] as UserModel;
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final nameTextcontroller = TextEditingController(text: user.name);

    final bioTextcontroller = TextEditingController(text: user.bio);
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                QmIconButton(
                  onPressed: () => context.pop(),
                  icon: EvaIcons.arrowBack,
                ),
                QmText(
                  text: S.current.EditProfile,
                ),
                Consumer(
                  builder: (_, ref, __) {
                    ref.watch(
                      chooseProvider.select((value) => value.profileImage),
                    );
                    final profileImage = ref
                        .read(
                          chooseProvider,
                        )
                        .profileImage;
                    return QmIconButton(
                      onPressed: () {
                        if (!(profileImage.isEmpty &&
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
            const SizedBox(height: 20),
            Consumer(
              builder: (_, ref, __) {
                ref.watch(
                  chooseProvider.select((value) => value.profileImage),
                );
                final profileImage = ref
                    .read(
                      chooseProvider,
                    )
                    .profileImage;
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
                        // Container(
                        //   height: 130,
                        //   width: 130,
                        //   decoration: const BoxDecoration(
                        //     color: ColorConstants.primaryColor,
                        //     shape: BoxShape.circle,
                        //   ),
                        //   child: QmImage.smart(
                        //     source: profileImage.isEmpty
                        //         ? user.profileImageURL
                        //         : profileImage,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
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
                    width: width * .8,
                    child: QmTextField(
                      textInputAction: TextInputAction.next,
                      controller: nameTextcontroller,
                      hintText: S.current.EnterNewName,
                      maxLength: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: width * .8,
                    child: QmTextField(
                      textInputAction: TextInputAction.done,
                      controller: bioTextcontroller,
                      hintText: S.current.EnterNewBio,
                      isExpanded: true,
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
