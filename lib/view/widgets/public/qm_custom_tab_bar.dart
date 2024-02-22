// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: strict_raw_type

import 'package:quantum_muscle/library.dart';

class QmCustomTabBar extends StatefulWidget implements PreferredSizeWidget {
  const QmCustomTabBar({
    required this.tabs,
    required this.onTabSelected,
    super.key,
  });
  final List<String?> tabs;

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
          children: List.generate(
            widget.tabs.length,
            (index) => GestureDetector(
              onTap: () => setState(() {
                widget.onTabSelected(index);
                selectedIndex = index;
              }),
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
                      : ColorConstants.textSeccondaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
