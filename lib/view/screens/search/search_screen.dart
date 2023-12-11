import '/library.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];

  _performSearch() async {
    // Perform the Firestore query based on the user's "name" field
    final QuerySnapshot query = await FirebaseFirestore.instance
        .collection(DBPathsConstants.usersPath)
        .where(UserModel.tagsKey, arrayContains: _searchController.text)
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: QmTextField(
              height: height * 0.1,
              width: width * 0.9,
              hintText: S.of(context).Search,
              controller: _searchController,
              onChanged: (value) => _performSearch(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final userData =
                    _searchResults[index].data() as Map<String, dynamic>;

                final String name = userData[UserModel.nameKey];
                final String ratID = userData[UserModel.ratIDKey];
                final String? image = userData[UserModel.imageKey] ?? '';
                return ListTile(
                  leading: QmAvatar(
                    userImage: image,
                    radius: 30,
                  ),
                  title: QmText(text: name),
                  subtitle: QmText(
                    text: ratID,
                    isSeccoundary: true,
                  ),
                  onTap: () {
                    context.goNamed(
                      Routes.profileRootR,
                      pathParameters: {
                        'userId': _searchResults[index].id,
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
