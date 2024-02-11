import 'package:quantum_muscle/library.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({required this.arguments, super.key});
  final Map<String, dynamic> arguments;

  UserModel get user => arguments[UserModel.modelKey] as UserModel;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final nameTextcontroller = TextEditingController(text: user.name);
    final bioTextcontroller = TextEditingController(text: user.bio);
    final fromKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Column(
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
                  final imageWatcher = ref.watch(userProfileImageProvider);
                  return QmIconButton(
                    onPressed: () {
                      if (!(imageWatcher == null &&
                          nameTextcontroller.text == user.name &&
                          (bioTextcontroller.text == user.bio ||
                              bioTextcontroller.text ==
                                  SimpleConstants.emptyString))) {
                        ProfileUtil().updateProfile(
                          context: context,
                          userName: nameTextcontroller.text,
                          userBio: bioTextcontroller.text,
                          userProfileImage: imageWatcher,
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
            builder: (_, ref, __) {
              final imageWatcher = ref.watch(userProfileImageProvider);

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
                        imageUrl: imageWatcher,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  QmTextField(
                    height: height * .07,
                    width: width * 0.9,
                    controller: nameTextcontroller,
                    hintText: S.current.EnterNewName,
                    maxLength: 20,
                  ),
                  const SizedBox(height: 20),
                  QmTextField(
                    height: height * .07,
                    width: width * 0.9,
                    controller: bioTextcontroller,
                    hintText: S.current.EnterNewBio,
                    maxLength: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
