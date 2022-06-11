import 'package:admin_v2/Data/models/sidebar_item.dart';
import 'package:flutter/material.dart';

class MenuBar extends StatelessWidget {
  MenuBar({
    Key? key,
    required this.constraints,
    this.menuItems,
    this.onItemTapped,
  }) : super(key: key);

  final BoxConstraints constraints;
  final List<SidebarItem>? menuItems;
  final ValueChanged<SidebarItem>? onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: constraints.maxWidth * 0.3,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.grey.shade300,
          ),
          if (menuItems != null)
            ...menuItems!.map((e) {
              return ListTile(
                title: Text(e.title),
                subtitle: e.subtitle != null ? Text(e.subtitle!) : null,
                onTap: onItemTapped == null ? null : () => onItemTapped!(e),
              );
            }),
        ],
      ),
    );
  }
}
