import 'package:quantum_muscle/library.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  Future<void> _performSearch() async {
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
                padding: const EdgeInsets.all(8),
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
                    _searchResults[index].data()! as Map<String, dynamic>;

                final name = userData[UserModel.nameKey] as String;
                final id = userData[UserModel.idKey] as String;
                final image = userData[UserModel.profileImageURLKey] as String;
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
