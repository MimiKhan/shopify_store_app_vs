import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/shopify_models/flutter_simple_shopify.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product_variant/product_variant.dart';
import 'package:shopify_store_app/models/cart_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddToCartScreen extends StatefulWidget {
  final Product product;
  final ScrollController controller;
  final PanelController panelController;


  const AddToCartScreen({Key? key, required this.product, required this.controller, required this.panelController}) : super(key: key);

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  late Product product;
  final cartController = Get.find<CartController>();

  List<bool> isCardEnabled = [];

  late ProductVariant _productVariant;
  String _productVariantPrice = '';
  String _productVariantId = '';

  int _quantity = 1;

  String _optionSelected = '';
  late ScrollController scrollController;
  late PanelController panelController;

  var _optionsAvailable = true;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = widget.product;
    debugPrint(product.id);
    _productVariantPrice = product.productVariants.first.price.formattedPrice;
    _productVariantId = product.productVariants.first.id;
    _productVariant = product.productVariants.first;
    _optionSelected = product.option.first.name;
    scrollController = widget.controller;
    panelController = widget.panelController;
    // _optionsAvailable = product.option.first.name == 'Title';
    int optionsLen = product.option.length;
    debugPrint("Options Length : $optionsLen :");

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 40,
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.images.first.url,
                  placeholder: (context, url) => Image.asset(
                      'assets/images/lime-light-logo.png',
                      fit: BoxFit.fill),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                  height: 180,
                  width: size.width - 10,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),*/
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                _productVariantPrice,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Offstage(
              offstage: _optionsAvailable,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      product.option.first.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      ' :  ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _optionsAvailable ? 'Default' : _optionSelected,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            Offstage(
              offstage: _optionsAvailable,
              child: SizedBox(
                // width: 411,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: GridView.builder(
                    controller: scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(15),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        // childAspectRatio: 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: product.productVariants.length,
                      itemBuilder: (BuildContext context, int index) {
                        isCardEnabled.add(false);
                        return GestureDetector(
                          onTap: () {
                            isCardEnabled.replaceRange(0, isCardEnabled.length, [
                              for (int i = 0; i < isCardEnabled.length; i++) false
                            ]);
                            isCardEnabled[index] = true;
                            setState(() {
                              _productVariantPrice = product
                                  .productVariants[index].price.formattedPrice;
                              _productVariantId =
                                  product.productVariants[index].id;
                              _productVariant = product.productVariants[index];
                            });
                            debugPrint(
                                "Product variant Selected : ${product.productVariants[index].title}");
                            debugPrint(
                                "Product variant Selected ID : ${product.productVariants[index].id}");
                            setState(() {
                              _optionSelected =
                                  product.productVariants[index].title;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(15),
                              color: isCardEnabled[index]
                                  ? Colors.black
                                  : const Color(0xfffafafa),
                            ),
                            child: Center(
                              child: Text(
                                product.productVariants[index].title.toString(),
                                style: TextStyle(
                                  color: isCardEnabled[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity--;
                        });
                      },
                      icon: const Icon(
                        CupertinoIcons.minus_circle,
                        size: 24,
                        color: Colors.black,
                      )),
                  Text(
                    _quantity.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                      icon: const Icon(
                        CupertinoIcons.plus_circle,
                        size: 24,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: ElevatedButton(
                onPressed: () {
                  cartController.addItem(CartModel(productVariant: _productVariant, product: product, quantity: _quantity));
                  Fluttertoast.showToast(msg: '${product.title} added to cart. Cart : ${cartController.cartModelItemsCount}');
                  Get.back();

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade300,
                  fixedSize: const Size(150, 50),
                  visualDensity: VisualDensity.comfortable,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
