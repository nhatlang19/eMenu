import 'package:bloc/bloc.dart';
import 'package:emenu/models/menu.dart';
import 'package:emenu/repositories/menu_repository.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository _menuRepository;

  MenuBloc(
      {required MenuRepository menuRepository,
})
      : _menuRepository = menuRepository,
        super(const MenuState()) {
    on<FetchMenu>(_onFetchMenus);
    on<ChangeMenu>(_onChangeMenu);
  }

  Future<void> _onFetchMenus(FetchMenu event, Emitter<MenuState> emit) async {
    try {
      if (state.status == MenuStatus.initial) {
        List<Menu> menus = await _menuRepository.getPosMenu(
            posGroup: event.posGroup);
        emit(state.copyWith(menus: menus, status: MenuStatus.success, menu: menus.first, posGroup: event.posGroup));
      }
    } catch (_) {
      emit(state.copyWith(status: MenuStatus.failure));
    }
  }

  void _onChangeMenu(ChangeMenu event, Emitter<MenuState> emit) {
    emit(state.copyWith(menu: event.menu, status: MenuStatus.changed));
  }
}
