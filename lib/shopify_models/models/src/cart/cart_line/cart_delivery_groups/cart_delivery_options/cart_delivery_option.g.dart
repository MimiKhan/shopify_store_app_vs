// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_delivery_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartDeliveryOption _$$_CartDeliveryOptionFromJson(
        Map<String, dynamic> json) =>
    _$_CartDeliveryOption(
      code: json['code'] as String?,
      title: json['title'] as String?,
      handle: json['handle'] as String,
      estimatedCost:
          PriceV2.fromJson(json['estimatedCost'] as Map<String, dynamic>),
      description: json['description'] as String?,
      deliveryMethodType: $enumDecodeNullable(
          _$DeliveryMethodTypeEnumMap, json['deliveryMethodType']),
    );

Map<String, dynamic> _$$_CartDeliveryOptionToJson(
        _$_CartDeliveryOption instance) =>
    <String, dynamic>{
      'code': instance.code,
      'title': instance.title,
      'handle': instance.handle,
      'estimatedCost': instance.estimatedCost,
      'description': instance.description,
      'deliveryMethodType':
          _$DeliveryMethodTypeEnumMap[instance.deliveryMethodType],
    };

const _$DeliveryMethodTypeEnumMap = {
  DeliveryMethodType.LOCAL: 'LOCAL',
  DeliveryMethodType.NONE: 'NONE',
  DeliveryMethodType.PICKUP_POINT: 'PICKUP_POINT',
  DeliveryMethodType.PICK_UP: 'PICK_UP',
  DeliveryMethodType.RETAIL: 'RETAIL',
  DeliveryMethodType.SHIPPING: 'SHIPPING',
};
