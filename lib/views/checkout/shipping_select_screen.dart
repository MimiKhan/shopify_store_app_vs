import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/shopify_models/models/src/checkout/shipping_rates/shipping_rates.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/widgets/exit_popup.dart';

class ShippingSelectScreen extends StatefulWidget {
  const ShippingSelectScreen({Key? key}) : super(key: key);

  @override
  State<ShippingSelectScreen> createState() => _ShippingSelectScreenState();
}

class _ShippingSelectScreenState extends State<ShippingSelectScreen> {
  final checkoutController = Get.find<CheckoutController>();
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showBackPopuponCheckout(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // leading: GestureDetector(
          //   onTap: () => Get.back(),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: const [
          //       Icon(
          //         CupertinoIcons.arrowtriangle_left_fill,
          //         color: Colors.black,
          //       ),
          //       Text('Back'),
          //     ],
          //   ),
          // ),
          actions: [
            GestureDetector(
              onTap: () async {
                var rate = checkoutController.checkout.availableShippingRates
                    ?.shippingRates?[_selectedIndex];
                checkoutController.rateSelected = (checkoutController.checkout
                    .availableShippingRates?.shippingRates?[_selectedIndex])!;
                checkoutController.setShippingLineUpdate(
                    checkoutId: checkoutController.checkout.id,
                    shippingRateHandle: rate!.handle!);
                Get.offNamed('/checkoutScreen2');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Proceed'),
                  Icon(
                    CupertinoIcons.arrowtriangle_right_fill,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  'Shipping Information',
                  style: AppStyle.gfPoppinsBoldBlack(fontSize: 24),
                )),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  // height: 350,
                  child: ListView.builder(
                    itemCount: checkoutController.checkout
                            .availableShippingRates?.shippingRates?.length ??
                        0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      ShippingRates? rate = checkoutController.checkout
                          .availableShippingRates?.shippingRates![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Container(
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            // color: Colors.grey.shade200,
                          ),
                          child: RadioListTile(
                            tileColor: Colors.grey.shade200,
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rate!.title == 'Worldwide'
                                      ? 'DHL Express'
                                      : '${rate.title} - ${rate.handle!.split('-').first.toUpperCase()}',
                                  style: AppStyle.gfPoppinsMediumBlack(
                                      fontSize: 15),
                                ),
                                Text(
                                  rate.priceV2!.formattedPrice,
                                  style: AppStyle.gfPoppinsMediumBlack(
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            selectedTileColor: Colors.blueGrey.shade600,
                            value: index,
                            groupValue: _selectedIndex,
                            onChanged: (int? value) {
                              setState(() {
                                _selectedIndex = value!;
                                debugPrint("Selected Address : ${rate.title}");
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
