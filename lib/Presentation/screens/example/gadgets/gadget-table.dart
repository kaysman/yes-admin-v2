import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Presentation/screens/example/gadgets/gadget-tree.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/back-button.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/table-command-bar.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/gadget-table.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FluentGadgetTable extends StatefulWidget {
  const FluentGadgetTable({Key? key, this.gadget}) : super(key: key);
  final GadgetEntity? gadget;

  @override
  State<FluentGadgetTable> createState() => _FluentGadgetTableState();
}

class _FluentGadgetTableState extends State<FluentGadgetTable> {
  late GadgetBloc gadgetBloc;
  GadgetEntity? selectedGadget;

  @override
  void initState() {
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    gadgetBloc.getAllGadgets(
      location: GadgetLocation.HOME.name,
      status: GadgetStatus.ACTIVE.name,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        leading: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Text(
            'Gadget Table',
            style: FluentTheme.of(context).typography.title,
          ),
        ),
        commandBar: TableCommandBar(onSearch: () async {}, onAdd: () {}),
      ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: kGrey5Color.withOpacity(.6),
            child: GadgetTreeViewImpl(
              onGadgetChanged: (GadgetEntity value) {},
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TableBackButton(),
                    SizedBox(
                      width: 14,
                    ),
                    Text('Active gadgets of Home'),
                  ],
                ),
                GadgetsTable(
                  emptyListText: 'Bu locationa we statusa degisli gadget yok!',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
