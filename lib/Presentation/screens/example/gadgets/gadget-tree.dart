import 'package:admin_v2/Data/enums/gadget-type.dart';
import 'package:admin_v2/Data/models/gadget/gadget.model.dart';
import 'package:admin_v2/Presentation/screens/filters/filter-create.dart';
import 'package:admin_v2/Presentation/screens/home-gadgets/bloc/gadget.bloc.dart';
import 'package:admin_v2/Presentation/shared/helpers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/titled-add-btn.dart';

class GadgetTreeViewImpl extends StatefulWidget {
  const GadgetTreeViewImpl({
    Key? key,
    required this.onGadgetChanged,
  }) : super(key: key);

  final ValueChanged<GadgetEntity> onGadgetChanged;

  @override
  State<GadgetTreeViewImpl> createState() => _GadgetTreeViewImplState();
}

class _GadgetTreeViewImplState extends State<GadgetTreeViewImpl> {
  late GadgetBloc gadgetBloc;
  String selected_item = '';

  @override
  void initState() {
    gadgetBloc = BlocProvider.of<GadgetBloc>(context);
    selected_item = '1';
    super.initState();
  }

  List<Map<String, List<Map<String, String>>>> gadgetLocations = [
    {
      'Home': [
        {
          'location': GadgetLocation.HOME.name,
          'content': 'Active',
          'status': GadgetStatus.ACTIVE.name,
          'id': '1'
        },
        {
          'location': GadgetLocation.HOME.name,
          'id': '2',
          'content': 'Inactive',
          'status': GadgetStatus.INACTIVE.name,
        }
      ]
    },
    {
      'Category': [
        {
          'content': 'Active',
          'status': GadgetStatus.ACTIVE.name,
          'id': '3',
          'location': GadgetLocation.CATEGORY.name
        },
        {
          'content': 'Inactive',
          'status': GadgetStatus.INACTIVE.name,
          'id': '4',
          'location': GadgetLocation.CATEGORY.name
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TitledAddBtn(
            onAdd: () {
              showFluentAppDialog(
                context,
                content: CreateFilterPage(),
              );
            },
            title: 'Gadget locations',
          ),
          SizedBox(
            height: 8,
          ),
          TreeView(
            items: gadgetLocations.map((e) {
              return TreeViewItem(
                backgroundColor: ButtonState.resolveWith(
                  (states) => Colors.white,
                ),
                content: Text(e.keys.first),
                children: e.entries.first.value
                    .map(
                      (e) => TreeViewItem(
                        backgroundColor: selected_item == e['id']
                            ? ButtonState.resolveWith(
                                (states) => Colors.grey[20],
                              )
                            : ButtonState.resolveWith(
                                (states) => Colors.white,
                              ),
                        content: GestureDetector(
                          onTap: () async {
                            setState(() {
                              selected_item = e['id'] ?? '';
                            });
                            await gadgetBloc.getAllGadgets(
                              location: e['location'],
                              status: e['status'],
                            );
                          },
                          child: Text(
                            e['content'] ?? '',
                            style: FluentTheme.of(context)
                                .typography
                                .body
                                ?.copyWith(
                                  fontWeight: selected_item == e['id']
                                      ? FontWeight.w500
                                      : null,
                                ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
