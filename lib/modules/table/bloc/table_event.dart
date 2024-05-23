part of 'table_bloc.dart';

sealed class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class FetchTable extends TableEvent {
  final String section;

  const FetchTable({required this.section});
}
