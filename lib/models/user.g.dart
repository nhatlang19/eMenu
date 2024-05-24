// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'User',
      json,
      ($checkedConvert) {
        final val = User(
          cashierID: $checkedConvert('CashierID', (v) => v as String?),
          cashierName: $checkedConvert('CashierName', (v) => v as String?),
          cashierPwd: $checkedConvert('CashierPwd', (v) => v as String?),
          userGroup: $checkedConvert('UserGroup', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'cashierID': 'CashierID',
        'cashierName': 'CashierName',
        'cashierPwd': 'CashierPwd',
        'userGroup': 'UserGroup'
      },
    );
