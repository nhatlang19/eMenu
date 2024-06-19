part of 'cart_bloc.dart';

enum CartStatus { initial, addToCart, failure, success, updatedQuantity }

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final CartStatus status;
  final dynamic total;
  final bool toogle;

  const CartState({
    this.cartItems = const <CartItem>[],
    this.status = CartStatus.initial,
    this.total = 0,
    this.toogle = false,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    dynamic? total,
    bool? toogle,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      total: total ?? this.total,
      toogle: toogle ?? this.toogle,
    );
  }

  @override
  List<Object> get props => [cartItems, status, total, toogle];
}
