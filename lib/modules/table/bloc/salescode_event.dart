part of 'salescode_bloc.dart';

sealed class SalesCodeEvent extends Equatable {
  const SalesCodeEvent();

  @override
  List<Object> get props => [];
}

class FetchSalesCode extends SalesCodeEvent {

  const FetchSalesCode();
}


class ChangeSelectSalesCode extends SalesCodeEvent {
  final SalesCode code;

  const ChangeSelectSalesCode({required this.code});
}