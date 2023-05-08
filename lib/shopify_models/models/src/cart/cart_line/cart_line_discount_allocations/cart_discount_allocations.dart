import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';

part 'cart_discount_allocations.freezed.dart';
part 'cart_discount_allocations.g.dart';

@freezed
class CartDiscountAllocations with _$CartDiscountAllocations {
  const CartDiscountAllocations._();

  factory CartDiscountAllocations({
    required PriceV2 discountedAmount
  }) = _CartDiscountAllocations;

  factory CartDiscountAllocations.fromJson(Map<String, dynamic> json) => _$CartDiscountAllocationsFromJson(json);
}