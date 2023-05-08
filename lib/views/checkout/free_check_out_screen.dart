import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/checkout.dart';
import 'package:shopify_store_app/theme/app_style.dart';

class FreeCheckoutScreen extends StatefulWidget {
  FreeCheckoutScreen({Key? key, required this.checkout}) : super(key: key);
  Checkout checkout;

  @override
  State<FreeCheckoutScreen> createState() => _FreeCheckoutScreenState();
}

class _FreeCheckoutScreenState extends State<FreeCheckoutScreen> {
  final checkoutController = Get.find<CheckoutController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: TextButton(
            onPressed: () async {
              await checkoutController
                  .completeCheckoutFreeFromCart(checkoutId: widget.checkout.id)
                  .onError((error, stackTrace) {
                debugPrint("--FreeCheckoutScreen--> $error");
                debugPrintStack(stackTrace: stackTrace);
              });
            },
            child: Text(
              'Complete Checkout',
              style: AppStyle.gfPoppinsMediumBlack(fontSize: 18),
            )),
      ),
    );
  }
}
