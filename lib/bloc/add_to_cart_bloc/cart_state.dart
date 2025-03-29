part of 'cart_bloc.dart';

enum CartStatus {
  initial,
  addToCart,
  failure,
  success,
  addToCartComboFailure,
  updatedQuantity,
  updatedQuantityCombo,
  updatedNoGuest,
  sendOrderInitial,
  sendOrderDuplicate,
  sendOrderSuccess,
  sendOrderFail
}

enum ShowCombo {
  hide,
  show,
  skip
}

enum ShowOpenItem {
  hide,
  show,
  skip
}

// ignore: must_be_immutable
class CartState extends Equatable {
  final List<CartItem> cartItems;
  final CartStatus status;
  final dynamic total;
  final bool toogle;
  final String customQuantity;
  final ShowCombo showCombo;
  final ShowOpenItem showOpenItem;
  late CartItem cartItemTmp;
  final String errorMessage;
  final Table selectedTable;
  final int noGuest;

  CartState(
      {
      this.cartItems = const <CartItem>[],
      this.status = CartStatus.initial,
      this.selectedTable = Table.empty,
      this.total = 0,
      this.toogle = false,
      this.showCombo = ShowCombo.hide,
      this.showOpenItem = ShowOpenItem.hide,
      this.errorMessage = '',
      this.customQuantity = "0",
      this.noGuest = 2,
      }) {
        cartItemTmp = CartItem.empty;
      }

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    dynamic total,
    bool? toogle,
    ShowCombo? showCombo,
    ShowOpenItem? showOpenItem,
    String? customQuantity,
    CartItem? cartItemTmp,
    String? errorMessage,
    Table? selectedTable,
    int? noGuest,
  }) {
    var state = CartState(
        status: status ?? this.status,
        cartItems: cartItems ?? this.cartItems,
        total: total ?? this.total,
        toogle: toogle ?? this.toogle,
        showCombo: showCombo ?? this.showCombo,
        showOpenItem: showOpenItem ?? this.showOpenItem,
        selectedTable: selectedTable ?? this.selectedTable,
        errorMessage: errorMessage ?? this.errorMessage,
        customQuantity: customQuantity ?? this.customQuantity,
        noGuest: noGuest ?? this.noGuest);

    state.cartItemTmp = cartItemTmp ?? this.cartItemTmp;
    return state;
  }

  CartState updateCartItemTmp(CartItem cartItemTmp) {
    this.cartItemTmp = cartItemTmp;
    return this;
  }

  String getString() {
    List<String> lists = [];
    var seqNo = 0;
    for (CartItem cartItem in cartItems) {
      seqNo++;
      if (cartItem.item.printStatus != '') {
        continue;
      }
      cartItem.segNo = seqNo;
      lists.add(cartItem.toString());
    }

    return lists.join("*V#A*");
  }

  String getStatus({bool isEdit = false})
  {
      String result = ContantOrder.Order.STATUS_DATATABLE_SEND_ALL;
      if (cartItems.isEmpty)
      {
          result = ContantOrder.Order.STATUS_DATATABLE_NO_DATA;
      }
      else if (isEdit) {
        bool isNew = false;
        for (int i = cartItems.length - 1; !isNew && i >= 0; i--)
        {
          CartItem cartItem = cartItems[i];
          if (!(cartItem.item.getPrintStatusStr() == Item.STATUS_CANCEL) && !(cartItem.item.getPrintStatusStr() == Item.STATUS_OLD)) {
            isNew = true;
          }
        }

        if (isNew) {
            result = ContantOrder.Order.STATUS_DATATABLE_SEND_ALL;
        }
        else { // resend
            result = ContantOrder.Order.STATUS_DATATABLE_RESEND;
        }
      }

      return result;
  }

  @override
  List<Object> get props => [
        cartItems,
        status,
        total,
        toogle,
        customQuantity,
        showCombo,
        showOpenItem,
        cartItemTmp,
        errorMessage,
        selectedTable,
        noGuest,
      ];
}
