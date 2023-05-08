import 'package:flutter/material.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/checkout.dart';
import 'package:shopify_store_app/theme/app_style.dart';

class PaypalWidget extends StatefulWidget {
  PaypalWidget({Key? key, required this.checkout}) : super(key: key);

  Checkout checkout;

  @override
  State<PaypalWidget> createState() => _PaypalWidgetState();
}

class _PaypalWidgetState extends State<PaypalWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("Checkout/WebUrl ***CheckoutScreen***: ${widget.checkout.webUrl.toString()}");
    debugPrint("Checkout/ShippingLine ***CheckoutScreen***: ${widget.checkout.shippingLine.toString()}");
    // debugPrint("Checkout/ShippingData ***CheckoutScreen***: ${widget.checkout.availableShippingRates?.shippingRates?.first.handle}");
    debugPrint("Checkout/ShippingRates ***CheckoutScreen***: ${widget.checkout.availableShippingRates?.shippingRates?.toString()}");


  }
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Coming Soon',style: AppStyle.gfPoppinsMediumBlack(fontSize: 18),),);
  }


}
