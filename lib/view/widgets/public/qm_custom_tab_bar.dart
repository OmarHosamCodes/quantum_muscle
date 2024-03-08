import 'package:quantum_muscle/library.dart';

/// A customizable tab bar widget that can be used to display tabs.
class QmCustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates a [QmCustomTabBar] widget.
  const QmCustomTabBar({
    required this.tabs,
    required this.onTabSelected,
    super.key,
  });

  /// The tabs to be displayed.
  final List<String?> tabs;

  /// The callback function to be called when a tab is selected.
  final void Function(int) onTabSelected;

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
          children: [
            for (int index = 0; index < widget.tabs.length; index++)
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onTabSelected(index);
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? ColorConstants.disabledColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: QmText(
                    text: widget.tabs[index]!,
                    color: index == selectedIndex
                        ? ColorConstants.textColor
                        : ColorConstants.textSecondaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
