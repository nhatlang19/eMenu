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

  const OrderInitPage(
      {required this.selectedForGroup,
      required this.isAddNew,
      required this.selectedTable,
      required this.selectedCode});
}
