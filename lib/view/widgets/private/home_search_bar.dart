import '../../../library.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key, this.controller});
  final TextEditingController? controller;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        searchController: searchController,
        suggestionsBuilder: (context, controller) {
          return List<ListTile>.generate(
            5,
            (int index) {
              final String item = 'item $index';
              return ListTile(
                title: QMText(text: item),
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
        builder: (context, controller) {
          return SearchBar(
            controller: controller,
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
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
                  controller.clear();
                },
                child: const Icon(
                  EvaIcons.close,
                  color: ColorConstants.secondaryColor,
                ),
              ),
            ],
          );
        });
  }
}
