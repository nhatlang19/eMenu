part of 'submenu_bloc.dart';

enum SubmenuStatus { initial, success, failure, changed }

final class SubmenuState extends Equatable {
  const SubmenuState({
    this.status = SubmenuStatus.initial,
    this.submenus = const <Submenu>[],
    this.submenu = Submenu.empty,
    this.selectedPosMenu = Menu.empty
  });

  final SubmenuStatus status;
  final List<Submenu> submenus;
  final Submenu submenu;
  final Menu selectedPosMenu;

  SubmenuState copyWith({
    SubmenuStatus? status,
    List<Submenu>? submenus,
    Submenu? submenu,
    Menu? selectedPosMenu
  }) {
    return SubmenuState(
      status: status ?? this.status,
      submenus: submenus ?? this.submenus,
      submenu: submenu ?? this.submenu,
      selectedPosMenu: selectedPosMenu ?? this.selectedPosMenu
    );
  }
  @override
  List<Object> get props => [status, submenus, submenu];
}
