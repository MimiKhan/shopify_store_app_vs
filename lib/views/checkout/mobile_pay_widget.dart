import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'dart:io' show Platform;

import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/services/braintree_service.dart';
import 'package:shopify_store_app/services/configs.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/checkout.dart';
import 'package:shopify_store_app/views/checkout/checkout_confirmation.dart';

class MobilePayWidget extends StatefulWidget {
  Checkout checkout;

  MobilePayWidget(this.checkout, {Key? key}) : super(key: key);

  @override
  State<MobilePayWidget> createState() => _MobilePayWidgetState();
}

class _MobilePayWidgetState extends State<MobilePayWidget> {
  final checkoutController = Get.find<CheckoutController>();
  final cartController = Get.find<CartController>();

  bool _isGoogleButtonEnabled = false;
  bool _isAppleButtonEnabled = false;

  late Checkout _checkout;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkout = widget.checkout;
    debugPrint(_checkout.id);
    if (Platform.isAndroid) {
      _isGoogleButtonEnabled = true;
      _isAppleButtonEnabled = false;
    } else if (Platform.isIOS) {
      _isAppleButtonEnabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          IconButton(
            onPressed: _isGoogleButtonEnabled
                ? () async {
                    var result = await BraintreePaymentService()
                        .makeGooglePayRequest(
                            totalAmount:
                                _checkout.totalPriceV2.amount.toString(),
                            currencyCode: _checkout.currencyCode);
                    debugPrint("Result : ${result!.paymentMethodNonce}");
                    String idemPotencyKey =
                        CustomConfig().generateIdempotencyKey();
                    await checkoutController
                        .payWithGooglePay(
                            checkoutId: _checkout.id,
                            idempotencyKey: idemPotencyKey,
                            token: result.paymentMethodNonce.nonce,
                            amount: _checkout.totalPriceV2.amount.toString(),
                            currencyCode: _checkout.currencyCode)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: 'Payment Complete with Google Pay.');
                      return CheckoutConfirmation();
                    });
                  }
                : null,
            icon: const Icon(FontAwesomeIcons.googlePay),
            style: IconButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                iconSize: 50,
                minimumSize: const Size(150, 70)),
          ),
          const Padding(
            padding: EdgeInsets.all(25.0),
            child: Text('OR'),
          ),
          IconButton(
            onPressed: _isAppleButtonEnabled
                ? () async {
                    var countryCode = '';
                    var countryData = cartController.countryData.value;
                    for (var country in countryData) {
                      if (_checkout.shippingAddress!.country == country.name) {
                        countryCode = country.code!;
                        break;
                      }
                    }
                    debugPrint(
                        "Country Selected : ${_checkout.shippingAddress!.country} : Code : $countryCode");

                    var result = await BraintreePaymentService()
                        .makeApplePayRequest(
                            countryCode: countryCode,
                            currencyCode: _checkout.currencyCode);
                    debugPrint("Result : ${result!.paymentMethodNonce}");
                    String idemPotencyKey =
                        CustomConfig().generateIdempotencyKey();
                    await checkoutController
                        .payWithApplePay(
                            checkoutId: _checkout.id,
                            idempotencyKey: idemPotencyKey,
                            token: result.paymentMethodNonce.nonce,
                            amount: _checkout.totalPriceV2.amount.toString(),
                            currencyCode: _checkout.currencyCode)
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: 'Payment Complete with Apple Pay.');
                      return CheckoutConfirmation();
                    });
                  }
                : null,
            icon: const Icon(FontAwesomeIcons.applePay),
            style: IconButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                iconSize: 50,
                minimumSize: const Size(150, 70)),
          ),
        ],
      ))),
    );
  }
}
