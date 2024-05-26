part of 'menu_bloc.dart';

enum MenuStatus { initial, success, failure, changed }

final class MenuState extends Equatable {
  const MenuState({
    this.status = MenuStatus.initial,
    this.menus = const <Menu>[],
    this.menu = Menu.empty,
    this.posGroup = '',
  });

  final MenuStatus status;
  final List<Menu> menus;
  final Menu menu;
  final String posGroup;

  MenuState copyWith({
    MenuStatus? status,
    List<Menu>? menus,
    Menu? menu,
    String? posGroup
  }) {
    return MenuState(
      status: status ?? this.status,
      menus: menus ?? this.menus,
      menu: menu ?? this.menu,
      posGroup: posGroup ?? this.posGroup
    );
  }
  @override
  List<Object> get props => [status, menus, menu, posGroup];
}
