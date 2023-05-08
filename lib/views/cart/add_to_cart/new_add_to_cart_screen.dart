
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/settings_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product_variant/product_variant.dart';
import 'package:shopify_store_app/models/cart_model.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/checkout/new_checkout_design_screen.dart';
import 'package:shopify_store_app/views/products_details/custom_image_view.dart';

class NewAddToCartScreen extends StatefulWidget {
  final Product product;

  const NewAddToCartScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<NewAddToCartScreen> createState() => _NewAddToCartScreenState();
}

class _NewAddToCartScreenState extends State<NewAddToCartScreen> {
  final wishlistController = Get.find<WishListController>();
  final cartController = Get.find<CartController>();
  final settingsController = Get.find<SettingsController>();

  late Product product;
  List<bool> isCardEnabled = [];
  late ProductVariant _productVariant;
  String _productVariantId = '';
  String _productVariantPrice = '';
  int _quantityAvailable = 0;
  final int _quantity = 1;

  var listPV = [];

  bool _optionsAvailable = true;
  int _optionsLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = widget.product;
    _productVariantPrice = product.productVariants.first.price.formattedPrice;
    _productVariantId = product.productVariants.first.id;
    _productVariant = product.productVariants.first;
    _quantityAvailable = product.productVariants.first.quantityAvailable!;

