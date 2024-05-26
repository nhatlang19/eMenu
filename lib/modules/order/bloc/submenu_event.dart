part of 'submenu_bloc.dart';

sealed class SubmenuEvent extends Equatable {
  const SubmenuEvent();

  @override
  List<Object> get props => [];
}

class FetchSubmenu extends SubmenuEvent {
  final String selectedPosMenu;
  final String posGroup;

  const FetchSubmenu({required this.selectedPosMenu, required this.posGroup});
}

class ChangeSubmenu extends SubmenuEvent {
  final Submenu submenu;

  const ChangeSubmenu({required this.submenu});
}

class ChangeSelectedMenu extends SubmenuEvent {
  final Menu menu;

  const ChangeSelectedMenu({required this.menu});
}

