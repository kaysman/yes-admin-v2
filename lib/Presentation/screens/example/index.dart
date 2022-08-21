import 'package:fluent_ui/fluent_ui.dart';

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

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        displayMode: PaneDisplayMode.top,
        // header: Image.asset(
        //   'assets/brand_yes.png',
        //   fit: BoxFit.contain,
        // ),
        items: [
          PaneItem(
            icon: Icon(FluentIcons.b_i_dashboard),
            title: const Text('Dashboard'),
            infoBadge: const InfoBadge(
              source: Text('9'),
            ),
          ),
          PaneItem(
            icon: Icon(FluentIcons.product_list),
            title: const Text('Products'),
          ),
          PaneItem(
            icon: Icon(FluentIcons.activate_orders),
            title: const Text('Orders'),
          ),
        ],
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
