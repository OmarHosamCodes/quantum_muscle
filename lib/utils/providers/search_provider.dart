import 'package:quantum_muscle/library.dart';

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
