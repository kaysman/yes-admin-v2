import 'package:admin_v2/Presentation/screens/index/drawer.dart';
import 'package:admin_v2/Presentation/screens/index/index.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndexScreen extends StatefulWidget {
  static const String routeName = "index";
  IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  late IndexBloc indexBloc;

  @override
  void initState() {
    indexBloc = BlocProvider.of<IndexBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBloc, IndexState>(
      builder: (_, state) {
        return LayoutBuilder(
          builder: (_, constraints) {
            return Scaffold(
              drawerEnableOpenDragGesture: false,
              // endDrawer: EndDrawer(),
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  state.selected?.title ?? 'YES',
                ),
                actions: state.selected?.getActions != null
                    ? state.selected?.getActions!(context)
                    : null,
              ),
              drawer: MenuBar(
                constraints: constraints,
                menuItems: state.items,
                onItemTapped: (v) {
                  indexBloc.changeItem(v);
                  Navigator.of(context).pop();
                },
              ),
              body: state.selected?.view,
            );
          },
        );
      },
    );
  }
}

