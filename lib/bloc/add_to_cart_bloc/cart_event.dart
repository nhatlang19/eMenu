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
