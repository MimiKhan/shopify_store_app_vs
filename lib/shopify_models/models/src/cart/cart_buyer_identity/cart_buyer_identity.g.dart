// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_buyer_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartBuyerIdentity _$$_CartBuyerIdentityFromJson(Map<String, dynamic> json) =>
    _$_CartBuyerIdentity(
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      customer: json['customer'] == null
          ? null
          : ShopifyUser.fromJson(json['customer'] as Map<String, dynamic>),
      deliveryAddressPreferences: MailingAddress.fromJson(
          json['deliveryAddressPreferences'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CartBuyerIdentityToJson(
        _$_CartBuyerIdentity instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'customer': instance.customer,
      'deliveryAddressPreferences': instance.deliveryAddressPreferences,
    };
