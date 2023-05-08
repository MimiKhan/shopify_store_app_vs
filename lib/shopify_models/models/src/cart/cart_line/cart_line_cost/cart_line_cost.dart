

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';

part 'cart_line_cost.freezed.dart';
part 'cart_line_cost.g.dart';

@freezed
class CartLineCost with _$CartLineCost {
  const CartLineCost._();

  factory CartLineCost({
    required PriceV2 originalUnitPrice,
    PriceV2? compareAtAmountPerQuantity,
    required PriceV2 subTotalAmount,
    required PriceV2 totalAmount,
  }) = _CartLineCost;

  factory CartLineCost.fromJson(Map<String, dynamic> json) => _$CartLineCostFromJson(json);
}