import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  @JsonKey(name: 'CashierID')
  final String? cashierID;
  @JsonKey(name: 'CashierName')
  final String? cashierName;
  @JsonKey(name: 'CashierPwd')
  final String? cashierPwd;
  @JsonKey(name: 'UserGroup')
  final String? userGroup;

  

  @override
  List<Object> get props => [cashierID ?? '', cashierName ?? '', cashierPwd ?? '', userGroup ?? ''];

  static const empty = User(cashierID: '', cashierName: '', cashierPwd: '', userGroup: '');

  const User({this.cashierID, this.cashierName, this.cashierPwd, this.userGroup});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

   Map<String, dynamic> toJson() =>
    {
      'cashierID': cashierID,
      'cashierName': cashierName,
      'cashierPwd': cashierPwd,
      'userGroup': userGroup
    };
}
