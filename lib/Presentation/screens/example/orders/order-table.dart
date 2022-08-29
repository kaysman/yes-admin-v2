import 'package:admin_v2/Data/models/order/order.model.dart';
import 'package:admin_v2/Presentation/screens/example/orders/orders-tree.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/back-button.dart';
import 'package:admin_v2/Presentation/screens/example/widgets/table-command-bar.dart';
import 'package:admin_v2/Presentation/screens/orders/order-table.dart';
import 'package:admin_v2/Presentation/screens/orders/order.bloc.dart';
import 'package:admin_v2/Presentation/shared/app_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FluentOrderTable extends StatefulWidget {
  const FluentOrderTable({Key? key, this.order}) : super(key: key);
  final OrderEntity? order;

  @override
  State<FluentOrderTable> createState() => _FluentOrderTableState();
}

class _FluentOrderTableState extends State<FluentOrderTable> {
  final autoSuggestBox = TextEditingController();
  late OrderBloc orderBloc;
  OrderEntity? selectedOrder;
  String? selectedOrderStatus;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    if (widget.order != null) {
      selectedOrder = widget.order;
      var status = OrderStatus.values
          .firstWhere((el) => el.name == selectedOrder?.status);
      selectedOrderStatus = status == OrderStatus.CREATED ? 'Zakaz edildi' : '';
      orderBloc.getAllOrders(selectedStatus: status);
    }
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
            'Order Table',
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
            child: OrderTreeViewImpl(
              onStatusChanged: (v) {
                setState(() {
                  selectedOrderStatus = v;
                });
              },
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
                    Text('Orders of $selectedOrderStatus'),
                  ],
                ),
                OrdersTable(
                  emptyOrderText: 'Statusa degisli zakaz, yok!',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
