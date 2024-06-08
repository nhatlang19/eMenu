import 'package:bloc/bloc.dart';
import 'package:emenu/models/sales_code.dart';
import 'package:emenu/repositories/sales_code_repository.dart';
import 'package:equatable/equatable.dart';

part 'salescode_event.dart';
part 'salescode_state.dart';

class SalesCodeBloc extends Bloc<SalesCodeEvent, SalesCodeState> {
  final SalesCodeRepository _salesCodeRepository;

  SalesCodeBloc({required SalesCodeRepository salesCodeRepository})
      : _salesCodeRepository = salesCodeRepository,
        super(const SalesCodeState()) {
    on<FetchSalesCode>(_onFetchSalesCode);
    on<ChangeSelectSalesCode>(_onChange);
  }

  Future<void> _onFetchSalesCode(
      FetchSalesCode event, Emitter<SalesCodeState> emit) async {
    try {
      List<SalesCode> salescodes =
          await _salesCodeRepository.getSalesCode();
      emit(state.copyWith(salescodes: salescodes, status: SalesCodeStatus.success, selectedCode: salescodes[0]));
    } catch (_) {
      emit(state.copyWith(status: SalesCodeStatus.failure));
    }
  }

  void _onChange(ChangeSelectSalesCode event, Emitter<SalesCodeState> emit) {
    emit(state.copyWith(selectedCode: event.code, status: SalesCodeStatus.changed));
  }
}
