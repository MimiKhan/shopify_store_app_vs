import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/checkout_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/services/hex_color.dart';
import 'package:shopify_store_app/views/checkout/my_web_view_checkout.dart';
import 'package:shopify_store_app/views/login/pages/login_page.dart';

class CartScreen2 extends StatefulWidget {
  const CartScreen2({Key? key}) : super(key: key);

  @override
  State<CartScreen2> createState() => _CartScreen2State();
}

class _CartScreen2State extends State<CartScreen2> {
  final cartController = Get.find<CartController>();
  final checkoutController = Get.find<CheckoutController>();

  final loginController = Get.find<LoginController>();

  bool userLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(width: 0.0),
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.white, fontSize: 21),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        // leading: Icon(CupertinoIcons.hom),
      ),
      backgroundColor: HexColor("#F8F8F8"),
      body: SafeArea(
        child: cartController.cartModelItems.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 35.0),
                      child: Text('Your Cart is Empty',
                          style: TextStyle(fontSize: 20)),
                    ),
                    Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offNamed('/mainScreen');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'Start Shopping',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  GetX<CartController>(builder: (controller) {
                    return SizedBox(
                      width: size.width,
                      height: size.height * 0.62,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          if (controller.cartModelItems.isNotEmpty)
                            GetX<CartController>(
                              builder: (controller) => ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(5),
                                children: controller.cartModelItems
                                    .map((cartModelElement) {
                                  return Dismissible(
                                      background: Container(
                                        color: Colors.red,
                                        child:
                                            const Icon(CupertinoIcons.delete),
                                      ),
                                      key: ValueKey(cartModelElement),
                                      onDismissed:
                                          (DismissDirection direction) {
                                        controller.removeItem(cartModelElement);
                                      },
                                      confirmDismiss:
                                          (DismissDirection direction) async {
                                        return await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              icon: const Icon(
                                                  Icons.warning_amber_outlined),
                                              iconColor: Colors.red,
                                              title: const Text('Are you Sure'),
                                              content: Text(
                                                  'Do you really want to remove '
                                                  '${cartModelElement.product.title} from the cart?'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child:
                                                        const Text("Confirm")),
                                                OutlinedButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: const Text("Cancel"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 15),
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: 200,
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            cartModelElement
                                                                .product
                                                                .images
                                                                .first
                                                                .originalSrc,
                                                        placeholder: (context,
                                                                url) =>
                                                            Image.asset(
                                                                'assets/images/lime-light-logo.png',
                                                                fit: BoxFit
                                                                    .cover),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        fit: BoxFit.fill,
                                                        width: 160,
                                                        height: 180,
                                                      ),
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Text(
                                                          //   cartModelElement
                                                          //           .product
                                                          //           .collectionList
                                                          //           ?.first
                                                          //           .title ??
                                                          //       '',
                                                          //   style: const TextStyle(
                                                          //       color: Colors
                                                          //           .black,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .bold,
                                                          //       fontSize: 21),
                                                          // ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            width: 200,
                                                            height: 50,
                                                            child: Text(
                                                              cartModelElement
                                                                  .product
                                                                  .title,
                                                              softWrap: true,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          cartModelElement
                                                                      .product
                                                                      .option
                                                                      .length >
                                                                  1
                                                              ? Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${cartModelElement.product.option.first.name}${cartModelElement.product.option.length > 2 ? ' / ${cartModelElement.product.option[1].name} / ${cartModelElement.product.option[2].name}' : ' / ${cartModelElement.product.option[1].name}'} :',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black45,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${cartModelElement.productVariant.title}',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black45,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Text(
                                                                  '${cartModelElement.product.option.first.name} : ${cartModelElement.productVariant.title}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black45,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Icon(
                                                                CupertinoIcons
                                                                    .money_dollar,
                                                                color: Colors
                                                                    .orange,
                                                                size: 28,
                                                              ),
                                                              Text(
                                                                cartModelElement
                                                                    .productVariant
                                                                    .price
                                                                    .amount
                                                                    .toStringAsFixed(
                                                                        2),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                  height: 28,
                                                                  width: 83,
                                                                  child: Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              17,
                                                                          width:
                                                                              51,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey.shade100,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cartController
                                                                              .increaseQuantity(cartModelElement);
                                                                        },
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerRight,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                ShapeDecoration(
                                                                              color: Colors.grey.shade100,
                                                                              shape: const CircleBorder(
                                                                                side: BorderSide(color: Colors.white, width: 3, style: BorderStyle.solid),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                const Icon(
                                                                              CupertinoIcons.plus,
                                                                              size: 20,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          cartController
                                                                              .decreaseQuantity(cartModelElement);
                                                                        },
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                ShapeDecoration(
                                                                              color: Colors.grey.shade100,
                                                                              shape: const CircleBorder(
                                                                                side: BorderSide(color: Colors.white, width: 3, style: BorderStyle.solid),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                const Icon(
                                                                              CupertinoIcons.minus,
                                                                              size: 20,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          cartModelElement
                                                                              .quantity
                                                                              .toString(),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: const TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )));
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                  if (cartController.cartModelItems.isNotEmpty)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: size.width,
                        height: 140,
                        // color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 24),
                                  ),
                                  GetX<CartController>(builder: (controller) {
                                    return Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.money_dollar,
                                          size: 28,
                                          color: Colors.orange,
                                        ),
                                        Text(
                                          controller.totalCost
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (cartController.cartModelItems.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Cart Empty'),
                                            content: const Text(
                                                'You must add products to cart for checkout.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        });
                                  }

                                  userLoggedIn = await checkUserFromShopify();
                                  debugPrint("User : $userLoggedIn :");

                                  if (userLoggedIn) {
                                    var lineItems = await cartController
                                        .getLineItems(cartController
                                            .cartModelItems.value);
                                    await checkoutController
                                        .createCheckoutFromCartWithUser(
                                            lineItems,
                                            loginController
                                                .userAccessToken.value)
                                        .whenComplete(() {
                                      debugPrint(
                                          "Checkout URL :: ${checkoutController.checkout.webUrl ?? ''}::");
                                      Get.to(() => WebViewScreen(
                                          checkoutUrl: checkoutController
                                                  .checkout.webUrl ??
                                              ''));
                                    });
                                  } else {
                                    Get.to(() => LoginPage(
                                        loginRoute: LoginRoute.cartScreen));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 10,
                                    minimumSize: Size(size.width - 21, 50)),
                                child: const Text(
                                  'Checkout',
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }

  Future<bool> checkUserFromShopify() async {
    await loginController.checkUser();
    if (loginController.currentUser.value?.id == null) {
      return false;
    } else {
      return true;
    }
  }
}
