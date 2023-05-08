// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_discount_allocations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CartDiscountAllocations _$$_CartDiscountAllocationsFromJson(
        Map<String, dynamic> json) =>
    _$_CartDiscountAllocations(
      discountedAmount:
          PriceV2.fromJson(json['discountedAmount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CartDiscountAllocationsToJson(
        _$_CartDiscountAllocations instance) =>
    <String, dynamic>{
      'discountedAmount': instance.discountedAmount,
    };
