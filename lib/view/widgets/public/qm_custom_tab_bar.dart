import '/library.dart';

class QmCustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  final List tabs;

  final Function(int) onTabSelected;

  const QmCustomTabBar({
    super.key,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<QmCustomTabBar> createState() => _QmCustomTabBarState();
}

class _QmCustomTabBarState extends State<QmCustomTabBar> {
  int selectedIndex = 0;
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: List.generate(
            widget.tabs.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTabSelected(index);
                  selectedIndex = index;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: index == selectedIndex
                      ? ColorConstants.disabledColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: QmText(
                  text: widget.tabs[index],
                  color: index == selectedIndex
                      ? ColorConstants.textColor
                      : ColorConstants.disabledColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
