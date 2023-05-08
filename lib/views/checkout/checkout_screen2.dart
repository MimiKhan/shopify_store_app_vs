import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:badges/badges.dart' as badges;
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/checkout/credit_card_widget.dart';
import 'package:shopify_store_app/views/checkout/free_check_out_screen.dart';
import 'package:shopify_store_app/views/checkout/mobile_pay_widget.dart';
import 'package:shopify_store_app/views/checkout/paypal_widget.dart';
import 'package:shopify_store_app/widgets/exit_popup.dart';

class CheckoutScreen2 extends StatefulWidget {
  const CheckoutScreen2({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen2> createState() => _CheckoutScreen2State();
}

class _CheckoutScreen2State extends State<CheckoutScreen2> {
  final checkoutController = Get.find<CheckoutController>();
  final cartController = Get.find<CartController>();

  bool _isExpanded = false;
  bool isCheckoutHaveData = false;
  double sum = 0;
  String carrierName = '';
  int _selectedIndex = -1;

  List<String> paymentMethodList = [
    "Credit Card",
    "Apple Pay/ Google Pay",
    "Paypal",
    "Free"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(Platform.operatingSystem);
    // if (Platform.isIOS) {
    //   paymentMethodList = ["Credit Card", "Apple Pay", "Paypal"];
    // } else {
    //   paymentMethodList = ["Credit Card", "Google Pay", "Paypal"];
    // }
    checkoutData();
    carrierName = getCourierName(
        name: checkoutController
            .checkout.availableShippingRates?.shippingRates?.first.handle);
  }

  Future<void> checkoutData() async {
    if (checkoutController.checkout.id.isEmpty &&
        checkoutController.rateSelected.title!.isEmpty) {
      debugPrint("--**-->CheckoutScreen(Checkout)<--**-- : No Data :*");
      setState(() {
        isCheckoutHaveData = false;
      });
    } else {
      debugPrint(
          "--**-->CheckoutScreen(Checkout)<--**--\n${checkoutController.checkout.toString()}");
      debugPrint(
          "--**-->CheckoutScreen(Rate Selected)<--**--\n${checkoutController.rateSelected.handle}");
      sumTotalAmount();
      setState(() {
        isCheckoutHaveData = true;
      });
    }
  }

  Future<void> sumTotalAmount() async {
    var subTotalAmount = checkoutController.checkout.subtotalPriceV2.amount;
    var shippingAmount = checkoutController.rateSelected.priceV2?.amount ?? 0.0;

    sum = subTotalAmount + shippingAmount;
  }

  String getCourierName({String? name}) {
    String inputString = name!;
    List<String> parts = inputString.split('-');

    String carrierName = parts[0]
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');

    // carrierName = carrierName.replaceAll('h', 'H'); // "DHL Express"
    // carrierName = carrierName.replaceAll('l', 'L'); // "DHL Express"
    debugPrint("--**--CheckoutScreen> Carrier Name : $carrierName");
    return carrierName;
    // print(carrierName); // "DHL Express"// "P-79.08-1679338799-1679425199"
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showBackPopuponCheckout(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                ExpansionTile(
                  onExpansionChanged: (value) {
                    setState(() {
                      _isExpanded = value;
                    });
                  },
                  textColor: Colors.black,
                  leading: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                  title: Row(
                    children: [
                      Text(
                        _isExpanded
                            ? 'Hide Order Summary'
                            : 'Show Order Summary',
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 14),
                      ),
                      Icon(_isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right),
                    ],
                  ),
                  trailing: isCheckoutHaveData
                      ? Text('\$$sum',
                          style: AppStyle.gfPoppinsBoldBlack(fontSize: 20))
                      : Text(
                          '0',
                          style: AppStyle.gfPoppinsBoldBlack(fontSize: 20),
                        ),
                  children: [
                    Column(
                      children: [
                        GetX<CartController>(builder: (controller) {
                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children:
                                controller.cartModelItems.map((cartModelItem) {
                              return SizedBox(
                                height: 100,
                                child: ListTile(
                                  style: ListTileStyle.list,
                                  title: Text(cartModelItem.product.title,
                                      style: AppStyle.gfPoppinsMediumBlack(
                                          fontSize: 12)),
                                  leading: Stack(children: <Widget>[
                                    CachedNetworkImage(
                                      imageUrl: cartModelItem
                                          .product.images.first.originalSrc,
                                      placeholder: (context, url) => Image.asset(
                                          'assets/images/lime-light-logo.png',
                                          fit: BoxFit.cover),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Positioned(
                                        top: -5.0,
                                        right: 1.0,
                                        child: Stack(
                                          children: <Widget>[
                                            badges.Badge(
                                              badgeContent: Text(cartModelItem
                                                  .quantity
                                                  .toString()),
                                              showBadge: true,
                                              ignorePointer: true,
                                              badgeStyle: badges.BadgeStyle(
                                                shape: badges.BadgeShape.circle,
                                                badgeColor: Colors.grey,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                // borderSide: const BorderSide(
                                                //     color: Colors.white,
                                                //     width: 2),
                                                // badgeGradient: const badges
                                                //     .BadgeGradient.linear(
                                                //   colors: [
                                                //     Colors.blue,
                                                //     Colors.yellow
                                                //   ],
                                                //   begin: Alignment.topCenter,
                                                //   end: Alignment.bottomCenter,
                                                // ),
                                                elevation: 0,
                                              ),
                                            ),
                                          ],
                                        ))
                                  ]),
                                  subtitle: Text(
                                    cartModelItem.productVariant
                                                .selectedOptions!.first.value ==
                                            'Default Title'
                                        ? 'Single Variant'
                                        : cartModelItem.product.title,
                                    style: AppStyle.gfPoppinsRegularBlack(
                                        fontSize: 12),
                                  ),
                                  trailing: Text(
                                      cartModelItem
                                          .productVariant.price.formattedPrice,
                                      style: AppStyle.gfPoppinsMediumBlack(
                                          fontSize: 12)),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          thickness: 1.2,
                          height: 1.1,
                          color: Colors.grey,
                          indent: 40,
                          endIndent: 40,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Subtotal Widget
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Subtotal',
                                style:
                                    AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                              ),
                              isCheckoutHaveData
                                  ? Text(
                                      '\$${checkoutController.checkout.subtotalPriceV2.amount}',
                                      style: AppStyle.gfPoppinsBoldBlack(
                                          fontSize: 22),
                                    )
                                  : Text(
                                      '\$ 0',
                                      style: AppStyle.gfPoppinsBoldBlack(
                                          fontSize: 22),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          thickness: 1.2,
                          height: 1.1,
                          color: Colors.grey,
                          indent: 40,
                          endIndent: 40,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Shipping Info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shipping Information",
                                  style:
                                      AppStyle.gfPoppinsBoldBlack(fontSize: 19),
                                ),
                                ListTile(
                                  title: Text(
                                    getCourierName(
                                        name: checkoutController
                                            .rateSelected.handle),
                                    style: AppStyle.gfPoppinsMediumBlack(
                                        fontSize: 18),
                                  ),
                                  // subtitle: Text(
                                  //   '${checkoutController.checkout.availableShippingRates?.shippingRates?.first.title}',
                                  //   style: AppStyle.gfPoppinsMediumBlack(
                                  //       fontSize: 14),
                                  // ),
                                  trailing: Text(
                                    '${checkoutController.rateSelected.priceV2?.formattedPrice}',
                                    style: AppStyle.gfPoppinsMediumBlack(
                                        fontSize: 22),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          thickness: 1.2,
                          height: 1.1,
                          color: Colors.grey,
                          indent: 40,
                          endIndent: 40,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // total Amount widget
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style:
                                    AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                              ),
                              Row(
                                children: [
                                  isCheckoutHaveData
                                      ? Text(
                                          checkoutController
                                              .checkout.currencyCode,
                                          style: AppStyle.gfPoppinsMediumBlack(
                                              fontSize: 16),
                                        )
                                      : Text(
                                          'USD',
                                          style: AppStyle.gfPoppinsMediumBlack(
                                              fontSize: 16),
                                        ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  isCheckoutHaveData
                                      ? Text(
                                          '\$$sum',
                                          style: AppStyle.gfPoppinsBoldBlack(
                                              fontSize: 22),
                                        )
                                      : Text(
                                          '\$ 0',
                                          style: AppStyle.gfPoppinsBoldBlack(
                                              fontSize: 22),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: paymentMethodList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            // color: Colors.grey.shade200,
                          ),
                          child: RadioListTile(
                            title: Text(paymentMethodList[index]),
                            selectedTileColor: Colors.blueGrey.shade600,
                            value: index,
                            groupValue: _selectedIndex,
                            onChanged: (int? value) {
                              if (mounted) {
                                setState(() {
                                  _selectedIndex = value!;
                                  debugPrint(
                                      "Selected Payment Method : ${paymentMethodList[index]}");
                                });
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: size.width - 20,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade100),
                  child: _getSelectedWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getSelectedWidget() {
    switch (_selectedIndex) {
      case 0:
        return CreditCardWidget(checkoutController.checkout);
      case 1:
        return MobilePayWidget(checkoutController.checkout);
      case 2:
        return PaypalWidget(checkout: checkoutController.checkout);
      case 3:
        return FreeCheckoutScreen(checkout:checkoutController.checkout);
      default:
        return Container(
          color: Colors.white,
        );
    }
  }
}
