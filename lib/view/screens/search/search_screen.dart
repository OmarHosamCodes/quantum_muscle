import '/library.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  void _performSearch() async {
    final QuerySnapshot query = await Utils()
        .firebaseFirestore
        .collection(DBPathsConstants.usersPath)
        .where(UserModel.tagsKey, arrayContains: _searchController.text)
        .limit(10)
        .get();

    setState(() {
      _searchResults = query.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Consumer(
            builder: (_, ref, __) {
              ref.watch(localeProvider);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: QmTextField(
                  height: height * 0.1,
                  width: width * 0.9,
                  hintText: S.current.Search,
                  controller: _searchController,
                  onChanged: (value) => _performSearch(),
                ),
              );
            },
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final userData =
                    _searchResults[index].data() as Map<String, dynamic>;

                final String name = userData[UserModel.nameKey];
                final String id = userData[UserModel.idKey];
                final String image = userData[UserModel.profileImageURLKey];
                return ListTile(
                  leading: QmAvatar(
                    imageUrl: image,
                  ),
                  title: QmText(text: name),
                  subtitle: QmText(
                    text: id,
                    isSeccoundary: true,
                  ),
                  onTap: () {
                    Utils().firebaseAnalytics.logSearch(
                      searchTerm: name,
                      parameters: {UserModel.idKey: id},
                    );
                    context.pushNamed(
                      Routes.profileRootR,
                      pathParameters: {
                        UserModel.idKey: _searchResults[index].id,
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
