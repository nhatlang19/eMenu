import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'sales_code.g.dart';

@JsonSerializable()
class SalesCode extends Equatable {
  @JsonKey(name: 'Code')
  final String code;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'PriceLevel')
  final String? priceLevel;
  @JsonKey(name: 'TaxClass')
  final String? taxClass;
  @JsonKey(name: 'MemberType')
  final String? memberType;

  @override
  List<Object> get props => [description, code, priceLevel ?? '', taxClass ?? '', memberType ?? ''];

  static const empty =
      SalesCode(description: '', code: '', priceLevel: '', taxClass: '', memberType: '');

  const SalesCode({
    required this.code,
    required this.description,
    required this.priceLevel,
    required this.taxClass,
    required this.memberType
  });

  factory SalesCode.fromJson(Map<String, dynamic> json) => _$SalesCodeFromJson(json);
}
