import '/library.dart';

void openNetworkExercisesSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: ColorConstants.secondaryColor,
    builder: (context) {
      return const NetworkExercisesSheet();
    },
  );
}

class NetworkExercisesSheet extends ConsumerStatefulWidget {
  const NetworkExercisesSheet({super.key});

  @override
  ConsumerState<NetworkExercisesSheet> createState() =>
      _NetworkExercisesSheetState();
}

class _NetworkExercisesSheetState extends ConsumerState<NetworkExercisesSheet>
    with TickerProviderStateMixin {
  late final networkExercises = ref.watch(publicExercisesProvider);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return networkExercises.when(
      data: (networkExercises) {
        final TabController tabController = TabController(
          length: networkExercises.length,
          vsync: this,
        );

        return Scaffold(
          appBar: QmCustomTabBar(
            tabs: networkExercises.map((e) => e.$1).toList(),
            onTabSelected: (index) {
              tabController.animateTo(index);
            },
          ),
          body: TabBarView(
            controller: tabController,
            children: networkExercises
                .map(
                  (e) => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: e.$2.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * .15,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ref
                              .read(exerciseNetworkImageProvider.notifier)
                              .state = e.$2[index];
                          context.pop();
                        },
                        child: GridTile(
                          child: QmImageNetwork(
                            source: e.$2[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
      loading: () {
        context.pop();

        return const Center(child: QmCircularProgressIndicator());
      },
      error: (error, stackTrace) => Center(
        child: Text(
          error.toString(),
        ),
      ),
    );
  }
}
