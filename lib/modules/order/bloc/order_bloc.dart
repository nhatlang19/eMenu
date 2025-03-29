import 'package:bloc/bloc.dart';
import 'package:emenu/models/order.dart';
import 'package:emenu/models/sales_code.dart';
import 'package:emenu/repositories/order_repository.dart';
import 'package:emenu/repositories/table_repository.dart';
import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/settings.dart';
import 'package:equatable/equatable.dart';
import 'package:emenu/models/table.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;
  final TableRepository _tableRepository;

  OrderBloc({required OrderRepository orderRepository, required TableRepository tableRepository}) : 
  _orderRepository = orderRepository, 
  _tableRepository = tableRepository, 
  super(const OrderState()) {
    on<OrderInitPage>(_onOrderInitPage);
    on<ChangeSelectOrder>(_onChangeSelectOrder);
    on<FetchOrders>(_onFetchOrders);
    on<FetchOrdersAfterSend>(_onFetchOrdersAfterSend);
    on<ChangeSelectedTable>(_onChangeSelectedTable);
    on<ConfirmMoveTable>(_onConfirmMoveTable);
  }

  void _onChangeSelectedTable(ChangeSelectedTable event, Emitter<OrderState> emit) {
    emit(state.copyWith(status: OrderStatus.movedTable, moveTable: event.table));
  }

  Future<void> _onConfirmMoveTable(ConfirmMoveTable event, Emitter<OrderState> emit) async {
    String tableNo = (state.moveTable.TableNo ?? '').trim();
    Table table = await _tableRepository.getStatusOfMoveTable(moveTable: tableNo);

    if (table.Status != 'A' || (table.OpenBy != null && table.OpenBy != '')) {
      if (table.OpenBy != '') {
        emit(state.copyWith(status: OrderStatus.movedTableFailed, successMessageMoveTable: '', errorMessageMoveTable: "Table $tableNo có KHÁCH HÀNG hoặc đang EDITING bởi CashierID: ${table.OpenBy ?? ''}"));
      } else {
        emit(state.copyWith(status: OrderStatus.movedTableFailed, successMessageMoveTable: '', errorMessageMoveTable: "Table $tableNo có KHÁCH HÀNG"));
      }
    } else {
      var settings = Settings();
      var setting = await settings.read();
      var cashier = await Global.getCashier();

      String posNo = setting.posId;
      String orderNo = "";
      String extNo = "0";
      if (state.isAddNew) {
        orderNo = await _orderRepository.getNewOrderNumberByPOS(posNo);
      } else {
        posNo = state.order.getPos();
        orderNo = state.order.getOrd();
        extNo = state.order.getExt();
      }
      String splited = '0';

      var res = await _tableRepository.moveTable(
        currTable: (state.selectedTable.TableNo ?? '').trim(),
        moveTable: tableNo,
        currTableGroup: (state.selectedForGroup.TableNo ?? '').trim(),
        posNo: posNo,
        orderNo: orderNo,
        extNo: extNo,
        splited: splited,
        cashierID: cashier.cashierID ?? '',
      );
      if (res) {
        emit(state.copyWith(selectedTable: state.moveTable, moveTable: Table.empty, status: OrderStatus.movedTableSuccess, errorMessageMoveTable: '', successMessageMoveTable: "Đã chuyển bàn ${state.selectedTable.TableNo ?? ''.trim()} tới ${state.moveTable.TableNo ?? ''.trim()}"));
      } else {
        emit(state.copyWith(status: OrderStatus.movedTableFailed, successMessageMoveTable: '', errorMessageMoveTable: "Chưa có/Chưa lưu data nên không MOVE được"));
      }
    }
  }

  Future<void> _onOrderInitPage(OrderInitPage event, Emitter<OrderState> emit) async {
    List<Table> tables = await _tableRepository.getTableListAllSection();
    emit(state.copyWith(selectedForGroup: event.selectedForGroup
                        , status: OrderStatus.initOrder
                        , isAddNew: event.isAddNew
                        , tableAllSection: tables
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

  Future<void> _onFetchOrdersAfterSend(FetchOrdersAfterSend event, Emitter<OrderState> emit) async {
    try {
      emit(state.copyWith(status: OrderStatus.initial));
      List<Order> orders = await _orderRepository.getOrderEditType(posBizDate: event.posBizDate, currentTable: event.currentTable);
      if (orders.isNotEmpty) {
        emit(state.copyWith(orders: orders, status: OrderStatus.success, order: orders.first, isAddNew: false));
      } else {
        emit(state.copyWith(orders: orders, status: OrderStatus.success, isAddNew: false));
      }
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure));
    }
  }
}
