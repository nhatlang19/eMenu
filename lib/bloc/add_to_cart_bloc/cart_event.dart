part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ResetCart extends CartEvent {
  const ResetCart();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Submenu currSubItem;
  final int qty;
  final String? priceLevel;

  const AddToCart(
      {required this.currSubItem, required this.qty, this.priceLevel});

  @override
  List<Object> get props => [currSubItem, qty, priceLevel!];
}

class AddToCartWithCombo extends CartEvent {
  final Function callback;
  const AddToCartWithCombo({required this.callback});

  @override
  List<Object> get props => [callback];
}

class Toogle extends CartEvent {
  const Toogle();

  @override
  List<Object> get props => [];
}

class Increase extends CartEvent {
  final int position;

  const Increase({required this.position});

  @override
  List<Object> get props => [position];
}

class Decrease extends CartEvent {
  final int position;

  const Decrease({required this.position});

  @override
  List<Object> get props => [position];
}

class UpdateQuantity extends CartEvent {
  final int position;
  final int value;

  const UpdateQuantity({required this.position, required this.value});

  @override
  List<Object> get props => [position];
}

class UpdateNoPeople extends CartEvent {
  final String value;

  const UpdateNoPeople({required this.value});

  @override
  List<Object> get props => [value];
}

class SendOrder extends CartEvent {
  final String sendNewOrder;
  final String reSendOrder;
  final bool isAddNew;
  final String typeLoad;
  final String currTable;
  final String currTableGroup;
  final String POSBizDate;
  final String noOfPerson;
  final String salesCode;
  final Order order;

  const SendOrder(
      {required this.sendNewOrder,
      required this.reSendOrder,
      required this.isAddNew,
      required this.typeLoad,
      required this.currTable,
      required this.currTableGroup,
      required this.noOfPerson,
      required this.salesCode,
      required this.order,
      required this.POSBizDate});

  @override
  List<Object> get props => [sendNewOrder, reSendOrder, order,isAddNew, typeLoad, currTable, currTableGroup, noOfPerson, salesCode, POSBizDate];
}

class HideShowCombo extends CartEvent {
  const HideShowCombo();

  @override
  List<Object> get props => [];
}

class SkipShowCombo extends CartEvent {
  const SkipShowCombo();

  @override
  List<Object> get props => [];
}

class UpdateQuantityCombo extends CartEvent {
  final int comboPosition;
  final int position;
  final int value;

  const UpdateQuantityCombo({required this.comboPosition, required this.position, required this.value});

  @override
  List<Object> get props => [comboPosition, position, value];
}

class LoadItemsWhenEdit extends CartEvent {
  final String orderNo;
  final String posNo;
  final String extNo;

  const LoadItemsWhenEdit({required this.orderNo, required this.posNo, required this.extNo});

  @override
  List<Object> get props => [orderNo, posNo, extNo];
}