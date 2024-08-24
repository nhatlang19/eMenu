part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderInitPage extends OrderEvent {
  final Table selectedForGroup;
  final bool isAddNew;
  final Table selectedTable;
  final SalesCode selectedCode;
  final Order order;
  final String tableSection;

  const OrderInitPage(
      {required this.selectedForGroup,
      required this.isAddNew,
      required this.selectedTable,
      required this.order,
      required this.tableSection,
      required this.selectedCode});
}

class ChangeSelectOrder extends OrderEvent {
  final Order order;

  const ChangeSelectOrder({required this.order});

  @override
  List<Object> get props => [order];
}

class FetchOrders extends OrderEvent {
  final String posBizDate;
  final String currentTable;

  const FetchOrders({required this.posBizDate, required this.currentTable});

  @override
  List<Object> get props => [posBizDate, currentTable];
}