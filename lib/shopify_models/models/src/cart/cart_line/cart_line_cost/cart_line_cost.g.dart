// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_line_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartLineCost _$$_CartLineCostFromJson(Map<String, dynamic> json) =>
    _$_CartLineCost(
      originalUnitPrice:
          PriceV2.fromJson(json['originalUnitPrice'] as Map<String, dynamic>),
      compareAtAmountPerQuantity: json['compareAtAmountPerQuantity'] == null
          ? null
          : PriceV2.fromJson(
              json['compareAtAmountPerQuantity'] as Map<String, dynamic>),
      subTotalAmount:
          PriceV2.fromJson(json['subTotalAmount'] as Map<String, dynamic>),
      totalAmount:
          PriceV2.fromJson(json['totalAmount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CartLineCostToJson(_$_CartLineCost instance) =>
    <String, dynamic>{
      'originalUnitPrice': instance.originalUnitPrice,
      'compareAtAmountPerQuantity': instance.compareAtAmountPerQuantity,
      'subTotalAmount': instance.subTotalAmount,
      'totalAmount': instance.totalAmount,
    };
