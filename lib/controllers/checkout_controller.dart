import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/shopify_models/enums/src/payment_token_type.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart.dart';
import 'package:shopify_store_app/shopify_models/models/src/cart/cart_line/cart_line.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/checkout.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/line_item/line_item.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/mailing_address/mailing_address.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/shipping_rates/shipping_rates.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/price_v_2/price_v_2.dart';
import 'package:shopify_store_app/shopify_models/models/src/shopify_user/address/address.dart';
import 'package:shopify_store_app/shopify_models/shopify/src/shopify_cart.dart';
import 'package:shopify_store_app/shopify_models/shopify/src/shopify_checkout.dart';

class CheckoutController extends GetxController {
  late Checkout checkout;
  late Checkout checkout1;
  late Cart cart;
  late ShippingRates rateSelected;

  // var rateSelected = Rx<ShippingRates?>(null);

  var paymentDataCreditCard = ''.obs;
  var paymentDataGooglePay = ''.obs;
  var paymentDataApplePay = ''.obs;
  var paymentDataPayPal = ''.obs;

  Future<void> createCartFromUI(
      {required MailingAddress address,
      required List<CartLine> lines,
      required String userAccessToken,
      required String email}) async {
    try {
      final shopifyCart = ShopifyCart.instance;
      await shopifyCart
          .createCart(
              lines: lines,
              userAccessToken: userAccessToken,
              userEmail: email,
              address: address)
          .then((value) {
        cart = value;
        update();
      });
    } catch (e) {
      debugPrint("--**-->Checkout Controller(CreateCart)<--**-- : $e");
    }
  }

  Future<void> createCheckoutFromCartWithAddress(List<LineItem> lineItems,
      Address mailingAddress, String customerAccess) async {
    try {
      final shopifyCheckout = ShopifyCheckout.instance;

      await shopifyCheckout
          .createCheckout(lineItems: lineItems, mailingAddress: mailingAddress)
          .then((value) async {
        await shopifyCheckout
            .checkoutCustomerAssociate(value.id, customerAccess)
            .whenComplete(() async {
          await shopifyCheckout
              .getCheckoutInfoQuery(value.id, getShippingInfo: true)
              .then((value1) {
            checkout = value1;
          });
        });
        update();
      });
    } catch (e) {
      debugPrint(
          "--**-->Checkout Controller(CreateCheckout/WithAddress)<--**-- : $e");
    }
  }

  Future<void> createCheckoutFromCartWithUser(
      List<LineItem> lineItems, String customerAccess) async {
    try {
      final shopifyCheckout = ShopifyCheckout.instance;

      await shopifyCheckout
          .createCheckout(lineItems: lineItems)
          .then((value) async {
        await shopifyCheckout
            .checkoutCustomerAssociate(value.id, customerAccess)
            .whenComplete(() async {
          await shopifyCheckout
              .getCheckoutInfoQuery(value.id, getShippingInfo: true)
              .then((value1) {
            checkout = value1;
          });
        });
        update();
      });
    } catch (e) {
      debugPrint(
          "--**-->Checkout Controller(CreateCheckout/WithUser)<--**-- : $e");
    }
  }

  Future<void> createCheckoutFromCartWithoutAddress(
      List<LineItem> lineItems) async {
    try {
      final shopifyCheckout = ShopifyCheckout.instance;

      await shopifyCheckout
          .createCheckout(lineItems: lineItems)
          .then((value) async {
        // await shopifyCheckout
        //     .getCheckoutInfoQuery(value.id, getShippingInfo: true)
        //     .then((value1) {
        //   checkout1 = value1;
        // });
        checkout = value;
        update();
      });
    } catch (e) {
      debugPrint(
          "--**-->Checkout Controller(CreateCheckout/NoAddress)<--**-- : $e");
    }
  }

