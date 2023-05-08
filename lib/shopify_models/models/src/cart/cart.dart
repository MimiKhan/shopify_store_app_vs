

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_buyer_identity/cart_buyer_identity.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_cost/cart_cost.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_delivery_groups/cart_delivery_groups.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_discount_code/cart_discount_code.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_line.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_line_discount_allocations/cart_discount_allocations.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class Cart with _$Cart{
  const Cart._();

  factory Cart({
    required String checkoutUrl,
    required String id,
    required String currencyCode,
    required CartCost cost,
    required bool requiresShipping,
    CartBuyerIdentity? buyerIdentity,
    String? createdAt,
    CartDiscountAllocations? discountAllocations,
    CartDiscountCode? discountCodes,
    String? note,
    required int totalQuantity,
    String? updatedAt,
    CartDeliveryGroup? deliveryGroups,
    required List<CartLine> lines,

}) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

}