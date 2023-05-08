import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/mailing_address/mailing_address.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/shopify_user.dart';

part 'cart_buyer_identity.freezed.dart';
part 'cart_buyer_identity.g.dart';

@freezed
class CartBuyerIdentity with _$CartBuyerIdentity {
  const CartBuyerIdentity._();

  factory CartBuyerIdentity({
    String? email,
    String? phone,
    ShopifyUser? customer,
    required MailingAddress deliveryAddressPreferences,
  }) = _CartBuyerIdentity;

  factory CartBuyerIdentity.fromJson(Map<String, dynamic> json) => _$CartBuyerIdentityFromJson(json);
}