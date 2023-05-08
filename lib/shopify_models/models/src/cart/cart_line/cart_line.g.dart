// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartLine _$$_CartLineFromJson(Map<String, dynamic> json) => _$_CartLine(
      id: json['id'] as String?,
      merchandise:
          ProductVariant.fromJson(json['merchandise'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      cartDiscountAllocations: json['cartDiscountAllocations'] == null
          ? null
          : CartDiscountAllocations.fromJson(
              json['cartDiscountAllocations'] as Map<String, dynamic>),
      cost: json['cost'] == null
          ? null
          : CartLineCost.fromJson(json['cost'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CartLineToJson(_$_CartLine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchandise': instance.merchandise,
      'quantity': instance.quantity,
      'cartDiscountAllocations': instance.cartDiscountAllocations,
      'cost': instance.cost,
    };
