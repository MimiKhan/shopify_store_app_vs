// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Cart _$$_CartFromJson(Map<String, dynamic> json) => _$_Cart(
      checkoutUrl: json['checkoutUrl'] as String,
      id: json['id'] as String,
      currencyCode: json['currencyCode'] as String,
      cost: CartCost.fromJson(json['cost'] as Map<String, dynamic>),
      requiresShipping: json['requiresShipping'] as bool,
      buyerIdentity: json['buyerIdentity'] == null
          ? null
          : CartBuyerIdentity.fromJson(
              json['buyerIdentity'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      discountAllocations: json['discountAllocations'] == null
          ? null
          : CartDiscountAllocations.fromJson(
              json['discountAllocations'] as Map<String, dynamic>),
      discountCodes: json['discountCodes'] == null
          ? null
          : CartDiscountCode.fromJson(
              json['discountCodes'] as Map<String, dynamic>),
      note: json['note'] as String?,
      totalQuantity: json['totalQuantity'] as int,
      updatedAt: json['updatedAt'] as String?,
      deliveryGroups: json['deliveryGroups'] == null
          ? null
          : CartDeliveryGroup.fromJson(
              json['deliveryGroups'] as Map<String, dynamic>),
      lines: (json['lines'] as List<dynamic>)
          .map((e) => CartLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CartToJson(_$_Cart instance) => <String, dynamic>{
      'checkoutUrl': instance.checkoutUrl,
      'id': instance.id,
      'currencyCode': instance.currencyCode,
      'cost': instance.cost,
      'requiresShipping': instance.requiresShipping,
      'buyerIdentity': instance.buyerIdentity,
      'createdAt': instance.createdAt,
      'discountAllocations': instance.discountAllocations,
      'discountCodes': instance.discountCodes,
      'note': instance.note,
      'totalQuantity': instance.totalQuantity,
      'updatedAt': instance.updatedAt,
      'deliveryGroups': instance.deliveryGroups,
      'lines': instance.lines,
    };
