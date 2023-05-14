import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/new_ui_designs/product_details/ui/product_details_ui_screen.dart';
import 'package:shopify_store_app/services/hex_color.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:get/get.dart';

class NewCartScreen extends StatefulWidget {
  const NewCartScreen({Key? key}) : super(key: key);

  @override
  _NewCartScreenState createState() => _NewCartScreenState();
}

class _NewCartScreenState extends State<NewCartScreen> {
  final cartController = Get.find<CartController>();

  void _navigateToProductDetailScreen(Product product) {
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    Get.to(() => ProductDetailsUI(product: product));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // set the color of the back icon here
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    child: Text(
                      'Shopping Cart',
                      style: AppStyle.gfPoppinsBoldBlack(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GetX<CartController>(builder: (controller) {
                          return Text(
                            cartController.cartModelItems.isNotEmpty
                                ? controller.cartModelItemsCount == 1
                                    ? '${controller.cartModelItemsCount} Item'
                                    : '${controller.cartModelItemsCount} Items'
                                : '',
                            style: AppStyle.gfPoppinsRegularBlack(fontSize: 16),
                          );
                        }),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    child: GetX<CartController>(builder: (controller) {
                      return SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            if (controller.cartModelItemsCount > 0)
                              GetX<CartController>(
                                builder: (controller) => ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: controller.cartModelItems
                                      .map((cartModelElement) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _navigateToProductDetailScreen(
                                              cartModelElement.product),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3),
                                        child: Container(
                                          width: double.maxFinite,
                                          height: 135,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                child: CachedNetworkImage(
                                                  imageUrl: cartModelElement
                                                      .product
                                                      .images
                                                      .first
                                                      .originalSrc,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          'assets/images/lime-light-logo.png',
                                                          fit: BoxFit.cover),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                  fit: BoxFit.fill,
                                                  width: 100,
                                                  height: 135,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          cartModelElement
                                                              .product.title,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppStyle
                                                              .gfPoppinsMediumBlack(
                                                                  fontSize: 14),
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
                                                                    style: AppStyle.gfPoppinsRegularGrey(
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                  Text(
                                                                    cartModelElement
                                                                        .productVariant
                                                                        .title,
                                                                    style: AppStyle.gfPoppinsRegularGrey(
                                                                        fontSize:
                                                                            13),
                                                                  ),
                                                                ],
                                                              )
                                                            : Text(
                                                                '${cartModelElement.product.option.first.name} : ${cartModelElement.productVariant.title}',
                                                                style: AppStyle
                                                                    .gfPoppinsRegularGrey(
                                                                        fontSize:
                                                                            13),
                                                              ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                            'Item # ${cartModelElement.product.id.split('/').last.toLowerCase()}',
                                                            style: AppStyle
                                                                .gfPoppinsRegularGrey(
                                                                    fontSize:
                                                                        13)),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 5),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '\$ ${cartModelElement.productVariant.price.amount.toStringAsFixed(2)}',
                                                            style: AppStyle
                                                                .gfPoppinsMediumBlack(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                          Container(
                                                            width: 80,
                                                            height: 22,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: HexColor(
                                                                  '#F6F6F6'),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    debugPrint(
                                                                        'minus icon on tap');
                                                                    cartController
                                                                        .decreaseQuantity(
                                                                            cartModelElement);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove_rounded,
                                                                    size: 17,
                                                                  ),
                                                                ),
                                                                Text(cartModelElement
                                                                    .quantity
                                                                    .toString()),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    debugPrint(
                                                                        'plus icon on tap');
                                                                    cartController
                                                                        .increaseQuantity(
                                                                            cartModelElement);
                                                                    setState(
                                                                        () {});
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .add_rounded,
                                                                    size: 17,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 2,
            child: Text(''),
          ),
        ],
      )),
    );
  }
}
