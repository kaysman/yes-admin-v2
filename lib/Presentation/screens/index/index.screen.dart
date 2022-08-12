import 'package:admin_v2/Presentation/screens/index/drawer.dart';
import 'package:admin_v2/Presentation/screens/index/index.bloc.dart';
import 'package:admin_v2/Presentation/screens/ready-to-use-widgets/at-search-input.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
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

  TextEditingController fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBloc, IndexState>(
      builder: (_, state) {
        return LayoutBuilder(
          builder: (_, constraints) {
            return Scaffold(
              drawerEnableOpenDragGesture: false,
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  state.selected?.title ?? 'YES',
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: kWhite,
                      ),
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
              body: state.selected?.view == null
                  ? DashBoard()
                  : state.selected?.view,
            );
          },
        );
      },
    );
  }
}

class DashBoard extends StatefulWidget {
  DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(14),
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.width * .3,
        child: AtSearchInput(),
      ),
    );
  }
}
