import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  // ignore: constant_identifier_names
  static const String STATUS_OLD = "#";
  // ignore: constant_identifier_names
  static const String STATUS_CANCEL = "C";

  @JsonKey(name: 'ItemCode')
  final String itemCode;
  @JsonKey(name: 'ItemType')
  final String? itemType;
  @JsonKey(name: 'RecptDesc')
  final String recptDesc;
  @JsonKey(name: 'UnitSellPrice')
  final String? unitSellPrice;
  @JsonKey(name: 'ComboPack')
  final String? comboPack;
  @JsonKey(name: 'WeightItem')
  final String weightItem;
  @JsonKey(name: 'OnPromotion')
  final String? onPromotion;
  @JsonKey(name: 'PromoPrice')
  final String promoPrice;
  @JsonKey(name: 'Discountable')
  final String discountable;
  @JsonKey(name: 'Modifier')
  final String? modifierInt;
  @JsonKey(name: 'MasterCode')
  final String? masterCode;
  @JsonKey(name: 'Hidden')
  final String? hidden;
  @JsonKey(name: 'PromoCode')
  final String? promoCode;
  @JsonKey(name: 'PromoClass')
  final String? promoClass;
  @JsonKey(name: 'PkgPrice')
  final String? pkgPrice;
  @JsonKey(name: 'PkgQty')
  final String? pkgQty;
  @JsonKey(name: 'PkgItems')
  final String? pkgItems;
  @JsonKey(name: 'Blanket')
  final String? blanket;
  @JsonKey(name: 'Tax')
  final String? tax;
  // for edit
  @JsonKey(name: 'Status')
  final String? printStatus;
  @JsonKey(name: 'Qty')
  final String? qty;
  @JsonKey(name: 'Splited')
  final String? splited;
  @JsonKey(name: 'SeqNo')
  final String? seqNo;
  @JsonKey(name: 'OrgPrice')
  final String? orgPrice;
  @JsonKey(name: 'ComboClass')
  final String? comboClass;


  @override
  List<Object> get props => [
        itemCode,
        itemType ?? ' ',
        recptDesc,
        unitSellPrice ?? '0',
        comboPack ?? '',
        weightItem,
        onPromotion ?? '',
        promoPrice,
        discountable,
        modifierInt ?? '0',
        masterCode ?? ' ',
        hidden ?? ' ',
        promoCode ?? '',
        promoClass ?? '',
        pkgPrice ?? '',
        pkgQty ?? '',
        pkgItems ?? '',
        blanket ?? '',
        tax ?? '0',
        printStatus ?? '',
        qty ?? '0',
        splited ?? '0',
        seqNo ?? '0',
        orgPrice ?? '0',
        comboClass ?? ''
      ];

  static const empty = Item(
      itemCode: '',
      itemType: ' ',
      recptDesc: '',
      unitSellPrice: '0',
      comboPack: ' ',
      weightItem: '',
      onPromotion: '',
      promoPrice: '0',
      discountable: '',
      modifierInt: '0',
      masterCode: ' ',
      hidden: ' ',
      promoCode: '',
      promoClass: '',
      pkgPrice: '',
      pkgQty: '',
      pkgItems: '',
      blanket: '',
      tax: '0',
      printStatus: '',
      qty: '0',
      splited: '0',
      seqNo: '0',
      orgPrice: '0',
      comboClass: ''
  );

  const Item(
      {required this.itemCode,
      required this.itemType,
      required this.recptDesc,
      this.unitSellPrice,
      this.comboPack,
      required this.weightItem,
      this.onPromotion,
      required this.promoPrice,
      required this.discountable,
      required this.modifierInt,
      required this.masterCode,
      required this.hidden,
      required this.promoCode,
      required this.promoClass,
      required this.pkgPrice,
      required this.pkgQty,
      required this.pkgItems,
      required this.blanket,
      required this.tax,
      this.printStatus = '',
      this.qty = '0',
      this.splited = '0',
      this.seqNo = '0',
      this.orgPrice = '0',
      this.comboClass = ''
      }
    );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  String getOrgPrice() {
    if (orgPrice != '0') {
      return orgPrice ?? '0';
    }

    if (unitSellPrice != '0') {
      return unitSellPrice ?? '0';
    }
    return '0';
  }

  String getComboPack() {
    if (comboClass! != '') {
      return comboClass ?? '';
    }

    if (comboPack! != '') {
      return comboPack ?? '';
    }
    return '';
  }

  String getPrintStatusStr() {
    if (printStatus!.isEmpty) {
      return printStatus ?? '';
    } else if (printStatus == '9') {
      return Item.STATUS_CANCEL;
    }
    return Item.STATUS_OLD;
  }
}
