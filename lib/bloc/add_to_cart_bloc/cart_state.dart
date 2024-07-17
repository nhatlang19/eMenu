part of 'cart_bloc.dart';

enum CartStatus { initial, addToCart, failure, success, updatedQuantity, sendOrderInitial, sendOrderSuccess, sendOrderFail }

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final CartStatus status;
  final dynamic total;
  final bool toogle;
  final String noPeople;

  const CartState(
      {this.cartItems = const <CartItem>[],
      this.status = CartStatus.initial,
      this.total = 0,
      this.toogle = false,
      this.noPeople = "1"});

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    dynamic? total,
    bool? toogle,
    String? noPeople,
  }) {
    return CartState(
        status: status ?? this.status,
        cartItems: cartItems ?? this.cartItems,
        total: total ?? this.total,
        toogle: toogle ?? this.toogle,
        noPeople: noPeople ?? this.noPeople);
  }

  @override
  List<Object> get props => [cartItems, status, total, toogle, noPeople];
}
