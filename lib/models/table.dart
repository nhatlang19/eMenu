import 'package:emenu/config/themes/app_colors.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table.g.dart';

@JsonSerializable(includeIfNull: false)
class Table extends Equatable {
  @JsonKey(name: 'TableNo')
  final String TableNo;
  @JsonKey(name: 'Status')
  final String? Status;
  @JsonKey(name: 'OpenBy')
  final String? OpenBy;
  @JsonKey(name: 'Desciption')
  final String? Desciption;
  @JsonKey(name: 'SalesCode')
  final String? SalesCode;

  @override
  List<Object> get props =>
      [TableNo, Status ?? '', OpenBy ?? '', Desciption ?? '', SalesCode ?? ''];

  static const empty = Table(
      TableNo: '', Status: '', OpenBy: null, Desciption: '', SalesCode: '');
      
      
  const Table(
      {required this.TableNo,
      this.Status,
      this.OpenBy,
      this.Desciption,
      this.SalesCode});

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);

  bool openByIsEmpty() {
    return OpenBy == null || OpenBy == '' || (OpenBy != null && OpenBy!.isEmpty) || (OpenBy != null && OpenBy!.trim() == "null");
  }

  getColor() {
    switch (Status) {
      case 'A':
        return AppColors.item_a;
      case 'B':
        return AppColors.item_b;
      case 'R':
        return AppColors.item_r;
      case 'O':
        return AppColors.item_o;
      default:
        return AppColors.item_a;
    }
  }
}
