import 'package:fluent_ui/fluent_ui.dart';
import 'package:native_context_menu/native_context_menu.dart' as n;

class TreeViewItemContent extends StatelessWidget {
  TreeViewItemContent({
    Key? key,
    required this.onEdit,
    required this.onDelete,
    required this.title,
    required this.onItemTap,
    this.titleTextStyle,
  }) : super(key: key);
  final VoidCallback onItemTap;
  final VoidCallback onEdit;
  final String title;
  final VoidCallback onDelete;
  final TextStyle? titleTextStyle;
  List<String> options = [
    'Edit',
    'Delete',
  ];

  @override
  Widget build(BuildContext context) {
    return n.ContextMenuRegion(
      onItemSelected: (item) {
        item.onSelected?.call();
      },
      menuItems: List.generate(options.length, (index) {
        return n.MenuItem(
            title: options[index],
            onSelected: () {
              if (index == 0) onEdit.call();
              if (index == 1) onDelete.call();
            });
      }),
      child: GestureDetector(
        onTap: onItemTap,
        child: Text(
          title,
          style: titleTextStyle,
        ),
      ),
    );
  }
}
