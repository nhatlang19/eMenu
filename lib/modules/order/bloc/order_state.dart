part of 'order_bloc.dart';

final class OrderState extends Equatable {
  const OrderState({
    this.selectedForGroup = Table.empty,
    this.isAddNew = true,
    this.selectedTable = Table.empty,
    this.selectedCode = SalesCode.empty
  });

  final Table selectedForGroup;
  final bool isAddNew;
  final Table selectedTable;
  final SalesCode selectedCode;

  OrderState copyWith({
    Table? selectedForGroup,
    bool? isAddNew,
    Table? selectedTable,
    SalesCode? selectedCode
  }) {
    return OrderState(
      selectedForGroup: selectedForGroup ?? this.selectedForGroup,
      isAddNew: isAddNew ?? this.isAddNew,
      selectedTable: selectedTable ?? this.selectedTable,
      selectedCode: selectedCode ?? this.selectedCode
    );
  }

  @override
  List<Object> get props => [selectedForGroup, isAddNew, selectedTable, selectedCode];
}

