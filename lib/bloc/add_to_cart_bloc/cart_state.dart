part of 'cart_bloc.dart';

enum CartStatus { initial, addToCart, failure, success, updatedQuantity }

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final CartStatus status;
  final dynamic total;

  const CartState({
    this.cartItems = const <CartItem>[],
    this.status = CartStatus.initial,
    this.total = 0,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    dynamic? total
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [cartItems, status];
}
