
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_line_cost/cart_line_cost.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_line_discount_allocations/cart_discount_allocations.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product_variant/product_variant.dart';

part 'cart_line.freezed.dart';
part 'cart_line.g.dart';

@freezed
class CartLine with _$CartLine {
  const CartLine._();

  factory CartLine({
    String? id,
    required ProductVariant merchandise,
    required int quantity,
    CartDiscountAllocations? cartDiscountAllocations,
    CartLineCost? cost
  }) = _CartLine;

  factory CartLine.fromJson(Map<String, dynamic> json) => _$CartLineFromJson(json);
}