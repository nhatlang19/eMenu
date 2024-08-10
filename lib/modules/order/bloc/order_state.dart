part of 'order_bloc.dart';

enum OrderStatus { initial, success, failure, changed }

final class OrderState extends Equatable {
  final List<Order> orders;
  final Order order;
  final Table selectedForGroup;
  final bool isAddNew;
  final Table selectedTable;
  final SalesCode selectedCode;
  final OrderStatus status;

  const OrderState({
    this.selectedForGroup = Table.empty,
    this.isAddNew = true,
    this.selectedTable = Table.empty,
    this.selectedCode = SalesCode.empty,
    this.orders = const <Order>[],
    this.order = Order.empty,
    this.status = OrderStatus.initial,
  });

  OrderState copyWith({
    OrderStatus? status,
    Order? order,
    List<Order>? orders,
    Table? selectedForGroup,
    bool? isAddNew,
    Table? selectedTable,
    SalesCode? selectedCode
  }) {
    return OrderState(
      status: status ?? this.status,
      order: order ?? this.order,
      orders: orders ?? this.orders,
      selectedForGroup: selectedForGroup ?? this.selectedForGroup,
      isAddNew: isAddNew ?? this.isAddNew,
      selectedTable: selectedTable ?? this.selectedTable,
      selectedCode: selectedCode ?? this.selectedCode
    );
  }

  @override
  List<Object> get props => [orders, order, selectedForGroup, isAddNew, selectedTable, selectedCode, status];
}

