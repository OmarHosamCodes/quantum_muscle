import 'package:quantum_muscle/library.dart';

class AddWorkoutBlock {
  static final formKey = GlobalKey<FormState>();
  static StatelessWidget big(BuildContext context) {
    final nameController = TextEditingController();
    return QmBlock(
      maxHeight: 250,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Flexible(
            child: QmBlock(
              color: ColorConstants.backgroundColor,
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final content = ref.watch(
                        chooseProvider.select(
                          (value) => value.workoutContent,
                        ),
                      ) ??
                      SimpleConstants.emptyString;

                  if (content.isNotEmpty) {
                    return QmImage.smart(
                      source: content,
                      fit: BoxFit.contain,
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: QmButton.icon(
                            icon: EvaIcons.plus,
                            onPressed: () async => ref
                                .read(chooseProvider.notifier)
                                .setWorkoutContent(
                                  await utils.chooseImageFromStorage(),
                                ),
                          ),
                        ),
                        ref.watch(publicWorkoutsProvider).maybeWhen(
                              data: (workouts) {
                                return Flexible(
                                  child: QmButton.icon(
                                    icon: EvaIcons.search,
                                    onPressed: () => context.push(
                                      Routes.addWorkoutR,
                                    ),
                                  ),
                                );
                              },
                              orElse: QmLoader.indicator,
                            ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Flexible(
            child: QmBlock(
              margin: const EdgeInsets.all(
                25,
              ),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return Form(
                          key: formKey,
                          child: QmTextField(
                            controller: nameController,
                            fontSize: 10,
                            textInputAction: TextInputAction.next,
                            hintText: S.current.Name,
                            validator: (value) {
                              ValidationController.validateName(value!);
                              return null;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final content = ref.watch(
                          chooseProvider.select(
                            (value) => value.workoutContent,
                          ),
                        );
                        return SizedBox(
                          width: double.infinity,
                          child: QmButton.text(
                            text: S.current.Add,
                            onPressed: () {
                              workoutUtil.add(
                                context: context,
                                name: nameController.text,
                                image: content!,
                                // ref: ref,
                                isLink: content.startsWith('http'),
                                formKey: formKey,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static StatelessWidget small(BuildContext context) {
    final nameController = TextEditingController();
    return QmBlock(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Flexible(
            child: QmBlock(
              color: ColorConstants.backgroundColor,
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final content = ref.watch(
                    chooseProvider.select(
                      (value) => value.workoutContent,
                    ),
                  );
                  if (content != null) {
                    return QmImage.smart(
                      source: content,
                      fit: BoxFit.contain,
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: QmButton.icon(
                            icon: EvaIcons.plus,
                            onPressed: () async => ref
                                .read(chooseProvider.notifier)
                                .setWorkoutContent(
                                  await utils.chooseImageFromStorage(),
                                ),
                          ),
                        ),
                        Consumer(
                          builder: (_, __, ___) =>
                              ref.watch(publicWorkoutsProvider).maybeWhen(
                                    data: (workouts) {
                                      return Flexible(
                                        child: QmButton.icon(
                                          icon: EvaIcons.search,
                                          onPressed: () => context.push(
                                            Routes.addWorkoutR,
                                          ),
                                        ),
                                      );
                                    },
                                    orElse: QmLoader.indicator,
                                  ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: QmBlock(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final content = ref.watch(
                              chooseProvider.select(
                                (value) => value.workoutContent,
                              ),
                            ) ??
                            SimpleConstants.emptyString;
                        return Form(
                          key: formKey,
                          child: QmTextField(
                            textInputAction: TextInputAction.go,
                            hintText: S.current.Name,
                            validator: (value) {
                              ValidationController.validateName(value!);
                              return null;
                            },
                            onEditingComplete: () => workoutUtil.add(
                              context: context,
                              name: nameController.text,
                              image: content,
                              // ref: ref,
                              isLink: content.startsWith('http'),
                              formKey: formKey,
                            ),
                            controller: nameController,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Flexible(
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        final content = ref.watch(
                              chooseProvider.select(
                                (value) => value.workoutContent,
                              ),
                            ) ??
                            SimpleConstants.emptyString;
                        return QmBlock(
                          color: ColorConstants.accentColor,
                          child: QmText(text: S.current.Add),
                          onTap: () => workoutUtil.add(
                            context: context,
                            name: nameController.text,
                            image: content,
                            // ref: ref,
                            isLink: content.startsWith('http'),
                            formKey: formKey,
                          ),
                        );
                      },
                    ),
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
