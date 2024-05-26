part of 'menu_bloc.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object> get props => [];
}

class FetchMenu extends MenuEvent {
  final String posGroup;

  const FetchMenu({required this.posGroup});
}

class ChangeMenu extends MenuEvent {
  final Menu menu;

  const ChangeMenu({required this.menu});
}