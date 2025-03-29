part of 'table_bloc.dart';

enum TableStatus { initial, success, failure, changed, refresh, repeat, updateStatusSuccess, updateStatusFailed }

final class TableState extends Equatable {
  const TableState({
    this.status = TableStatus.initial,
    this.tables = const <Table>[],
    this.selectedForGroup = Table.empty,
    this.isAddNew = true,
    this.table = Table.empty,
    this.currentSection = "",
    this.selectedTableIndex = 0,
  });

  final TableStatus status;
  final List<Table> tables;
  final Table selectedForGroup;
  final String currentSection;
  final bool isAddNew;
  final Table table;
  final int selectedTableIndex;

  TableState copyWith({
    TableStatus? status,
    List<Table>? tables,
    Table? selectedForGroup,
    bool? isAddNew,
    Table? table,
    String? currentSection,
    int? selectedTableIndex,
  }) {
    return TableState(
      status: status ?? this.status,
      tables: tables ?? this.tables,
      selectedForGroup: selectedForGroup ?? this.selectedForGroup,
      isAddNew: isAddNew ?? this.isAddNew,
      table: table ?? this.table,
      currentSection: currentSection ?? this.currentSection,
      selectedTableIndex: selectedTableIndex ?? this.selectedTableIndex,
    );
  }
  @override
  List<Object> get props => [status, tables, selectedForGroup, isAddNew, 
  selectedForGroup, table, currentSection, selectedTableIndex];
}
