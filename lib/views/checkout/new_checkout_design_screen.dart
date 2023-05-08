import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/checkout/checkout_screen2.dart';
import 'package:shopify_store_app/views/checkout/pre_checkout_screen.dart';
import 'package:shopify_store_app/views/checkout/shipping_select_screen.dart';

class NewCheckoutDesignScreen extends StatefulWidget {
  const NewCheckoutDesignScreen({Key? key}) : super(key: key);

  @override
  State<NewCheckoutDesignScreen> createState() =>
      _NewCheckoutDesignScreenState();
}

class _NewCheckoutDesignScreenState extends State<NewCheckoutDesignScreen> {
  final checkoutController = Get.find<CheckoutController>();
  final cartController = Get.find<CartController>();
  bool isCheckoutHaveData = false;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              20.ph,
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      _getSelectedWidget(0);
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: Text(
                      'Information',
                      style: _selectedIndex == 0
                          ? AppStyle.gfPoppinsMediumBlack(fontSize: 16)
                          : AppStyle.gfPoppinsMediumGrey(fontSize: 16),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                  TextButton(
                    onPressed: () {
                      _getSelectedWidget(1);
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Text(
                      'Shipping',
                      style: _selectedIndex == 1
                          ? AppStyle.gfPoppinsMediumBlack(fontSize: 16)
                          : AppStyle.gfPoppinsMediumGrey(fontSize: 16),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                  TextButton(
                    onPressed: () {
                      _getSelectedWidget(2);
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: Text(
                      'Payment',
                      style: AppStyle.gfPoppinsMediumBlack(fontSize: 16),
                    ),
                  ),
                ],
              ),
              25.ph,
              Container(
                child: _getSelectedWidget(_selectedIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSelectedWidget(int selectedIndex) {
    switch (_selectedIndex) {
      case 0:
        return PreCheckoutScreen(cartModelItems: cartController.cartModelItems);
      case 1:
        return const ShippingSelectScreen();
      case 2:
        return const CheckoutScreen2();
      default:
        return PreCheckoutScreen(cartModelItems: cartController.cartModelItems);
    }
  }
}

// creating extension for Size box on number to return double value
extension PaddingHeight on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );

  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}