    _optionsAvailable = product.option.first.name == 'Title';
    debugPrint("Options available : $_optionsAvailable :");
    debugPrint("URL : ${widget.product.onlineStoreUrl ?? ''} :");
    _optionsLength = product.option.length;
    debugPrint("Options Length : $_optionsLength :");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // set the color of the back icon here
        ),
        title: Text(
          '${product.collectionList?.first.title}',
          style: AppStyle.gfPoppinsBoldWhite(fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      bottomSheet: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 5),
        height: 60,
        elevation: 10,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                cartController.addItem(CartModel(
                    productVariant: _productVariant,
                    product: product,
                    quantity: _quantity));
                Fluttertoast.showToast(
                    msg:
                    '${product.title} added to cart. Cart : ${cartController.cartModelItemsCount}');
                Get.toNamed('/mainScreen');
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                fixedSize: const Size(220, 50)
              ),
              child: Text(
                "Add To Cart",
                style: AppStyle.gfPoppinsRegularWhite(fontSize: 20),
              ),
            ),
            /*const SizedBox(width: 15,),
            Expanded(
              flex: 1,
              child: FilledButton(
                onPressed: () {

                },
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),

                child: Text(
                  "Buy Now",
                  style: AppStyle.gfPoppinsRegularWhite(fontSize: 20),
                ),
              ),
            ),*/
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                fit: StackFit.loose,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CustomImageViewer(product: product));
                    },
                    child: SizedBox(
                      width: size.width,
                      height: size.height * 0.5,
                      child: ListView.builder(
                          itemCount: product.images.length,
                          physics: const PageScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: product.images[index].originalSrc,
                              placeholder: (context, url) => Image.asset(
                                  'assets/images/lime-light-logo.png',
                                  fit: BoxFit.cover),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.fill,
                              width: size.width,
                            );
                          }),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height * 0.5,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              product.title,
                              style: AppStyle.gfPoppinsBoldBlack(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      // GetX<SettingsController>(
                                      //     builder: (controller) {
                                      //   return Icon(controller
                                      //       .selectedCurrencyIcon.value);
                                      // }),
                                      Text(
                                        _productVariant.price.formattedPrice,
                                        style: AppStyle.gfPoppinsBoldBlack(
                                            fontSize: 28),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          10.ph,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order Status',
                                  style: AppStyle.gfPoppinsRegularBlack(
                                      fontSize: 20),
                                ),
                                /*ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    // foreground color
                                    minimumSize: const Size(150, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() =>
                                        NewProductDetailsScreen(product: product));
                                  },
                                  child: const Text(
                                    'Details',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          !_optionsAvailable
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: SizedBox(
                                    height: 110,
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        // padding: const EdgeInsets.all(15),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent:
                                              _optionsLength > 1 ? 150 : 60,
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 5,
                                        ),
                                        itemCount:
                                            product.productVariants.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // isCardEnabled.add(false);
                                          if (index == 0 &&
                                              isCardEnabled.isEmpty) {
                                            // Set the first item as selected if no items are currently selected
                                            isCardEnabled.add(true);
                                          } else {
                                            isCardEnabled.add(false);
                                          }

                                          int? quantityAvailable = product
                                              .productVariants[index]
                                              .quantityAvailable;
                                          return GestureDetector(
                                              onTap: () {
                                                isCardEnabled.replaceRange(
                                                    0, isCardEnabled.length, [
                                                  for (int i = 0;
                                                      i < isCardEnabled.length;
                                                      i++)
                                                    false
                                                ]);
                                                isCardEnabled[index] = true;
                                                setState(() {
                                                  _productVariantPrice = product
                                                      .productVariants[index]
                                                      .price
                                                      .formattedPrice;
                                                  _productVariantId = product
                                                      .productVariants[index]
                                                      .id;
                                                  _productVariant = product
                                                      .productVariants[index];
                                                  _quantityAvailable = product
                                                          .productVariants[
                                                              index]
                                                          .quantityAvailable ??
                                                      0;
                                                  listPV.add(product.productVariants[index].title);
                                                });
                                              },
                                              child: quantityAvailable! > 0
                                                  ? Container(
                                                      height: 30,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color:
                                                            isCardEnabled[index]
                                                                ? Colors.black
                                                                : const Color(
                                                                    0xfffafafa),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          product
                                                              .productVariants[
                                                                  index]
                                                              .title
                                                              .toString(),
                                                          style: TextStyle(
                                                            color:
                                                                isCardEnabled[
                                                                        index]
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : IgnorePointer(
                                                      ignoring: true,
                                                      child: Container(
                                                        height: 30,
                                                        width: 140,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.9),
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: isCardEnabled[
                                                                  index]
                                                              ? Colors.black
                                                              : const Color(
                                                                  0xfffafafa),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            product
                                                                .productVariants[
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  isCardEnabled[
                                                                          index]
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                        }),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          _productVariant.title != 'Default Title' ?
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Product Selected",
                                  style: AppStyle.gfPoppinsMediumBlack(
                                      fontSize: 16),
                                ),
                                // Text(
                                //   _productVariant.title != 'Default Title'
                                //       ? _productVariant.title
                                //       : 'Single Variant',
                                //   style:
                                //       AppStyle.gfPoppinsBoldBlack(fontSize: 16),
                                // ),
                              ],
                            ),
                          ):
                              const Text('Single Variant'),

                          const SizedBox(
                            height: 12,
                          ),
                          _productVariant.title != 'Default Title'?
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Size : ",
                                  style: AppStyle.gfPoppinsRegularBlack(
                                      fontSize: 16),
                                ),
                                Text(
                                  _productVariant.title != 'Default Title'
                                      ? _productVariant.title.removeAllWhitespace.split("/").first
                                      : '',
                                  style:
                                      AppStyle.gfPoppinsBoldBlack(fontSize: 16),
                                ),
                                Text(
                                  ", Color : ",
                                  style: AppStyle.gfPoppinsRegularBlack(
                                      fontSize: 16),
                                ),
                                Text(
                                  _productVariant.title != 'Default Title'
                                      ? _productVariant.title.removeAllWhitespace.split("/").last
                                      : '',
                                  style:
                                      AppStyle.gfPoppinsBoldBlack(fontSize: 16),
                                ),
                              ],
                            ),
                          ):
                          const SizedBox(),

                          const SizedBox(
                            height: 25,
                          ),

                          /*Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                // foreground color
                                minimumSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              onPressed: () {
                                cartController.addItem(CartModel(
                                    productVariant: _productVariant,
                                    product: product,
                                    quantity: _quantity));
                                Fluttertoast.showToast(
                                    msg:
                                        '${product.title} added to cart. Cart : ${cartController.cartModelItemsCount}');
                                Get.toNamed('/mainScreen');
                              },
                              child: const Text('Add to Cart'),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 50,
                  //   right: 15,
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(
                  //       CupertinoIcons.share,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
