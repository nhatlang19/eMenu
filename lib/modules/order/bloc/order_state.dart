part of 'order_bloc.dart';

enum OrderStatus {
  initial,
  success,
  failure,
  changed,
  initOrder,
  movedTable,
  movedTableFailed,
  movedTableSuccess
}

final class OrderState extends Equatable {
  final List<Order> orders;
  final Order order;
  final Table selectedForGroup;
  final bool isAddNew;
  final Table selectedTable;
  final Table moveTable;
  final SalesCode selectedCode;
  final OrderStatus status;
  final String tableSection;
  final List<Table> tableAllSection;
  final String errorMessageMoveTable;
  final String successMessageMoveTable;

  const OrderState({
    this.selectedForGroup = Table.empty,
    this.isAddNew = true,
    this.selectedTable = Table.empty,
    this.selectedCode = SalesCode.empty,
    this.orders = const <Order>[],
    this.order = Order.empty,
    this.status = OrderStatus.initial,
    this.tableSection = "",
    this.tableAllSection = const <Table>[],
    this.errorMessageMoveTable = "",
    this.successMessageMoveTable = "",
    this.moveTable = Table.empty,
  });

  OrderState copyWith({
    OrderStatus? status,
    Order? order,
    List<Order>? orders,
    Table? selectedForGroup,
    bool? isAddNew,
    Table? selectedTable,
    Table? moveTable,
    SalesCode? selectedCode,
    String? tableSection,
    List<Table>? tableAllSection,
    String? errorMessageMoveTable,
    String? successMessageMoveTable,
  }) {
    return OrderState(
      status: status ?? this.status,
      order: order ?? this.order,
      orders: orders ?? this.orders,
      selectedForGroup: selectedForGroup ?? this.selectedForGroup,
      isAddNew: isAddNew ?? this.isAddNew,
      selectedTable: selectedTable ?? this.selectedTable,
      moveTable: moveTable ?? this.moveTable,
      selectedCode: selectedCode ?? this.selectedCode,
      tableSection: tableSection ?? this.tableSection,
      tableAllSection: tableAllSection ?? this.tableAllSection,
      errorMessageMoveTable:
          errorMessageMoveTable ?? this.errorMessageMoveTable,
      successMessageMoveTable:
          successMessageMoveTable ?? this.successMessageMoveTable,
    );
  }

  @override
  List<Object> get props => [
        orders,
        order,
        selectedForGroup,
        tableAllSection,
        isAddNew,
        selectedTable,
        moveTable,
        selectedCode,
        status,
        tableSection,
        errorMessageMoveTable,
        successMessageMoveTable
      ];
}
