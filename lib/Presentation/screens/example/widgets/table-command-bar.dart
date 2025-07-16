// import 'package:flutter/material.dart';

// class TableCommandBar extends StatelessWidget {
//   const TableCommandBar({Key? key, required this.onSearch, required this.onAdd})
//       : super(key: key);
//   final VoidCallback onSearch;
//   final VoidCallback onAdd;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 600,
//       child: CommandBar(
//         mainAxisAlignment: MainAxisAlignment.end,
//         overflowBehavior: CommandBarOverflowBehavior.dynamicOverflow,
//         compactBreakpointWidth: 300,
//         primaryItems: [
//           CommandBarButton(
//             icon: const Icon(Icons.search),
//             label: const Text('Search'),
//             onPressed: onSearch,
//           ),
//           CommandBarButton(
//             icon: const Icon(Icons.add),
//             label: const Text('Add'),
//             onPressed: onAdd,
//           ),
//         ],
//         secondaryItems: [
//           CommandBarButton(
//             icon: const Icon(Icons.archive),
//             label: const Text('Archive'),
//             onPressed: () {},
//           ),
//           CommandBarButton(
//             icon: const Icon(Icons.move),
//             label: const Text('Move'),
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
