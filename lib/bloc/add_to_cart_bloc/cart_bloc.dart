import 'package:bloc/bloc.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/cart_item.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/cart_item_combo.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/cart_item_modifier.dart';
import 'package:emenu/constants/item_combo_pack.dart';
import 'package:emenu/constants/order.dart' as ContantOrder;
import 'package:emenu/models/order.dart';
import 'package:emenu/models/item.dart';
import 'package:emenu/models/item_combo.dart';
import 'package:emenu/models/item_modifier.dart';
import 'package:emenu/models/submenu.dart';
import 'package:emenu/repositories/cart_repository.dart';
import 'package:emenu/repositories/item_repository.dart';
import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/settings.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ItemRepository _itemRepository;
  final CartRepository _cartRepository;

  CartBloc(
      {required ItemRepository itemRepository,
      required CartRepository cartRepository})
      : _itemRepository = itemRepository,
        _cartRepository = cartRepository,
        super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<AddToCartWithCombo>(_onAddToCartWithCombo);
    on<HideShowCombo>(_onHideShowCombo);
    on<SkipShowCombo>(_onSkipShowCombo);
    on<Increase>(_onIncrease);
    on<Decrease>(_onDecrease);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<Toogle>(_onToogle);
    on<UpdateNoPeople>(_onUpdateNoPeople);
    on<ResetCart>(_onResetCart);
    on<SendOrder>(_onSendOrder);
    on<UpdateQuantityCombo>(_onUpdateQuantityCombo);
    on<LoadItemsWhenEdit>(_onLoadItemsWhenEdit);
  }

  void _onResetCart(ResetCart event, Emitter<CartState> emit) {
    emit(state.copyWith(
        status: CartStatus.initial,
        cartItems: [],
        total: 0,
        toogle: false,
        noPeople: "1"));
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(status: CartStatus.initial));
      var settings = Settings();
      var setting = await settings.read();
      var qty = 0;
      if (setting.type != "1") {
        qty = 1;
      }

      if (state.noPeople == '0') {
        qty = 1;
      } else {
        qty = int.parse(state.noPeople);
      }

      Item item = await _itemRepository.getItemBySubMenuSelected(
          currSubItem: event.currSubItem.defaultValue,
          qty: qty,
          priceLevel: "");

      if (item.getComboPack() == ItemComboPack.N ||
          item.getComboPack() == ItemComboPack.R) {
        var list = List<CartItem>.from(state.cartItems);

        final index = list.indexWhere((element) => element.item.itemCode == item.itemCode);
        if (index >= 0) {
          state.cartItems[index].qty += 1;
          state.cartItems[index].updateData();
          double total = list.fold(
              0,
              (tot, item) =>
                  tot.toDouble() +
                  (double.parse(item.item.getOrgPrice()) * item.qty -
                      double.parse(item.item.promoPrice)));
          emit(state.copyWith(cartItems: state.cartItems, status: CartStatus.success, total: total));
        } else {
          final data = List<CartItem>.from(state.cartItems)
            ..add(CartItem(item: item, qty: qty, segNo: state.cartItems.length + 1));
          double total = data.fold(
              0,
              (tot, item) =>
                  tot.toDouble() +
                  (double.parse(item.item.getOrgPrice()) * item.qty -
                      double.parse(item.item.promoPrice)));

          emit(state.copyWith(cartItems: data, status: CartStatus.success, total: total));
        }
      } else if (item.getComboPack() == ItemComboPack.C) {
        List<ItemCombo> itemComboList =
            await _itemRepository.getItemComboBySubMenuSelected(
                currSubItem: event.currSubItem.defaultValue);
        List<CartItemModifier> cartItemModifierList = [];
        for (var itemCombo in itemComboList) {
          if (itemCombo.modClass == null) {
            ItemModifier child = ItemModifier(
                itemCode: itemCombo.comboItem,
                modCode: "0",
                quantity: itemCombo.quantity,
                modDesc: itemCombo.itemDesc,
                unitPrice: "0");

            CartItemModifier cartItemModifier = CartItemModifier(itemModifier: child, hasDefaultValue: true);
            final data = List<CartItemModifier>.from(cartItemModifierList)..add(cartItemModifier);

            CartItemCombo cartItemCombo = CartItemCombo(itemCombo: itemCombo, cartItemModifierList: data);
            final cartItemComboList = List<CartItemCombo>.from(state.cartItemTmp.cartItemComboList)..add(cartItemCombo);
            CartItem cartItem = CartItem(item: item, qty: 1, segNo: state.cartItems.length + 1);
            cartItem.cartItemComboList = cartItemComboList;
            emit(state.copyWith(cartItemTmp: cartItem));
          } else {
            List<ItemModifier> itemModifiers = await _itemRepository.getModifierByModifierItem(modifierItem: (itemCombo.modClass) as String);
            CartItemCombo cartItemCombo = CartItemCombo(itemCombo: itemCombo, cartItemModifierList: []);
            cartItemCombo.initFromItemModifiers(itemModifiers);

            final cartItemComboList = List<CartItemCombo>.from(state.cartItemTmp.cartItemComboList)..add(cartItemCombo);
            CartItem cartItem = CartItem(item: item, qty: 1, segNo: state.cartItems.length + 1);
            cartItem.cartItemComboList = cartItemComboList;
            emit(state.copyWith(cartItemTmp: cartItem));
          }
        }
        emit(state.copyWith(showCombo: ShowCombo.show));
      }
      emit(state.copyWith(noPeople: "0", errorMessage: ''));
    } catch (_) {
      emit(state.copyWith(status: CartStatus.failure, noPeople: "0", errorMessage: ''));
    }
  }

  Future<void> _onLoadItemsWhenEdit(LoadItemsWhenEdit event, Emitter<CartState> emit) async {
    try {
      List<Item> items = await _cartRepository.getEditOrderNumberByPOS(orderNo: event.orderNo, posNo: event.posNo, extNo: event.extNo);
      var list = List<CartItem>.from(state.cartItems);
      // @TODO: need to handle for combo
      for (var item in items) {
        list.add(CartItem(item: item, qty: int.parse(item.qty ?? '0'), segNo: int.parse(item.seqNo ?? '0')));
      }
      double total = list.fold(0,(tot, item) => tot.toDouble() + (double.parse(item.item.getOrgPrice()) * item.qty - double.parse(item.item.promoPrice)));
      emit(state.copyWith(cartItems: list, status: CartStatus.success, total: total));
    } catch(e) {
      emit(state.copyWith(status: CartStatus.failure, noPeople: "0", errorMessage: ''));
    }
  }

  Future<void> _onAddToCartWithCombo(
      AddToCartWithCombo event, Emitter<CartState> emit) async {
    try {
      emit(state.copyWith(status: CartStatus.initial));

      bool isError = false;
      String errorMessage = '';
      for (var itemCombo in state.cartItemTmp.cartItemComboList) {
          errorMessage = itemCombo.isValid();
          if (errorMessage.isNotEmpty) {
            isError = true;
            break;
          }
      }
      
      if (isError) {
        emit(state.copyWith(status: CartStatus.addToCartComboFailure, errorMessage: errorMessage));
      } else {
        CartItem cartItemTmp = state.cartItemTmp;
        cartItemTmp.segNo = state.cartItems.length + 1;
        var childCartItems = cartItemTmp.convertChildToCartItems();
        cartItemTmp.cartItemComboList = [];

        final lists = List<CartItem>.from(state.cartItems);
        lists.add(cartItemTmp);
        for (CartItem child in childCartItems) {
          lists.add(child);
        }
        // final data = List<CartItem>.from(state.cartItems)..add(cartItemTmp);
        double total = lists.fold(
            0,
            (tot, item) =>
                tot.toDouble() +
                (double.parse(item.item.getOrgPrice()) * item.qty -
                    double.parse(item.item.promoPrice)));
        emit(state.copyWith(
            cartItemTmp: CartItem.empty,
            cartItems: lists,
            errorMessage: '',
            status: CartStatus.success,
            total: total,
            noPeople: "0",
            showCombo: ShowCombo.hide));

        event.callback();
      }
    } catch (_) {
      emit(state.copyWith(
          status: CartStatus.failure, noPeople: "0", showCombo: ShowCombo.hide, errorMessage: ''));
      event.callback();
    }
  }

  void _onHideShowCombo(HideShowCombo event, Emitter<CartState> emit) {
    emit(state.copyWith(showCombo: ShowCombo.hide, cartItemTmp: CartItem.empty));
  }

  void _onSkipShowCombo(SkipShowCombo event, Emitter<CartState> emit) {
    emit(state.copyWith(showCombo: ShowCombo.skip));
  }

  void _onIncrease(Increase event, Emitter<CartState> emit) {
    state.cartItems[event.position].qty += 1;
    state.cartItems[event.position].updateData();
    emit(state.copyWith(status: CartStatus.initial));
    double total = state.cartItems.fold(
        0,
        (tot, item) =>
            tot.toDouble() +
            (double.parse(item.item.getOrgPrice()) * item.qty -
                double.parse(item.item.promoPrice)));
    emit(state.copyWith(
        cartItems: state.cartItems,
        status: CartStatus.updatedQuantity,
        total: total));
    emit(state.copyWith(status: CartStatus.initial));
  }

  void _onDecrease(Decrease event, Emitter<CartState> emit) {
    emit(state.copyWith(status: CartStatus.initial));
    final lists = state.cartItems;
    var item = lists[event.position];
    if (item.qty > 1) {
      lists[event.position].qty -= 1;
      lists[event.position].updateData();
    } else {
      final isCombo = lists[event.position].item.comboPack == "C";
      lists.removeAt(event.position);
      if (isCombo) {
        var position = event.position;
        do {
          if (position < lists.length && lists[position].item.getItemType() == "M") {
            lists.removeAt(position);
          } else {
            break;
          }
        } while (true);
      }
    }
    double total = state.cartItems.fold(
        0,
        (tot, item) =>
            tot.toDouble() +
            (double.parse(item.item.getOrgPrice()) * item.qty -
                double.parse(item.item.promoPrice)));
    emit(state.copyWith(
        cartItems: lists,
        status: CartStatus.updatedQuantity,
        total: total));
    emit(state.copyWith(status: CartStatus.initial));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    emit(state.copyWith(status: CartStatus.initial));
    if (event.value > 0) {
      state.cartItems[event.position].qty = event.value;
      state.cartItems[event.position].updateData();
    }

    double total = state.cartItems.fold(
        0,
        (tot, item) =>
            tot.toDouble() +
            (double.parse(item.item.getOrgPrice()) * item.qty -
                double.parse(item.item.promoPrice)));
    emit(state.copyWith(
        cartItems: state.cartItems,
        status: CartStatus.updatedQuantity,
        total: total));
    emit(state.copyWith(status: CartStatus.initial));
  }

  void _onUpdateQuantityCombo(UpdateQuantityCombo event, Emitter<CartState> emit) {
    emit(state.copyWith(status: CartStatus.initial));
    if (event.value >= 0) {
      state.cartItemTmp.cartItemComboList[event.comboPosition].cartItemModifierList[event.position].quantity = event.value;
    }
    emit(state.copyWith(cartItemTmp: state.cartItemTmp, status: CartStatus.updatedQuantityCombo));
  }

  void _onToogle(Toogle event, Emitter<CartState> emit) {
    emit(state.copyWith(toogle: !state.toogle));
  }

  void _onUpdateNoPeople(UpdateNoPeople event, Emitter<CartState> emit) {
    if (event.value == 'C') {
      emit(state.copyWith(noPeople: "1"));
    } else if (event.value == '←') {
      if (state.noPeople.length == 1) {
        emit(state.copyWith(noPeople: "0"));
      } else {
        emit(state.copyWith(
            noPeople: state.noPeople.substring(0, state.noPeople.length - 1)));
      }
    } else {
      if (state.noPeople == '0') {
        emit(state.copyWith(noPeople: event.value));
      } else {
        var newValue = state.noPeople + event.value;
        if (newValue.isNotEmpty && newValue.length <= 2) {
          emit(state.copyWith(noPeople: newValue));
        }
      }
    }
  }

  Future<void> _onSendOrder(SendOrder event, Emitter<CartState> emit) async {
    try {
      var settings = Settings();
      var setting = await settings.read();
      var cashier = await Global.getCashier();

      String posNo = setting.posId;
      String orderNo = "";
      String extNo = "0";
      if (event.isAddNew) {
        orderNo = await _cartRepository.getNewOrderNumberByPOS(posNo);
      } else {
        posNo = event.order.getPos();
        orderNo = event.order.getOrd();
        extNo = event.order.getExt();
      }
      
      String dataTableString = state.getString();
      String splited = '0';

      emit(state.copyWith(status: CartStatus.sendOrderInitial));

      // bool flag = false;
      // for (var i = state.cartItems.length - 1; !flag && i >= 0; i--) {
      //   int segNo = state.cartItems[i].segNo;
      //   if (segNo != i + 1) {
      //     flag = true;
      //   }
      // }
      // if (flag) {
      //   emit(state.copyWith(status: CartStatus.sendOrderDuplicate));
      //   return;
      // }
      print(dataTableString);
      var result = await _cartRepository.sendOrder(
          dataTableString: dataTableString,
          sendNewOrder: event.sendNewOrder,
          reSendOrder: event.reSendOrder,
          typeLoad: event.typeLoad,
          posNo: posNo,
          orderNo: orderNo,
          extNo: extNo,
          splited: splited,
          currTable: event.currTable,
          POSBizDate: event.POSBizDate,
          currTableGroup: event.currTableGroup,
          noOfPerson: event.noOfPerson,
          salesCode: event.salesCode,
          cashierID: cashier.cashierID ?? '');
      if (result) {
        emit(state.copyWith(status: CartStatus.sendOrderSuccess));
      } else {
        emit(state.copyWith(status: CartStatus.sendOrderFail, errorMessage: 'Bị lỗi khi gửi đơn hàng'));
      }
      emit(state.copyWith(status: CartStatus.sendOrderInitial, errorMessage: ''));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.sendOrderFail, errorMessage: e.toString()));
      emit(state.copyWith(status: CartStatus.sendOrderInitial, errorMessage: ''));
    }
  }
}
