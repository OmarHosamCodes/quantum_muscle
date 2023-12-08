import '/library.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key, this.controller});
  final TextEditingController? controller;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final SearchController searchController = SearchController();
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchController,
      suggestionsBuilder: (context, controller) {
        return [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // snapshot.data!.docs.map((e) => e['name']).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final String item = snapshot.data!.docs[index]['name'];
                    return ListTile(
                      title: QmText(text: item),
                      onTap: () {
                        setState(
                          () {
                            controller.closeView(item);
                          },
                        );
                      },
                    );
                  },
                );
              }
              return const SizedBox();
            },
          )
        ];
      },
      viewHintText: S.of(context).Search,
      headerTextStyle: const TextStyle(
        color: ColorConstants.secondaryColor,
        fontSize: 15,
      ),
      headerHintStyle: const TextStyle(
        color: ColorConstants.secondaryColor,
        fontSize: 15,
      ),
      viewLeading: const Icon(
        EvaIcons.searchOutline,
        color: ColorConstants.secondaryColor,
      ),
      viewTrailing: [
        GestureDetector(
          onTap: () {
            searchController.closeView("");
          },
          child: const Icon(
            EvaIcons.close,
            color: ColorConstants.secondaryColor,
          ),
        ),
      ],
      dividerColor: ColorConstants.primaryColor,
      viewBackgroundColor: ColorConstants.primaryColorDark,
      builder: (context, searchController) {
        return SearchBar(
          controller: textController,
          onTap: () {
            searchController.openView();
          },
          onChanged: (_) {
            searchController.openView();
          },
          backgroundColor:
              const MaterialStatePropertyAll(ColorConstants.primaryColorDark),
          hintText: S.of(context).Search,
          hintStyle: const MaterialStatePropertyAll(
            TextStyle(
              color: ColorConstants.secondaryColor,
              fontSize: 15,
            ),
          ),
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              color: ColorConstants.secondaryColor,
              fontSize: 15,
            ),
          ),
          leading: const Icon(
            EvaIcons.searchOutline,
            color: ColorConstants.secondaryColor,
          ),
          trailing: [
            GestureDetector(
              onTap: () {
                textController.clear();
              },
              child: const Icon(
                EvaIcons.close,
                color: ColorConstants.secondaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
