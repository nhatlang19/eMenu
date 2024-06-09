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
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      var settings = Settings();
      var setting = await settings.read();
      var qty = 0;
      if (setting.type != "1") {
        qty = 1;
      }

      Item item = await _itemRepository.getItemBySubMenuSelected(currSubItem: event.currSubItem.defaultValue, qty: qty, priceLevel: "");
      var list = List<CartItem>.from(state.cartItems);

      final index = list.indexWhere((element) => element.item.itemCode == item.itemCode);
      if (index >= 0) {
        state.cartItems[index].qty += 1;
        double total = list.fold(0, (tot, item) => tot.toDouble() + (double.parse(item.item.unitSellPrice) * item.qty - double.parse(item.item.promoPrice)));
        emit(state.copyWith(cartItems: state.cartItems, status: CartStatus.success, total: total));
      } else {
        final data = List<CartItem>.from(state.cartItems)..add(CartItem(item: item, qty: qty));
        double total = data.fold(0, (tot, item) => tot.toDouble() + (double.parse(item.item.unitSellPrice) * item.qty - double.parse(item.item.promoPrice)));
        
        emit(state.copyWith(cartItems: data, status: CartStatus.success, total: total));
      }
    } catch (_) {
      emit(state.copyWith(status: CartStatus.failure));
    }
  }
}
