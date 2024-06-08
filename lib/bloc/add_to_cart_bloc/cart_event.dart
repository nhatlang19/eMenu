part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Submenu currSubItem;
  final int qty;
  final String? priceLevel;


  const AddToCart({required this.currSubItem, required this.qty,  this.priceLevel});

  @override
   List<Object> get props => [currSubItem, qty, priceLevel!];
}