import 'package:quantum_muscle/library.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Consumer(
            builder: (_, ref, __) {
              ref.watch(
                searchStateNotifierProvider.select(
                  (value) => value.searchText,
                ),
              );
              return QmTextField(
                textInputAction: TextInputAction.go,
                hintText: S.current.Search,
                controller: searchTextController,
                onEditingComplete: () {
                  ref
                    ..read(searchStateNotifierProvider.notifier)
                        .setSearchText(searchTextController.text)
                    ..read(searchStateNotifierProvider.notifier)
                        .performSearch();
                },
              );
            },
          ),
          Expanded(
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                ref.watch(
                  searchStateNotifierProvider.select(
                    (value) => value.searchResults,
                  ),
                );
                final results =
                    ref.read(searchStateNotifierProvider).searchResults;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final user = results[index];
                    return ListTile(
                      leading: QmAvatar(
                        imageUrl: user.profileImageURL,
                      ),
                      title: QmText(text: user.name),
                      subtitle: QmText(
                        text: user.id,
                        isSeccoundary: true,
                      ),
                      onTap: () {
                        utils.firebaseAnalytics.logSearch(
                          searchTerm: user.name,
                          parameters: {UserModel.idKey: user.id},
                        );
                        context.pushNamed(
                          Routes.profileRootR,
                          pathParameters: {
                            UserModel.idKey: user.id,
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
