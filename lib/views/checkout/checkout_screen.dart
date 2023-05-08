import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:badges/badges.dart' as badges;
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/checkout/credit_card_widget.dart';
import 'package:shopify_store_app/views/checkout/mobile_pay_widget.dart';
import 'package:shopify_store_app/views/checkout/paypal_widget.dart';
import 'package:shopify_store_app/widgets/exit_popup.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final checkoutController = Get.find<CheckoutController>();

  final cartController = Get.find<CartController>();

  bool _isExpanded = false;

  int _toggleButtonIndex = 0;
  bool isCheckoutHaveData = false;
  double sum = 0;
  String carrierName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(Platform.operatingSystem);
    checkoutData();
    carrierName = getCourierName(
        name: checkoutController
            .checkout.availableShippingRates?.shippingRates?.first.handle);
  }

  Future<void> checkoutData() async {
    if (checkoutController.checkout.id.isEmpty &&
        checkoutController.rateSelected.title!.isEmpty) {
      debugPrint("Checkout Screen : No Data :*");
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
    var shippingAmount = checkoutController.rateSelected.priceV2?.amount ??
        0.0;

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
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showBackPopuponCheckout(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
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
                                      fit: BoxFit.fill,
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
                                                badgeColor: Colors.blue,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 2),
                                                badgeGradient: const badges
                                                    .BadgeGradient.linear(
                                                  colors: [
                                                    Colors.blue,
                                                    Colors.yellow
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                                elevation: 0,
                                              ),
                                              // badgeAnimation: const badges.BadgeAnimation.fade(
                                              //   animationDuration: Duration(seconds: 3),
                                              //   toAnimate: true,
                                              //   // colorChangeAnimationDuration: Duration(seconds: 2),
                                              //   disappearanceFadeAnimationDuration:
                                              //   Duration(seconds: 1),
                                              //   loopAnimation: true,
                                              //   curve: Curves.elasticInOut,
                                              //   // colorChangeAnimationCurve: Curves.easeInCubic,
                                              // ),
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
                                            .rateSelected
                                            .handle),
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Payment',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'All Payments are secure and encrypted.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                ToggleSwitch(
                  minWidth: 110.0,
                  animationDuration: 100,
                  initialLabelIndex: 0,
                  cornerRadius: 15.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 3,
                  // labels: const ['Credit Card', 'Google Pay'],
                  icons: [
                    CupertinoIcons.creditcard,
                    Platform.isAndroid
                        ? FontAwesomeIcons.googlePay
                        : FontAwesomeIcons.applePay,
                    Icons.paypal_outlined
                  ],
                  changeOnTap: true,
                  activeBgColors: const [
                    [Colors.blue],
                    [Colors.green],
                    [Colors.lime],
                  ],

                  iconSize: 50,
                  animate: true,
                  curve: Curves.easeInOutBack,
                  onToggle: (index) {
                    debugPrint('switched to: $index');
                    // _toggleButtonIndex = index!;
                    if (mounted) {
                      setState(() {
                        _toggleButtonIndex = index!;
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
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
    switch (_toggleButtonIndex) {
      case 0:
        return CreditCardWidget(checkoutController.checkout);
      case 1:
        return MobilePayWidget(checkoutController.checkout);
      case 2:
        return PaypalWidget(checkout: checkoutController.checkout);
      default:
        return CreditCardWidget(checkoutController.checkout);
    }
    // if(_toggleButtonIndex == 0){
    //   return CreditCardWidget(checkoutController.checkout);
    // }else if(_toggleButtonIndex == 1){
    //   MobilePayWidget(checkoutController.checkout);
    // }
    // return CreditCardWidget(checkoutController.checkout);
  }
}
