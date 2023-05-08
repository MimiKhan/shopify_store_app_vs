import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';

part 'cart_cost.freezed.dart';
part 'cart_cost.g.dart';

@freezed
class CartCost with _$CartCost {
  const CartCost._();

  factory CartCost({
    PriceV2? subtotal,
    bool? subTotalAmountEstimated,
    PriceV2? totalTax,
    bool? totalTaxAmountEstimated,
    PriceV2? totalPrice,
    bool? totalAmountEstimated,
    PriceV2? totalDuty,
    bool? totalDutyAmountEstimated,
  }) = _CartCost;

  factory CartCost.fromJson(Map<String, dynamic> json) => _$CartCostFromJson(json);
}