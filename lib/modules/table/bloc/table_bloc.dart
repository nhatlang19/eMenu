import 'package:bloc/bloc.dart';
import 'package:emenu/models/sales_code.dart';
import 'package:emenu/models/section.dart';
import 'package:emenu/models/table.dart';
import 'package:emenu/repositories/table_repository.dart';
import 'package:equatable/equatable.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final TableRepository _tableRepository;

  TableBloc({required TableRepository tableRepository})
      : _tableRepository = tableRepository,
        super(const TableState()) {
    on<FetchTable>(_onFetchTable);
    on<RefreshFetchTable>(_onRefreshFetchTable); 
    on<ChangeSelectGroup>(_onChange);
    on<ChangeIsAddNew>(_onChangeIsEdit);
    on<SelectTable>(_onSelectTable);
  }

  Future<void> _onFetchTable(FetchTable event, Emitter<TableState> emit) async {
    try {
      emit(state.copyWith(status: TableStatus.initial));
      List<Table> tables = await _tableRepository.getTableListBySection(section: event.section);
      emit(state.copyWith(tables: tables, currentSection: event.section, status: TableStatus.success, table: tables[0]));
    } catch (_) {
      emit(state.copyWith(status: TableStatus.failure));
    }
  }

  Future<void> _onRefreshFetchTable(RefreshFetchTable event, Emitter<TableState> emit) async {
    try {
      List<Table> tables = await _tableRepository.getTableListBySection(section: state.currentSection);
      emit(state.copyWith(tables: tables, status: TableStatus.refresh));
    } catch (_) {
      emit(state.copyWith(status: TableStatus.failure));
    }
  }

  void _onChange(ChangeSelectGroup event, Emitter<TableState> emit) {
    emit(state.copyWith(selectedForGroup: event.group, status: TableStatus.changed));
  }

  void _onChangeIsEdit(ChangeIsAddNew event, Emitter<TableState> emit) {
    emit(state.copyWith(isAddNew: event.isAddNew, status: TableStatus.changed));
  }

  void _onSelectTable(SelectTable event, Emitter<TableState> emit) {
     emit(state.copyWith(isAddNew: event.isAddNew, status: TableStatus.changed, table: event.table));
  }
}
