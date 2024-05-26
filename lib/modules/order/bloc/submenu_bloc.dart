import 'package:bloc/bloc.dart';
import 'package:emenu/models/menu.dart';
import 'package:emenu/repositories/menu_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:emenu/models/submenu.dart';

part 'submenu_event.dart';
part 'submenu_state.dart';

class SubMenuBloc extends Bloc<SubmenuEvent, SubmenuState> {
  final MenuRepository _menuRepository;

  SubMenuBloc(
      {required MenuRepository menuRepository,
})
      : _menuRepository = menuRepository,
        super(const SubmenuState()) {
    on<FetchSubmenu>(_onFetchSubMenus);
    on<ChangeSubmenu>(_onChangeSubMenu);
  }

  Future<void> _onFetchSubMenus(FetchSubmenu event, Emitter<SubmenuState> emit) async {
    try {
      // if (state.status == SubmenuStatus.initial) {
        List<Submenu> menus = await _menuRepository.getSubsMenu(
          selectedPosMenu: event.selectedPosMenu,
          posGroup: event.posGroup);
        emit(state.copyWith(submenus: menus, status: SubmenuStatus.success, submenu: menus.first));
      // }
    } catch (_) {
      emit(state.copyWith(status: SubmenuStatus.failure));
    }
  }

  void _onChangeSubMenu(ChangeSubmenu event, Emitter<SubmenuState> emit) {
    emit(state.copyWith(submenu: event.submenu, status: SubmenuStatus.changed));
  }
}
