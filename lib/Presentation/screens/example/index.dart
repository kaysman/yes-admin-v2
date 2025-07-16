// import 'package:flutter/material.dart';
// // import 'package:admin_v2/Presentation/shared/app_colors.dart';
// // import 'dashboard.dart';

// class Index extends StatefulWidget {
//   const Index({Key? key}) : super(key: key);

//   @override
//   State<Index> createState() => _IndexState();
// }

// class _IndexState extends State<Index> {
//   int selected_index = 0;
//   final List<Widget> pages = [
//     // MaterialDashboard(),
//     Container(),
//     Container(),
//     Container(),
//   ];

//   final List<Map<String, dynamic>> paneItems = [
//     {
//       'icon': Icons.dashboard,
//       'title': 'Dashboard',
//     },
//     {
//       'icon': Icons.category,
//       'title': 'Products',
//     },
//     {
//       'icon': Icons.list,
//       'title': 'Orders',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     return NavigationView(
//       pane: NavigationPane(
//         // header: Image.asset(
//         //   'assets/brand_yes.png',
//         //   fit: BoxFit.contain,
//         // ),
//         indicator: StickyNavigationIndicator(
//           color: colorScheme.surface,
//         ),
//         items: List.generate(paneItems.length, (index) {
//           var item = paneItems[index];
//           final isSelected = index == selected_index;
//           return PaneItem(
//             selectedTileColor: ButtonState.all(colorScheme.primary),
//             icon: Icon(
//               item['icon']!,
//               color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
//             ),
//             title: Text.rich(
//               TextSpan(
//                 text: item['title'],
//                 style: TextStyle(
//                   color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
//                 ),
//               ),
//             ),
//           );
//         }),
//         selected: selected_index,
//         onChanged: (v) {
//           setState(() {
//             selected_index = v;
//           });
//         },
//       ),
//       content: NavigationBody(
//         index: selected_index,
//         children: pages,
//       ),
//     );
//   }
// }
