import 'package:quantum_muscle/library.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Consumer(
            builder: (_, ref, __) {
              ref.watch(
                searchStateNotifierProvider.select(
                  (value) => value.searchText,
                ),
              );
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .15),
                child: QmTextField(
                  textInputAction: TextInputAction.go,
                  hintText: S.current.Search,
                  controller: searchTextController,
                  onEditingComplete: () {
                    ref
                        .read(searchStateNotifierProvider.notifier)
                        .setSearchText(searchTextController.text);
                    ref
                        .read(searchStateNotifierProvider.notifier)
                        .performSearch();
                  },
                ),
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

class SearchState {
  const SearchState({
    required this.searchText,
    required this.searchResults,
  });
  final String searchText;
  final List<UserModel> searchResults;

  SearchState copyWith({
    String? searchText,
    List<UserModel>? searchResults,
  }) {
    return SearchState(
      searchText: searchText ?? this.searchText,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

class SearchStateNotifier extends StateNotifier<SearchState> {
  SearchStateNotifier()
      : super(
          const SearchState(
            searchText: '',
            searchResults: [],
          ),
        );

  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  void setSearchResults(List<UserModel> searchResults) {
    state = state.copyWith(searchResults: searchResults);
  }

  Future<void> performSearch() async {
    final searchResults = await UserUtil().searchUsers(state.searchText);
    setSearchResults(searchResults);
  }
}

final searchStateNotifierProvider =
    StateNotifierProvider<SearchStateNotifier, SearchState>(
  (ref) => SearchStateNotifier(),
);
