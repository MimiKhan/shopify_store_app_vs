import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';

part 'applied_gift_cards.freezed.dart';
part 'applied_gift_cards.g.dart';

@freezed
class AppliedGiftCards with _$AppliedGiftCards {
  const AppliedGiftCards._();

  factory AppliedGiftCards(
      {required PriceV2 amountUsedV2,
      required PriceV2 balanceV2,
      String? id}) = _AppliedGiftCards;

  factory AppliedGiftCards.fromJson(Map<String, dynamic> json) => _$AppliedGiftCardsFromJson(json);
}
