import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart';

import 'dashboard.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int selected_index = 0;
  final List<Widget> pages = [
    FluentDashboard(),
    Container(color: Colors.magenta),
    Container(
      color: Colors.teal,
    )
  ];

  final List<Map<String, dynamic>> paneItems = [
    {
      'icon': FluentIcons.b_i_dashboard,
      'title': 'Dashboard',
    },
    {
      'icon': FluentIcons.category_classification,
      'title': 'Products',
    },
    {
      'icon': FluentIcons.product_list,
      'title': 'Orders',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        // header: Image.asset(
        //   'assets/brand_yes.png',
        //   fit: BoxFit.contain,
        // ),

        indicator: StickyNavigationIndicator(
          color: kWhite,
        ),
        items: List.generate(paneItems.length, (index) {
          var item = paneItems[index];
          return PaneItem(
            selectedTileColor: ButtonState.all(Colors.blue),
            icon: Icon(
              item['icon']!,
              color: index == selected_index ? Colors.white : null,
            ),
            title: Text.rich(
              TextSpan(
                text: item['title'],
                style: index == selected_index
                    ? TextStyle(
                        color: kWhite,
                      )
                    : TextStyle(
                        color: kBlack,
                      ),
              ),
            ),
          );
        }),
        selected: selected_index,
        onChanged: (v) {
          setState(() {
            selected_index = v;
          });
        },
      ),
      content: NavigationBody(
        index: selected_index,
        children: pages,
      ),
      // drawer: MenuBar(
      //   constraints: constraints,
      //   menuItems: state.items,
      //   onItemTapped: (v) {
      //     indexBloc.changeItem(v);
      //     Navigator.of(context).pop();
      //   },
      // ),
      // body: state.selected?.view == null
      //     ? DashBoard()
      //     : state.selected?.view,
    );
  }
}
