// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_delivery_groups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartDeliveryGroup _$$_CartDeliveryGroupFromJson(Map<String, dynamic> json) =>
    _$_CartDeliveryGroup(
      id: json['id'] as String,
      deliveryOptions: json['deliveryOptions'] == null
          ? null
          : CartDeliveryOption.fromJson(
              json['deliveryOptions'] as Map<String, dynamic>),
      deliveryAddress: json['deliveryAddress'] == null
          ? null
          : MailingAddress.fromJson(
              json['deliveryAddress'] as Map<String, dynamic>),
      selectedDeliveryOption: $enumDecode(
          _$DeliveryMethodTypeEnumMap, json['selectedDeliveryOption']),
    );

Map<String, dynamic> _$$_CartDeliveryGroupToJson(
        _$_CartDeliveryGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deliveryOptions': instance.deliveryOptions,
      'deliveryAddress': instance.deliveryAddress,
      'selectedDeliveryOption':
          _$DeliveryMethodTypeEnumMap[instance.selectedDeliveryOption]!,
    };

const _$DeliveryMethodTypeEnumMap = {
  DeliveryMethodType.LOCAL: 'LOCAL',
  DeliveryMethodType.NONE: 'NONE',
  DeliveryMethodType.PICKUP_POINT: 'PICKUP_POINT',
  DeliveryMethodType.PICK_UP: 'PICK_UP',
  DeliveryMethodType.RETAIL: 'RETAIL',
  DeliveryMethodType.SHIPPING: 'SHIPPING',
};
