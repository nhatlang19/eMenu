import 'package:bloc/bloc.dart';
import 'package:emenu/models/order.dart';
import 'package:emenu/models/sales_code.dart';
import 'package:emenu/repositories/order_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:emenu/models/table.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc({required OrderRepository orderRepository}) : _orderRepository = orderRepository, super(OrderState()) {
    on<OrderInitPage>(_onOrderInitPage);
    on<ChangeSelectOrder>(_onChangeSelectOrder);
    on<FetchOrders>(_onFetchOrders);
  }

   void _onOrderInitPage(OrderInitPage event, Emitter<OrderState> emit) {
    emit(state.copyWith(selectedForGroup: event.selectedForGroup
                        , status: OrderStatus.initOrder
                        , isAddNew: event.isAddNew
                        , tableSection: event.tableSection
                        , order: event.order
                        , selectedTable: event.selectedTable
                        , selectedCode: event.selectedCode));

  }

  void _onChangeSelectOrder(ChangeSelectOrder event, Emitter<OrderState> emit) {
    emit(state.copyWith(order: event.order));
  }

  Future<void> _onFetchOrders(FetchOrders event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(status: OrderStatus.initial));
      List<Order> orders = await _orderRepository.getOrderEditType(posBizDate: event.posBizDate, currentTable: event.currentTable);
      if (orders.isNotEmpty) {
        emit(state.copyWith(orders: orders, status: OrderStatus.success, order: orders.first));
      } else {
        emit(state.copyWith(orders: orders, status: OrderStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure));
    }
  }
}