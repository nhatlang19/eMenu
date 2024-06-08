part of 'salescode_bloc.dart';

enum SalesCodeStatus { initial, success, failure, changed }

final class SalesCodeState extends Equatable {
  const SalesCodeState({
    this.status = SalesCodeStatus.initial,
    this.salescodes = const <SalesCode>[],
    this.selectedCode = SalesCode.empty,
  });

  final SalesCodeStatus status;
  final List<SalesCode> salescodes;
  final SalesCode selectedCode;

  SalesCodeState copyWith({
    SalesCodeStatus? status,
    List<SalesCode>? salescodes,
    SalesCode? selectedCode
  }) {
    return SalesCodeState(
      status: status ?? this.status,
      salescodes: salescodes ?? this.salescodes,
      selectedCode: selectedCode ?? this.selectedCode,
    );
  }
  @override
  List<Object> get props => [status, salescodes, selectedCode];
}
