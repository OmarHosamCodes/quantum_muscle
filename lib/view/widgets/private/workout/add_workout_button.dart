import 'package:quantum_muscle/library.dart';

class AddWorkoutBlock {
  static final formKey = GlobalKey<FormState>();
  static StatelessWidget big(BuildContext context) {
    final nameController = TextEditingController();
    return QmBlock(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Flexible(
            child: QmBlock(
              color: ColorConstants.backgroundColor,
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final content = ref.watch(
                    addWorkoutNotifierProvider.select(
                      (value) => value.content,
                    ),
                  );

                  if (content != null) {
                    return QmImage.smart(
                      source: content,
                      fit: BoxFit.contain,
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: QmIconButton(
                            icon: EvaIcons.plus,
                            onPressed: () async => ref
                                .read(addWorkoutNotifierProvider.notifier)
                                .setContent(
                                  (await utils.chooseImageFromStorage())!,
                                ),
                          ),
                        ),
                        Consumer(
                          builder: (_, __, ___) =>
                              ref.watch(publicWorkoutsProvider).maybeWhen(
                                    data: (workouts) {
                                      return Flexible(
                                        child: QmIconButton(
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
                        ref.watch(
                          addWorkoutNotifierProvider.select(
                            (value) => value.name,
                          ),
                        );
                        return Form(
                          key: formKey,
                          child: QmTextField(
                            textInputAction: TextInputAction.next,
                            hintText: S.current.AddWorkoutName,
                            onChanged: (p0) => ref
                                .read(addWorkoutNotifierProvider.notifier)
                                .setName(
                                  nameController.text,
                                ),
                            onEditingComplete: () => ref
                                .read(addWorkoutNotifierProvider.notifier)
                                .setName(
                                  nameController.text,
                                ),
                            validator: (value) {
                              ValidationController.validateName(value!);
                              return null;
                            },
                            controller: nameController,
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
                          addWorkoutNotifierProvider.select(
                            (value) => value.content,
                          ),
                        );
                        final name = ref.watch(
                          addWorkoutNotifierProvider.select(
                            (value) => value.name,
                          ),
                        );
                        return QmBlock(
                          color: ColorConstants.secondaryColor,
                          child: QmText(text: S.current.AddWorkout),
                          onTap: () {
                            workoutUtil.add(
                              context: context,
                              name: name,
                              image: content!,
                              ref: ref,
                              isLink: content.startsWith('http'),
                              formKey: formKey,
                            );
                          },
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
                    addWorkoutNotifierProvider.select(
                      (value) => value.content,
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
                          child: QmIconButton(
                            icon: EvaIcons.plus,
                            onPressed: () async => ref
                                .read(addWorkoutNotifierProvider.notifier)
                                .setContent(
                                  (await utils.chooseImageFromStorage())!,
                                ),
                          ),
                        ),
                        Consumer(
                          builder: (_, __, ___) =>
                              ref.watch(publicWorkoutsProvider).maybeWhen(
                                    data: (workouts) {
                                      return Flexible(
                                        child: QmIconButton(
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
                          addWorkoutNotifierProvider.select(
                            (value) => value.content,
                          ),
                        );
                        final name = ref.watch(
                          addWorkoutNotifierProvider.select(
                            (value) => value.name,
                          ),
                        );
                        return Form(
                          key: formKey,
                          child: QmTextField(
                            textInputAction: TextInputAction.go,
                            hintText: S.current.AddWorkoutName,
                            onChanged: (_) => ref
                                .read(addWorkoutNotifierProvider.notifier)
                                .setName(
                                  nameController.text,
                                ),
                            validator: (value) {
                              ValidationController.validateName(value!);
                              return null;
                            },
                            onEditingComplete: () => workoutUtil.add(
                              context: context,
                              name: name,
                              image: content!,
                              ref: ref,
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
                          addWorkoutNotifierProvider.select(
                            (value) => value.content,
                          ),
                        );
                        final name = ref.watch(
                          addWorkoutNotifierProvider.select(
                            (value) => value.name,
                          ),
                        );
                        return QmBlock(
                          color: ColorConstants.secondaryColor,
                          child: QmText(text: S.current.AddWorkout),
                          onTap: () => workoutUtil.add(
                            context: context,
                            name: name,
                            image: content!,
                            ref: ref,
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
