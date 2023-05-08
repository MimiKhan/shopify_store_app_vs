import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';

part 'shipping_rates.freezed.dart';

part 'shipping_rates.g.dart';

@freezed
class ShippingRates with _$ShippingRates {
  const ShippingRates._();

  factory ShippingRates(
      {
        String? handle,
      String? title,
      PriceV2? priceV2}) = _ShippingRates;

  factory ShippingRates.fromJson(Map<String, dynamic> json) =>
      _$ShippingRatesFromJson(json);
}
