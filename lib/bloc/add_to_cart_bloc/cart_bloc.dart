import 'package:bloc/bloc.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/CartItem.dart';
import 'package:emenu/models/item.dart';
import 'package:emenu/models/submenu.dart';
import 'package:emenu/repositories/item_repository.dart';
import 'package:emenu/utils/settings.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ItemRepository _itemRepository;

  CartBloc({required ItemRepository itemRepository})
      : _itemRepository = itemRepository,
        super(CartState()) {
    on<AddToCart>(_onAddToCart);
    on<Increase>(_onIncrease);
    on<Decrease>(_onDecrease);
    on<UpdateQuantity>(_onUpdateQuantity);
    on<Toogle>(_onToogle);
    on<UpdateNoPeople>(_onUpdateNoPeople);
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
      var list = List<CartItem>.from(state.cartItems);

      final index =
          list.indexWhere((element) => element.item.itemCode == item.itemCode);
      if (index >= 0) {
        state.cartItems[index].qty += 1;
        double total = list.fold(
            0,
            (tot, item) =>
                tot.toDouble() +
                (double.parse(item.item.unitSellPrice) * item.qty -
                    double.parse(item.item.promoPrice)));
        emit(state.copyWith(
            cartItems: state.cartItems,
            status: CartStatus.success,
            total: total));
      } else {
        final data = List<CartItem>.from(state.cartItems)
          ..add(CartItem(item: item, qty: qty));
        double total = data.fold(
            0,
            (tot, item) =>
                tot.toDouble() +
                (double.parse(item.item.unitSellPrice) * item.qty -
                    double.parse(item.item.promoPrice)));

        emit(state.copyWith(
            cartItems: data, status: CartStatus.success, total: total));
      }
      emit(state.copyWith(noPeople: "1"));
    } catch (_) {
      emit(state.copyWith(status: CartStatus.failure));
      emit(state.copyWith(noPeople: "1"));
    }
  }

  void _onIncrease(Increase event, Emitter<CartState> emit) {
    state.cartItems[event.position].qty += 1;

    emit(state.copyWith(status: CartStatus.initial));
    double total = state.cartItems.fold(
        0,
        (tot, item) =>
            tot.toDouble() +
            (double.parse(item.item.unitSellPrice) * item.qty -
                double.parse(item.item.promoPrice)));
    emit(state.copyWith(
        cartItems: state.cartItems,
        status: CartStatus.updatedQuantity,
        total: total));
    emit(state.copyWith(status: CartStatus.initial));
  }

  void _onDecrease(Decrease event, Emitter<CartState> emit) {
    emit(state.copyWith(status: CartStatus.initial));
    var item = state.cartItems[event.position];
    if (item.qty > 1) {
      state.cartItems[event.position].qty -= 1;
    } else {
      state.cartItems.removeAt(event.position);
    }
    double total = state.cartItems.fold(
        0,
        (tot, item) =>
            tot.toDouble() +
            (double.parse(item.item.unitSellPrice) * item.qty -
                double.parse(item.item.promoPrice)));
    emit(state.copyWith(
        cartItems: state.cartItems,
        status: CartStatus.updatedQuantity,
        total: total));
    emit(state.copyWith(status: CartStatus.initial));
  }

  void _onUpdateQuantity(UpdateQuantity event, Emitter<CartState> emit) {
    emit(state.copyWith(status: CartStatus.initial));
    if (event.value > 0) {
      state.cartItems[event.position].qty = event.value;
    }

    double total = state.cartItems.fold(
        0,
        (tot, item) =>
            tot.toDouble() +
            (double.parse(item.item.unitSellPrice) * item.qty -
                double.parse(item.item.promoPrice)));
    emit(state.copyWith(
        cartItems: state.cartItems,
        status: CartStatus.updatedQuantity,
        total: total));
    emit(state.copyWith(status: CartStatus.initial));
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
        emit(state.copyWith(noPeople: state.noPeople.substring(0, state.noPeople.length - 1))); 
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
}
