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
  final String reSendOrder;
  final String typeLoad;
  final String currTable;
  final String POSBizDate;

  const SendOrder(
      {required this.reSendOrder,
      required this.typeLoad,
      required this.currTable,
      required this.POSBizDate});

  @override
  List<Object> get props => [reSendOrder, typeLoad, currTable, POSBizDate];
}

class HideShowCombo extends CartEvent {
  const HideShowCombo();

  @override
  List<Object> get props => [];
}