import 'package:fluent_ui/fluent_ui.dart';

class TreeViewItemContent extends StatelessWidget {
  const TreeViewItemContent(
      {Key? key,
      required this.title,
      required this.onItemTap,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);
  final String title;
  final VoidCallback onItemTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onItemTap,
            child: Text(
              title,
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
          ),
        ),
        Expanded(
          child: CommandBar(
            overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
            compactBreakpointWidth: 20,
            primaryItems: [CommandBarButton(onPressed: () {})],
            secondaryItems: [
              CommandBarButton(
                onPressed: onEdit,
                label: Text('Edit'),
              ),
              CommandBarButton(
                onPressed: onDelete,
                label: Text('Delete'),
              ),
            ],
          ),
        )
      ],
    );
  }
}