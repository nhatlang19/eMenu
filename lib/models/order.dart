import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order extends Equatable {
  @JsonKey(name: 'OrdExt')
  final String ordExt;
  @JsonKey(name: 'PosPerScode')
  final String posPerScode;
  @override
  List<Object> get props => [ordExt, posPerScode];

  static const empty = Order(ordExt: '0_0', posPerScode: '0_0_0');

  const Order({
    required this.ordExt,
    required this.posPerScode,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  String getOrd() {
    var list = ordExt.split('_');
    return list[0];
  }

  String getExt() {
    var list = ordExt.split('_');
    if (list.length < 2) {
      return '0';
    }
    return list[1];
  }

  String getPos() {
		var list = posPerScode.split("_");
		return list[0];
	}

	String getPer() {
		var list = posPerScode.split("_");
		return list[1];
	}
	
	String getSalesCode() {
		var list = posPerScode.split("_");
		return list[2];
	}
}
