import 'package:bloc/bloc.dart';
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
    on<FetchTable>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(
      FetchTable event, Emitter<TableState> emit) async {
    try {
      List<Table> tables =
          await _tableRepository.getTableListBySection(section: event.section);
      emit(state.copyWith(tables: tables, status: TableStatus.success));
    } catch (_) {
      emit(state.copyWith(status: TableStatus.failure));
    }
  }
}
