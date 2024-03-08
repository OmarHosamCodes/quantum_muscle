import 'package:quantum_muscle/library.dart';

/// Represents the state of the search feature.
class SearchState {
  /// Constructs a [SearchState] object.
  const SearchState({
    required this.searchText,
    required this.searchResults,
  });

  /// The text being searched.
  final String searchText;

  /// The list of search results.
  final List<UserModel> searchResults;

  /// Creates a new [SearchState] object with the provided values.
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

/// Notifier for the search state.
class SearchStateNotifier extends StateNotifier<SearchState> {
  /// Constructs a [SearchStateNotifier] object.
  SearchStateNotifier()
      : super(
          const SearchState(
            searchText: '',
            searchResults: [],
          ),
        );

  /// Sets the search text.
  void setSearchText(String searchText) {
    state = state.copyWith(searchText: searchText);
  }

  /// Sets the search results.
  void setSearchResults(List<UserModel> searchResults) {
    state = state.copyWith(searchResults: searchResults);
  }

  /// Performs the search operation.
  Future<void> performSearch() async {
    final searchResults = await UserUtil().searchUsers(state.searchText);
    setSearchResults(searchResults);
  }
}

/// Provider for the [SearchStateNotifier] and [SearchState].
final searchStateNotifierProvider =
    StateNotifierProvider<SearchStateNotifier, SearchState>(
  (ref) => SearchStateNotifier(),
);
