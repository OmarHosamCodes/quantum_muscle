import '/library.dart';

void openNetworkWorkoutsSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorConstants.secondaryColor,
    builder: (context) {
      return const _NetworkWorkoutsSheet();
    },
  );
}

class _NetworkWorkoutsSheet extends ConsumerWidget {
  const _NetworkWorkoutsSheet();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final networkWorkouts = ref.watch(publicWorkoutsProvider);
        return networkWorkouts.when(
          data: (networkWorkouts) {
            final TabController tabController = TabController(
              length: networkWorkouts.length,
              vsync: Scaffold.of(context),
            );

            return Scaffold(
              appBar: QmCustomTabBar(
                tabs: networkWorkouts.map((e) => e.$1).toList(),
                onTabSelected: (index) {
                  tabController.animateTo(index);
                },
              ),
              body: TabBarView(
                controller: tabController,
                children: networkWorkouts.map(
                  (e) {
                    return GridView.builder(
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
                                .read(workoutNetworkImageProvider.notifier)
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
                    );
                  },
                ).toList(),
              ),
            );
          },
          loading: () => const Center(child: QmCircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
        );
      },
    );
  }
}