  // Future<void> updateData(Checkout checkoutData)async{
  //   try{
  //
  //     final shopifyCheckout = ShopifyCheckout.instance;
  //     // var data = await shopifyCheckout.getCheckoutInfoQuery(checkout.id,getShippingInfo: true);
  //     await shopifyCheckout.updateAttributes(checkoutData.id,customAttributes: {"availableShippingRates.ready":"true"});
  //     // Address address = Address(
  //     //   firstName: checkout.shippingAddress!.firstName,
  //     // );
  //     // var shippingData = shopifyCheckout.checkoutShippingLineUpdate(checkout.id,checkout.s);
  //     // checkout1 = data;
  //     // debugPrint(data.toString());
  //     update();
  //   }on Exception catch(e){
  //     debugPrint(e.toString());
  //   }
  // }

  Future<void> completeCheckoutFreeFromCart(
      {required String checkoutId}) async {
    try {
      var shopifyCheckout = ShopifyCheckout.instance;
      await shopifyCheckout.checkoutCompleteFree(checkoutId).whenComplete(() {
        Fluttertoast.showToast(msg: "Free Checkout Successful.");
        Get.offNamed('/mainScreen');
      });
    } catch (e) {
      debugPrint(
          "--**-->Checkout Controller(completeCheckoutFreeFromCart)<--**-- : $e");
    }
  }

  Future<void> payWithCreditCard({
    required String checkoutId,
    required PriceV2 price,
    required Address billingAddress,
    required String paymentToken,
    required String paymentType,
    required String idempotencyKey,
  }) async {
    try {
      var shopifyCheckout = ShopifyCheckout.instance;
      var data = await shopifyCheckout.completeCheckoutWithTokenizedPaymentV2(
          checkoutId: checkoutId,
          price: price,
          billingAddress: billingAddress,
          impotencyKey: idempotencyKey,
          tokenizedPayment: paymentToken,
          type: paymentType);
      paymentDataCreditCard.value = data.toString();
      update();
    } catch (e) {
      debugPrint("--**-->Checkout Controller(PayWithCreditCard)<--**-- : $e");
    }
  }

  Future<void> payWithGooglePay({
    required String checkoutId,
    required String idempotencyKey,
    required String token,
    required String amount,
    required String currencyCode,
  }) async {
    try {
      var shopifyCheckout = ShopifyCheckout.instance;
      var data = await shopifyCheckout.checkoutCompleteWithTokenizedPaymentV3(
          checkoutId,
          checkout: checkout,
          token: token,
          paymentTokenType: PaymentTokenType.GOOGLE_PAY,
          idempotencyKey: idempotencyKey,
          amount: amount,
          currencyCode: currencyCode);
      paymentDataGooglePay.value = data.toString();
      update();
    } catch (e) {
      debugPrint("--**-->Checkout Controller(PayWithGooglePay)<--**-- : $e");
    }
  }

  Future<void> payWithApplePay({
    required String checkoutId,
    required String idempotencyKey,
    required String token,
    required String amount,
    required String currencyCode,
  }) async {
    try {
      var shopifyCheckout = ShopifyCheckout.instance;
      var data = await shopifyCheckout.checkoutCompleteWithTokenizedPaymentV3(
          checkoutId,
          checkout: checkout,
          token: token,
          paymentTokenType: PaymentTokenType.APPLE_PAY,
          idempotencyKey: idempotencyKey,
          amount: amount,
          currencyCode: currencyCode);
      paymentDataGooglePay.value = data.toString();
      update();
    } catch (e) {
      debugPrint("--**-->Checkout Controller(PayWithApplePay)<--**-- : $e");
    }
  }

  Future<void> setShippingLineUpdate(
      {required String checkoutId, required String shippingRateHandle}) async {
    try {
      var shopifyCheckout = ShopifyCheckout.instance;
      await shopifyCheckout
          .checkoutShippingLineUpdate(checkoutId, shippingRateHandle)
          .then((value) {
        checkout = value;
      });
      update();
    } catch (e) {
      debugPrint(
          "--**-->Checkout Controller(SetShippingLineUpdate)<--**-- : $e");
    }
  }
}
