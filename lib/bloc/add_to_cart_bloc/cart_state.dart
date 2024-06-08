part of 'cart_bloc.dart';

enum CartStatus { initial, addToCart, failure, success }

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final CartStatus status;

  const CartState({
    this.cartItems = const <CartItem>[],
    this.status = CartStatus.initial,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object> get props => [cartItems, status];
}
