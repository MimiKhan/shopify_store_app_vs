// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartCost _$$_CartCostFromJson(Map<String, dynamic> json) => _$_CartCost(
      subtotal: json['subtotal'] == null
          ? null
          : PriceV2.fromJson(json['subtotal'] as Map<String, dynamic>),
      subTotalAmountEstimated: json['subTotalAmountEstimated'] as bool?,
      totalTax: json['totalTax'] == null
          ? null
          : PriceV2.fromJson(json['totalTax'] as Map<String, dynamic>),
      totalTaxAmountEstimated: json['totalTaxAmountEstimated'] as bool?,
      totalPrice: json['totalPrice'] == null
          ? null
          : PriceV2.fromJson(json['totalPrice'] as Map<String, dynamic>),
      totalAmountEstimated: json['totalAmountEstimated'] as bool?,
      totalDuty: json['totalDuty'] == null
          ? null
          : PriceV2.fromJson(json['totalDuty'] as Map<String, dynamic>),
      totalDutyAmountEstimated: json['totalDutyAmountEstimated'] as bool?,
    );

Map<String, dynamic> _$$_CartCostToJson(_$_CartCost instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'subTotalAmountEstimated': instance.subTotalAmountEstimated,
      'totalTax': instance.totalTax,
      'totalTaxAmountEstimated': instance.totalTaxAmountEstimated,
      'totalPrice': instance.totalPrice,
      'totalAmountEstimated': instance.totalAmountEstimated,
      'totalDuty': instance.totalDuty,
      'totalDutyAmountEstimated': instance.totalDutyAmountEstimated,
    };
