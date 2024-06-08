import 'package:bloc/bloc.dart';
import 'package:emenu/models/sales_code.dart';
import 'package:equatable/equatable.dart';
import 'package:emenu/models/table.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
    on<OrderInitPage>(_onOrderInitPage);
  }

   void _onOrderInitPage(OrderInitPage event, Emitter<OrderState> emit) {
    emit(state.copyWith(selectedForGroup: event.selectedForGroup
    , isAddNew: event.isAddNew
    , selectedTable: event.selectedTable
    , selectedCode: event.selectedCode));
  }
}