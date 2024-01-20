import '/library.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key, required this.arguments});
  final Map<String, dynamic> arguments;

  UserModel get user => arguments[UserModel.modelKey] as UserModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final nameTextcontroller = TextEditingController(text: user.name);
    final bioTextcontroller = TextEditingController(text: user.bio);
    final fromKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
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
                  builder: (context, ref, _) {
                    final imageSource = ref.watch(userProfileImageProvider);
                    return QmIconButton(
                      onPressed: () {
                        if (!(imageSource == null &&
                            nameTextcontroller.text == user.name &&
                            (bioTextcontroller.text == user.bio ||
                                bioTextcontroller.text ==
                                    SimpleConstants.emptyString))) {
                          ProfileUtil().updateProfile(
                            context: context,
                            userName: nameTextcontroller.text,
                            userBio: bioTextcontroller.text,
                            userProfileImage: imageSource!,
                            ref: ref,
                            formKey: fromKey,
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
              builder: (context, ref, _) {
                final imageSource = ref.watch(userProfileImageProvider);

                return GestureDetector(
                  onTap: () => Utils().chooseImageFromStorage(
                    ref: ref,
                    provider: userProfileImageProvider,
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        QmAvatar(
                          isNetworkImage: false,
                          radius: 65,
                          imageUrl: imageSource,
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
              key: fromKey,
              child: Column(
                children: [
                  EditProfileTextField(
                    height: height * 0.07,
                    width: width * 0.9,
                    controller: nameTextcontroller,
                    hintText: S.current.EnterNewName,
                    maxLength: 20,
                    validator: (value) {
                      if (ValidationController.validateName(value!) == false) {
                        return S.current.EnterValidName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  EditProfileTextField(
                    height: height * 0.3,
                    width: width * 0.9,
                    controller: bioTextcontroller,
                    hintText: S.current.EnterNewBio,
                    maxLength: 250,
                    maxLines: 3,
                    validator: (value) {
                      if (ValidationController.validateBio(value!) == false) {
                        return S.current.EnterValidBio;
                      }
                      return null;
                    },
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
