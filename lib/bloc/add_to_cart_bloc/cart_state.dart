part of 'cart_bloc.dart';

enum CartStatus {
  initial,
  addToCart,
  failure,
  success,
  updatedQuantity,
  sendOrderInitial,
  sendOrderDuplicate,
  sendOrderSuccess,
  sendOrderFail
}

class CartState extends Equatable {
  final List<CartItem> cartItems;
  final CartStatus status;
  final dynamic total;
  final bool toogle;
  final String noPeople;
  final bool showCombo;
  late CartItem cartItemTmp;

  CartState(
      {
      this.cartItems = const <CartItem>[],
      this.status = CartStatus.initial,
      this.total = 0,
      this.toogle = false,
      this.showCombo = false,
      this.noPeople = "0",}) {
        this.cartItemTmp = CartItem.empty;
      }

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    dynamic? total,
    bool? toogle,
    bool? showCombo,
    String? noPeople,
    CartItem? cartItemTmp
  }) {
    var state = CartState(
        status: status ?? this.status,
        cartItems: cartItems ?? this.cartItems,
        total: total ?? this.total,
        toogle: toogle ?? this.toogle,
        showCombo: showCombo ?? this.showCombo,
        noPeople: noPeople ?? this.noPeople);

    state.cartItemTmp = cartItemTmp ?? this.cartItemTmp;
    return state;
  }

  CartState updateCartItemTmp(CartItem cartItemTmp) {
    this.cartItemTmp = cartItemTmp;
    return this;
  }

  @override
  List<Object> get props => [
        cartItems,
        status,
        total,
        toogle,
        noPeople,
        showCombo,
        cartItemTmp,
      ];
}
