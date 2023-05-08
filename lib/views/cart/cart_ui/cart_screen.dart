import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/views/checkout/pre_checkout_screen.dart';
import 'package:shopify_store_app/views/main_ui/main_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;

  var subtotal = 0.0;

  var _isChecked = false;

  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              if (cartController.cartModelItems.isNotEmpty)
                GetX<CartController>(builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Bag Total : ${controller.totalCost}",
                      style: const TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  );
                })
              else
                const Text(''),
              // if (cartController.cartModelItems.isNotEmpty)
              //   Align(
              //     alignment: Alignment.centerLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: TextButton(
              //         onPressed: (){
              //           setState(() {
              //             cartController.cartModelItems.map((element) => {
              //               cartController.cartModelItemsSelected.add(element)
              //             });
              //           });
              //         },
              //         child: Text('Select All',style: TextStyle(fontSize: 18),),
              //       ),
              //     ),
              //   )
              // else
              //   const Text(''),
              if (cartController.cartModelItems.isNotEmpty)
                GetX<CartController>(
                    builder: (controller) => ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          children:
                              controller.cartModelItems.map((cartModelElement) {
                            return Dismissible(
                              background: Container(
                                color: Colors.red,
                                child: const Icon(CupertinoIcons.delete),
                              ),
                              key: ValueKey(cartModelElement),
                              onDismissed: (DismissDirection direction) {
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
                                                Navigator.of(context).pop(true),
                                            child: const Text("Confirm")),
                                        OutlinedButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              activeColor: Colors.deepPurple,
                                              value: controller
                                                      .cartModelItemsSelected
                                                      .contains(
                                                          cartModelElement)
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                if (controller
                                                    .cartModelItemsSelected
                                                    .contains(
                                                        cartModelElement)) {
                                                  controller
                                                      .cartModelItemsSelected
                                                      .remove(cartModelElement);
                                                  debugPrint(
                                                      "Added to Selected List : ${cartModelElement.product.title}");
                                                } else {
                                                  controller
                                                      .cartModelItemsSelected
                                                      .add(cartModelElement);

                                                  debugPrint(
                                                      "removed from Selected List : ${cartModelElement.product.title}");
                                                }
                                                debugPrint(
                                                    'Selected List Length : ${controller.cartModelItemsSelected.length}');
                                                setState(() {
                                                  _isChecked = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        )),
                                    Card(
                                      child: ListTile(
                                        leading:
                                        CachedNetworkImage(
                                          imageUrl: cartModelElement.product.images.first.originalSrc,
                                          placeholder: (context, url) => Image.asset(
                                              'assets/images/lime-light-logo.png',
                                              fit: BoxFit.cover),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 100,
                                        ),
                                        // Image.network(
                                        //   cartModelElement
                                        //       .product.images.first.originalSrc,
                                        //   width: 70,
                                        //   height: 100,
                                        //   fit: BoxFit.cover,
                                        // ),
                                        title: Text(
                                          cartModelElement.product.title,
                                          softWrap: true,
                                        ),
                                        subtitle: Text(
                                          '\$${cartModelElement.productVariant.price.amount}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100,
                                          height: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      // controller.decrementQuantity(cartModelElement);
                                                    },
                                                    child: const Icon(
                                                        CupertinoIcons
                                                            .minus_circle),
                                                  ),
                                                  Text(
                                                    cartModelElement.quantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // controller.incrementQuantity(cartModelElement);
                                                    },
                                                    child: const Icon(
                                                        CupertinoIcons
                                                            .plus_circle),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '\$${cartModelElement.productVariant.price.amount * cartModelElement.quantity.toDouble()}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ))
              else
                Column(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.0),
                        child: Text('Your Cart is Empty',
                            style: TextStyle(fontSize: 20)),
                      ),
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
              if (cartController.cartModelItemsSelected.isNotEmpty)
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => PreCheckoutScreen(
                        cartModelItems: cartController.cartModelItemsSelected));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    visualDensity: VisualDensity.standard,
                    fixedSize: const Size(150, 50),
                    alignment: Alignment.center,
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
