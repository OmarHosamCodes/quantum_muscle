import '/library.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.arguments});
  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    final userName = arguments[UserModel.nameKey] as String;
    final userProfileImage = arguments[UserModel.profileImageKey] as String;
    final userBio = arguments[UserModel.bioKey] as String;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final nameTextcontroller = TextEditingController(text: userName);
    final bioTextcontroller = TextEditingController(text: userBio);
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
                    final profileImageProvider =
                        ref.watch(userProfileImageProvider);
                    return QmIconButton(
                      onPressed: () {
                        ProfileUtil().updateProfile(
                          context: context,
                          userName: nameTextcontroller.text,
                          userBio: bioTextcontroller.text,
                          userProfileImage:
                              profileImageProvider != userProfileImage
                                  ? profileImageProvider
                                  : userProfileImage,
                          ref: ref,
                        );
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
                final profileImageProvider =
                    ref.watch(userProfileImageProvider);

                return Center(
                  child: GestureDetector(
                    onTap: () => ProfileUtil.chooseImage(
                      ref: ref,
                      provider: userProfileImageProvider,
                    ),
                    child: Stack(
                      children: [
                        QmAvatar(
                          isNetworkImage:
                              profileImageProvider != userProfileImage,
                          radius: 60,
                          imageUrl: profileImageProvider != userProfileImage
                              ? userProfileImage
                              : profileImageProvider,
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
                              Icons.camera_alt,
                              color: ColorConstants.secondaryColor,
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
