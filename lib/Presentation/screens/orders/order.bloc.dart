import 'package:admin_v2/Data/models/order/order.model.dart';
import 'package:admin_v2/Data/models/product/pagination.model.dart';
import 'package:admin_v2/Data/services/order_service.dart';
import 'package:bloc/bloc.dart';

enum OrderListStatus { idle, success, error, loading }

enum UpdateOrderStatus { idle, success, error, loading }

class OrderState {
  final OrderListStatus listingStatus;
  final UpdateOrderStatus updateOrderStatus;
  final List<OrderEntity>? orders;

  OrderState({
    this.listingStatus = OrderListStatus.idle,
    this.updateOrderStatus = UpdateOrderStatus.idle,
    this.orders,
  });

  OrderState copyWith({
    OrderListStatus? listingStatus,
    UpdateOrderStatus? updateOrderStatus,
    List<OrderEntity>? orders,
  }) {
    return OrderState(
      listingStatus: listingStatus ?? this.listingStatus,
      updateOrderStatus: updateOrderStatus ?? this.updateOrderStatus,
      orders: orders ?? this.orders,
    );
  }
}

class OrderBloc extends Cubit<OrderState> {
  OrderBloc() : super(OrderState());

  getAllOrders({
    PaginationDTO? filter,
  }) async {
    emit(state.copyWith(listingStatus: OrderListStatus.loading));

    if (filter == null) {
      filter = PaginationDTO();
    }
    try {
      var res = await OrderService.getOrders(filter.toJson());
      emit(state.copyWith(
        orders: res,
        listingStatus: OrderListStatus.idle,
      ));
    } catch (_) {
      print(_);
      emit(state.copyWith(listingStatus: OrderListStatus.error));
    }
  }

  // updateCategory(UpdateCategoryDTO data) async {
  //   emit(state.copyWith(updateStatus: CategoryUpdateStatus.idle));
  //   try {
  //     var res = await CategoryService.updateCategory(data);
  //     if (res.success == true) {
  //       emit(state.copyWith(
  //         updateStatus: CategoryUpdateStatus.success,
  //       ));
  //       getAllCategories();
  //     }
  //   } catch (_) {
  //     print(_);
  //     emit(state.copyWith(updateStatus: CategoryUpdateStatus.error));
  //   }
  // }
}
