import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/enums/src/delivery_methods_type.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';

part 'cart_delivery_option.freezed.dart';
part 'cart_delivery_option.g.dart';

@freezed
class CartDeliveryOption with _$CartDeliveryOption {
  const CartDeliveryOption._();

  factory CartDeliveryOption({
    String? code,
    String? title,
    required String handle,
    required PriceV2 estimatedCost,
    String? description,
    DeliveryMethodType? deliveryMethodType
  }) = _CartDeliveryOption;

  factory CartDeliveryOption.fromJson(Map<String, dynamic> json) => _$CartDeliveryOptionFromJson(json);
}