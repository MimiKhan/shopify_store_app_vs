import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/enums/src/delivery_methods_type.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_delivery_groups/cart_delivery_options/cart_delivery_option.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/mailing_address/mailing_address.dart';

part 'cart_delivery_groups.freezed.dart';
part 'cart_delivery_groups.g.dart';

@freezed
class CartDeliveryGroup with _$CartDeliveryGroup {
  const CartDeliveryGroup._();

  factory CartDeliveryGroup({
    required String id,
    CartDeliveryOption? deliveryOptions,
    MailingAddress? deliveryAddress,
    required DeliveryMethodType selectedDeliveryOption,
  }) = _CartDeliveryGroup;

  factory CartDeliveryGroup.fromJson(Map<String, dynamic> json) => _$CartDeliveryGroupFromJson(json);
}
