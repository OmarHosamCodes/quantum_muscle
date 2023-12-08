import '/library.dart';

void lunchAddImageWidget({
  required BuildContext context,
  required WidgetRef ref,
  required int indexToInsert,
}) {
  showModalBottomSheet(
    backgroundColor: ColorConstants.primaryColorDark,
    context: context,
    builder: (context) {
      return _AddImageWidget(
        height: MediaQuery.of(context).size.height,
        indexToInsert: indexToInsert,
      );
    },
  );
}

class _AddImageWidget extends StatelessWidget {
  const _AddImageWidget({required this.height, required this.indexToInsert});
  final double height;
  final int indexToInsert;

  @override
  Widget build(BuildContext context) {
    final imageNameTextController = TextEditingController();
    final imageDescriptionTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, _) {
              final imageRef = ref.watch(addImageProvider);
              return QmBlock(
                isNormal: true,
                onTap: () => ProfileUtil.chooseImage(
                  ref: ref,
                  provider: addImageProvider,
                ),
                color: ColorConstants.backgroundColor,
                width: double.maxFinite,
                height: height * .2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image(
                  image: MemoryImage(
                    base64Decode(imageRef!),
                  ),
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.add_a_photo_outlined,
                      color: ColorConstants.secondaryColor,
                    );
                  },
                ),
              );
            },
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QmTextField(
                  controller: imageNameTextController,
                  height: height * .07,
                  width: double.maxFinite,
                  hintText: S.of(context).AddImageName,
                  validator: (value) {
                    if (ValidationController.validateName(value!) == false) {
                      return S.of(context).EnterValidName;
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * .01),
                QmTextField(
                  controller: imageDescriptionTextController,
                  height: height * .07,
                  width: double.maxFinite,
                  hintText: S.of(context).AddImageDescription,
                  validator: (value) {
                    if (ValidationController.validateDescription(value!) ==
                        false) {
                      return S.of(context).EnterValidName;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, _) {
              final imageRef = ref.watch(addImageProvider);
              return QmBlock(
                isGradient: true,
                onTap: () {
                  final dateTime = DateTime.now();

                  final perfectDateTime =
                      "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                  final imageModel = UserImageModel(
                    title: imageNameTextController.text,
                    imageEncoded: imageRef!,
                    createdAt: perfectDateTime,
                    description: imageDescriptionTextController.text,
                  );
                  ProfileUtil().addImage(
                    formKey: formKey,
                    context: context,
                    imageFile: imageRef,
                    ref: ref,
                    indexToInsert: indexToInsert,
                    userImageModel: imageModel,
                  );
                },
                height: height * .1,
                width: double.maxFinite,
                child: QmText(
                  text: S.of(context).AddImage,
                  maxWidth: double.maxFinite,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
