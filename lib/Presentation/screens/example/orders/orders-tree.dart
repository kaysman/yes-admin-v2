import 'package:admin_v2/Data/models/brand/brand.model.dart';
import 'package:admin_v2/Data/models/order/order.model.dart';
import 'package:admin_v2/Presentation/screens/orders/order.bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/titled-add-btn.dart';

class Category {
  String name;
  List<Category>? subs;

  Category({
    required this.name,
    this.subs,
  });
}

class OrderTreeViewImpl extends StatefulWidget {
  const OrderTreeViewImpl({
    Key? key,
    required this.onStatusChanged,
  }) : super(key: key);

  final ValueChanged<String> onStatusChanged;

  @override
  State<OrderTreeViewImpl> createState() => _OrderTreeViewImplState();
}

class _OrderTreeViewImplState extends State<OrderTreeViewImpl> {
  late OrderBloc orderBloc;
  String selected_item = '';
  String? action;
  OrderEntity? order;
  List<Map<String, OrderStatus>> orderStatus = [
    {'Zakaz edildi': OrderStatus.CREATED},
    {'Kabul edildi': OrderStatus.APPROVED},
    {'Yerine yetirildi': OrderStatus.COMPLETED}
  ];

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    selected_item = 'Zakaz edildi';
    super.initState();
  }

  List<Category> categories = [];

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
            hasIcon: false,
            title: 'Order status',
          ),
          SizedBox(
            height: 8,
          ),
          TreeView(
            items: orderStatus.map(
              (e) {
                return TreeViewItem(
                  backgroundColor: selected_item == e.keys.first
                      ? ButtonState.resolveWith(
                          (states) => Colors.grey[20],
                        )
                      : ButtonState.resolveWith(
                          (states) => Colors.white,
                        ),
                  content: GestureDetector(
                    onTap: () {
                      setState(() {
                        selected_item = e.keys.first;
                      });
                      var status = OrderStatus.values.firstWhere(
                        (el) => el.name == e.entries.first.value.name,
                      );
                      orderBloc.getAllOrders(selectedStatus: status);
                      widget.onStatusChanged.call(selected_item);
                    },
                    child: Text(
                      e.keys.first,
                      style: FluentTheme.of(context).typography.body?.copyWith(
                            fontWeight: selected_item == e.keys.first
                                ? FontWeight.w500
                                : null,
                          ),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
