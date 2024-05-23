part of 'table_bloc.dart';

enum TableStatus { initial, success, failure }

final class TableState extends Equatable {
  const TableState({
    this.status = TableStatus.initial,
    this.tables = const <Table>[],
  });

  final TableStatus status;
  final List<Table> tables;

  TableState copyWith({
    TableStatus? status,
    List<Table>? tables,
  }) {
    return TableState(
      status: status ?? this.status,
      tables: tables ?? this.tables,
    );
  }
  @override
  List<Object> get props => [status, tables];
}
