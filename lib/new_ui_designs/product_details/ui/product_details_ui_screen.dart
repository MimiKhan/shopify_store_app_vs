import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/services/hex_color.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/option/option.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product_variant/product_variant.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/products_details/custom_image_view.dart';

class ProductDetailsUI extends StatefulWidget {
  const ProductDetailsUI({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDetailsUI> createState() => _ProductDetailsUIState();
}

class _ProductDetailsUIState extends State<ProductDetailsUI> {
  final wishlistController = Get.find<WishListController>();
  final cartController = Get.find<CartController>();

  late bool _favIconState;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool hasColorOption = false;
  bool hasSizeOption = false;
  List<String> colorOptions = [];
  List<String> sizeOptions = [];
  List<String> colorsInHex = [];
  String markdown = '';

  String selectedColor = '';
  String selectedSize = '';
  bool _optionsAvailable = true;
  int _optionsLength = 0;

  late ProductVariant _productVariant;

  List<String> option1Values = [];
  List<String> option2Values = [];
  List<String> option3Values = [];

  List<bool> isOption1CardEnabled = [];
  List<bool> isOption2CardEnabled = [];
  List<bool> isOption3CardEnabled = [];

  String? option1Selected;
  String? option2Selected;
  String? option3Selected;

  @override
  void initState() {
    super.initState();
    debugPrint(widget.product.option.toString());
    _favIconState = wishlistController.favouritesList.contains(widget.product);
    _productVariant = widget.product.productVariants.first;
    _optionsAvailable = widget.product.option.first.name == 'Title';
    _optionsLength = widget.product.option.length;
    getOptions();
    printOptionsList();
    String? html = widget.product.descriptionHtml;
    markdown = html2md.convert(html!);
    // hasColorOption = widget.product.option
    //     .any((option) => option.name.toLowerCase().contains('color'));
    // hasSizeOption = widget.product.option
    //     .any((option) => option.name.toLowerCase().contains('size'));
    // debugPrint('Color Option Available : $hasColorOption :');
    // debugPrint('Size Option Available : $hasSizeOption :');
    // if (hasColorOption) {
    //   colorOptions = widget.product.option
    //       .where((option) => option.name.toLowerCase().contains('color'))
    //       .first
    //       .values;
    //   // debugPrint("Color Options : $colorOptions");
    //   convertNamedColors(colorOptions);
    //   // debugPrint("Colors options in Hex : $colorsInHex");
    // }
    // if (hasSizeOption) {
    //   sizeOptions = widget.product.option
    //       .where((option) => option.name.toLowerCase().contains('size'))
    //       .first
    //       .values;
    //   debugPrint('Size Options :init: $sizeOptions');
    // }
    // if (hasSizeOption) {
    //   sizeOptions = widget.product.option
    //       .where((option) => option.name.toLowerCase().contains('size'))
    //       .first
    //       .values
    //       .where((size) => widget.product.productVariants.any((variant) =>
    //           variant.title
    //               .toLowerCase()
    //               .contains(selectedColor.toLowerCase()) &&
    //           variant.title.toLowerCase().contains(size.toLowerCase()) &&
    //           variant.quantityAvailable != null &&
    //           variant.quantityAvailable! > 0))
    //       .toList();
    //   debugPrint('Size Options :init: $sizeOptions');
    // }

    // checkProductOptions(product:widget.product);
  }

  void getOptions() {
    option1Values.clear();
    option2Values.clear();
    option3Values.clear();

    // Get the options available for the product
    List<Option> options = widget.product.option;

    // Loop through each option and add the available values to the appropriate option value list
    for (Option option in options) {
      List<String> values = option.values;

      if (option1Values.isEmpty) {
        option1Values.addAll(values);
      } else if (option2Values.isEmpty) {
        option2Values.addAll(values);
      } else if (option3Values.isEmpty) {
        option3Values.addAll(values);
      }
    }
  }

  void printOptionsList() {
    debugPrint('Options Length :init: => $_optionsLength');
    debugPrint('Options -------------');
    debugPrint('Option 1 : ${option1Values.toString()} :');
    debugPrint('Option 2 : ${option2Values.toString()} :');
    debugPrint('Option 3 : ${option3Values.toString()} :');
    debugPrint('------------- Options');
  }

  void printOptionsSelected() {
    debugPrint('Options Selected-------------');
    debugPrint('Option 1 : $option1Selected :');
    debugPrint('Option 2 : $option2Selected :');
    debugPrint('Option 3 : $option3Selected :');
    debugPrint('------------- Options');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F8F8F8"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Details",
          style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, // set the color of the back icon here
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: _favIconState
                    ? Colors.red
                    : Colors.black, // set the desired color of the icon here
              ),
            ),
            child: IconButton(
              key: UniqueKey(),
              onPressed: () {
                setState(() {
                  wishlistController.toggleFavorites(widget.product);
                  _favIconState = !_favIconState;
                });
                debugPrint(
                    "Length of Fav List : ${wishlistController.favouritesList.length}");
              },
              icon: Icon(
                _favIconState ? Icons.favorite : Icons.favorite_border_outlined,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: BottomAppBar(
          padding: const EdgeInsets.symmetric(vertical: 5),
          height: 65,
          elevation: 0,
          color: HexColor("#F8F8F8"),
          child: FilledButton.icon(
            onPressed: () {
              // cartController.addItem(CartModel(
              //     productVariant: _productVariant,
              //     product: product,
              //     quantity: _quantity));
              printOptionsSelected();
              Fluttertoast.showToast(
                  msg:
                      '${widget.product.title} added to cart. Cart : ${cartController.cartModelItemsCount}');
              Get.toNamed('/mainScreen');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            icon: const Icon(CupertinoIcons.bag_badge_plus),
            label: Text(
              "Add To Cart",
              style: AppStyle.gfPoppinsRegularWhite(fontSize: 20),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Images Scroll View
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => CustomImageViewer(product: widget.product));
                },
                child: Container(
                  width: double.maxFinite,
                  height: 310,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.product.images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          imageUrl: widget.product.images[index].originalSrc,
                          placeholder: (context, url) => Image.asset(
                              'assets/images/lime-light-logo.png',
                              fit: BoxFit.cover),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          height: double.maxFinite,
                        ),
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                  ),
                ),
              ),
            ),

            // Title Widget
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 36),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ExpandableText(
                  widget.product.title,
                  expandText: 'more',
                  maxLines: 1,
                  collapseText: 'less',
                  linkColor: Colors.blue,
                  style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                ),
              ),
            ),

            // Price Widget
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: AppStyle.gfPoppinsRegularGrey(fontSize: 15),
                  ),
                  _productVariant.compareAtPrice != null
                      ? Row(
                          children: [
                            Text(
                              _productVariant.price.formattedPrice,
                              style: AppStyle.gfPoppinsMediumRed(fontSize: 21),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              _productVariant.compareAtPrice?.formattedPrice ??
                                  '',
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 19),
                            ),
                          ],
                        )
                      : Text(
                          _productVariant.price.formattedPrice,
                          style: AppStyle.gfPoppinsMediumBlack(fontSize: 21),
                        ),
                ],
              ),
            ),

            // Description Widget
            /*Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 36),
              child: ExpandableText(
                '${widget.product.description}',
                expandText: 'more',
                collapseText: 'less',
                linkColor: Colors.blue,
                style: AppStyle.gfPoppinsRegularBlack(fontSize: 10),
              ),
            ),*/

            _optionsAvailable
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all()),
                      child: Text(
                        " Single Variant ",
                        style: AppStyle.gfPoppinsMediumBlack(fontSize: 18),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1st GridView
                      option1Values.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 5),
                              child: Text(
                                "Select ${widget.product.option[0].name}",
                                style:
                                    AppStyle.gfPoppinsMediumBlack(fontSize: 12),
                              ),
                            )
                          : const SizedBox(),
                      option1Values.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 36),
                              child: Container(
                                height: 50,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 55,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemCount: option1Values.length * 2 - 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    int nestedIndex = index ~/ 2;
                                    bool isSelectable = index % 2 == 0;
                                    bool isAvailable =
                                        false; // check if the size is available in selected color
                                    if (isSelectable) {
                                      // if (index == 0 &&
                                      //     isSizeCardEnabled.isEmpty) {
                                      //   // Set the first item as selected if no items are currently selected
                                      //   isSizeCardEnabled.add(true);
                                      // } else {
                                      //   isSizeCardEnabled.add(false);
                                      // }
                                      isOption1CardEnabled.add(false);

                                      return GestureDetector(
                                        onTap: () {
                                          isOption1CardEnabled.replaceRange(
                                              0, isOption1CardEnabled.length, [
                                            for (int i = 0;
                                                i < isOption1CardEnabled.length;
                                                i++)
                                              false
                                          ]);
                                          isOption1CardEnabled[nestedIndex] =
                                              true;

                                          option1Selected =
                                              option1Values[nestedIndex];
                                          debugPrint(
                                              "Option 1 Seelcted on Tap :: ${option1Selected.toString()}");
                                          if (option2Values.isNotEmpty) {
                                            updateOption2(option1Selected!);
                                          }

                                          // debugPrint(
                                          //     "Selected Size :: ${sizeOptions[sizeIndex]}");
                                          // selectedSize = sizeOptions[sizeIndex];
                                          // if (selectedColor.isNotEmpty) {
                                          //   checkAvailability(
                                          //       selectedSize, selectedColor);
                                          // } else {
                                          //   for (ProductVariant variant
                                          //       in widget
                                          //           .product.productVariants) {
                                          //     if (variant.title
                                          //         .toLowerCase()
                                          //         .contains(selectedSize
                                          //             .toLowerCase())) {
                                          //       _productVariant = variant;
                                          //       break;
                                          //     }
                                          //   }
                                          //   debugPrint(
                                          //       'Selected Variant :Only Size: ${_productVariant.title}');
                                          // }
                                          // if (mounted) {
                                          //   setState(() {});
                                          // }
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Text(
                                                    option1Values[nestedIndex],
                                                    style: isOption1CardEnabled[
                                                            nestedIndex]
                                                        ? AppStyle
                                                            .gfPoppinsBoldBlack(
                                                                fontSize: 12)
                                                        : AppStyle
                                                            .gfPoppinsRegularBlack(
                                                                fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  width: 30,
                                                  height: 2,
                                                  decoration: BoxDecoration(
                                                    border: isOption1CardEnabled[
                                                            nestedIndex]
                                                        ? const Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2))
                                                        : const Border(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(
                                        width: 3,
                                        height: 3,
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.grey,
                                          size: 5,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
                          : const SizedBox(),

                      const SizedBox(
                        height: 15,
                      ),

                      // 2nd GridView
                      option2Values.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 5),
                              child: Text(
                                'Select ${widget.product.option[1].name}',
                                style:
                                    AppStyle.gfPoppinsMediumBlack(fontSize: 12),
                              ),
                            )
                          : const SizedBox(),
                      option2Values.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 36),
                              child: Container(
                                height: 60,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 55,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemCount: option2Values.length * 2 - 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    int nestedIndex = index ~/ 2;
                                    bool isSelectable = index % 2 == 0;

                                    if (isSelectable) {
                                      // if (index == 0 &&
                                      //     isOption2CardEnabled.isEmpty) {
                                      //   // Set the first item as selected if no items are currently selected
                                      //   isOption2CardEnabled.add(true);
                                      // } else {
                                      //   isOption2CardEnabled.add(false);
                                      // }
                                      isOption2CardEnabled.add(false);

                                      return GestureDetector(
                                        onTap: () {
                                          isOption2CardEnabled.replaceRange(
                                              0, isOption2CardEnabled.length, [
                                            for (int i = 0;
                                                i < isOption2CardEnabled.length;
                                                i++)
                                              false
                                          ]);
                                          isOption2CardEnabled[nestedIndex] =
                                              true;
                                          option2Selected =
                                              option2Values[nestedIndex];
                                          if (option3Values.isNotEmpty) {
                                            if (option1Selected == null) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Please select any above option to continue.');
                                            } else {
                                              updateOption3(option1Selected!,
                                                  option2Selected!);
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Text(
                                                    option2Values[nestedIndex],
                                                    style: isOption2CardEnabled[
                                                            nestedIndex]
                                                        ? AppStyle
                                                            .gfPoppinsBoldBlack(
                                                                fontSize: 12)
                                                        : AppStyle
                                                            .gfPoppinsRegularBlack(
                                                                fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  width: 30,
                                                  height: 2,
                                                  decoration: BoxDecoration(
                                                    border: isOption2CardEnabled[
                                                            nestedIndex]
                                                        ? const Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2))
                                                        : const Border(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(
                                        width: 3,
                                        height: 3,
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.grey,
                                          size: 5,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
                          : const SizedBox(),
                      // Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 36, vertical: 5),
                      //     child: Text(
                      //       "Out of Stock",
                      //       style:
                      //           AppStyle.gfPoppinsMediumBlack(fontSize: 18),
                      //     ),
                      //   ),

                      // 3rd GridView
                      option3Values.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 5),
                              child: Text(
                                'Select ${widget.product.option[2].name}',
                                style:
                                    AppStyle.gfPoppinsMediumBlack(fontSize: 12),
                              ),
                            )
                          : const SizedBox(),
                      option3Values.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 36),
                              child: Container(
                                height: 60,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisExtent: 55,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 5,
                                  ),
                                  itemCount: option3Values.length * 2 - 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    int nestedIndex = index ~/ 2;
                                    bool isSelectable = index % 2 == 0;

                                    if (isSelectable) {
                                      if (index == 0 &&
                                          isOption3CardEnabled.isEmpty) {
                                        // Set the first item as selected if no items are currently selected
                                        isOption3CardEnabled.add(true);
                                      } else {
                                        isOption3CardEnabled.add(false);
                                      }
                                      // isOption3CardEnabled.add(false);
                                      return GestureDetector(
                                        onTap: () {
                                          isOption3CardEnabled.replaceRange(
                                              0, isOption3CardEnabled.length, [
                                            for (int i = 0;
                                                i < isOption3CardEnabled.length;
                                                i++)
                                              false
                                          ]);
                                          isOption3CardEnabled[nestedIndex] =
                                              true;
                                          option3Selected =
                                              option3Values[nestedIndex];
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Text(
                                                    option3Values[nestedIndex],
                                                    style: isOption3CardEnabled[
                                                            nestedIndex]
                                                        ? AppStyle
                                                            .gfPoppinsBoldBlack(
                                                                fontSize: 12)
                                                        : AppStyle
                                                            .gfPoppinsRegularBlack(
                                                                fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  width: 30,
                                                  height: 2,
                                                  decoration: BoxDecoration(
                                                    border: isOption3CardEnabled[
                                                            nestedIndex]
                                                        ? const Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2))
                                                        : const Border(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(
                                        width: 3,
                                        height: 3,
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.grey,
                                          size: 5,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
                          : const SizedBox()
                      // Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 36, vertical: 5),
                      //     child: Text(
                      //       "Out of Stock",
                      //       style:
                      //           AppStyle.gfPoppinsMediumBlack(fontSize: 18),
                      //     ),
                      //   ),
                    ],
                  ),

            const SizedBox(
              height: 15,
            ),

            if (widget.product.description!.isNotEmpty)
              // Description Widget
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 5),
                child: Text(
                  'Description',
                  style: AppStyle.gfPoppinsMediumBlack(fontSize: 12),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 5),
              child: MarkdownBody(
                data: markdown,
              ),
            ),

            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  // void update2ndOptions(String selectedOption) {
  //   debugPrint(
  //       "Update Option Called... 1st option selected : ${selectedOption} :");
  //   option2Values.clear();
  //   // option3Values.clear();

  //   for (ProductVariant variant in widget.product.productVariants) {
  //     if (variant.title.removeAllWhitespace.split("/").first ==
  //             selectedOption &&
  //         variant.quantityAvailable != null &&
  //         variant.quantityAvailable! > 0) {
  //       if (variant.title.removeAllWhitespace.split("/")[1] != null &&
  //           !option2Values
  //               .contains(variant.title.removeAllWhitespace.split("/")[1])) {
  //         bool option2HasAvailableQuantity = false;
  //         for (ProductVariant variant2 in widget.product.productVariants) {
  //           if (variant2.title.removeAllWhitespace.split("/").first ==
  //                   selectedOption &&
  //               variant2.title.removeAllWhitespace.split("/")[1] ==
  //                   variant.title.removeAllWhitespace.split("/")[1] &&
  //               variant2.quantityAvailable != null &&
  //               variant2.quantityAvailable! > 0) {
  //             option2HasAvailableQuantity = true;
  //             break;
  //           }
  //         }
  //         if (option2HasAvailableQuantity) {
  //           option2Values.add(variant.title.removeAllWhitespace.split("/")[1]);
  //         }
  //       }

  //       // if (variant.title.removeAllWhitespace.split("/").last != null &&
  //       //     !option3Values
  //       //         .contains(variant.title.removeAllWhitespace.split("/").last)) {
  //       //   bool option3HasAvailableQuantity = false;
  //       //   for (ProductVariant variant3 in widget.product.productVariants) {
  //       //     if (variant3.title.removeAllWhitespace.split("/").first ==
  //       //             selectedOption &&
  //       //         variant3.title.removeAllWhitespace.split("/").last ==
  //       //             variant.title.removeAllWhitespace.split("/").last &&
  //       //         variant3.quantityAvailable != null &&
  //       //         variant3.quantityAvailable! > 0) {
  //       //       option3HasAvailableQuantity = true;
  //       //       break;
  //       //     }
  //       //   }
  //       //   if (option3HasAvailableQuantity) {
  //       //     option3Values
  //       //         .add(variant.title.removeAllWhitespace.split("/").last);
  //       //   }
  //       // }
  //     }
  //   }

  //   printOptionsList();
  //   debugPrint("2nd Update method done. setting state.");
  //   setState(() {});
  // }

  // void update3rdOptions(String selectedOption) {
  //   debugPrint(
  //       "3rd Update Option Called... 2nd option selected : ${selectedOption} :");
  //   // option2Values.clear();
  //   option3Values.clear();

  //   for (ProductVariant variant in widget.product.productVariants) {
  //     if (variant.title.removeAllWhitespace.split("/").first ==
  //             selectedOption &&
  //         variant.quantityAvailable != null &&
  //         variant.quantityAvailable! > 0) {
  //       // if (variant.title.removeAllWhitespace.split("/")[1] != null &&
  //       //     !option2Values
  //       //         .contains(variant.title.removeAllWhitespace.split("/")[1])) {
  //       //   bool option2HasAvailableQuantity = false;
  //       //   for (ProductVariant variant2 in widget.product.productVariants) {
  //       //     if (variant2.title.removeAllWhitespace.split("/").first ==
  //       //             selectedOption &&
  //       //         variant2.title.removeAllWhitespace.split("/")[1] ==
  //       //             variant.title.removeAllWhitespace.split("/")[1] &&
  //       //         variant2.quantityAvailable != null &&
  //       //         variant2.quantityAvailable! > 0) {
  //       //       option2HasAvailableQuantity = true;
  //       //       break;
  //       //     }
  //       //   }
  //       //   if (option2HasAvailableQuantity) {
  //       //     option2Values.add(variant.title.removeAllWhitespace.split("/")[1]);
  //       //   }
  //       // }

  //       if (variant.title.removeAllWhitespace.split("/").last != null &&
  //           !option3Values
  //               .contains(variant.title.removeAllWhitespace.split("/").last)) {
  //         bool option3HasAvailableQuantity = false;
  //         for (ProductVariant variant3 in widget.product.productVariants) {
  //           if (variant3.title.removeAllWhitespace.split("/").first ==
  //                   selectedOption &&
  //               variant3.title.removeAllWhitespace.split("/").last ==
  //                   variant.title.removeAllWhitespace.split("/").last &&
  //               variant3.quantityAvailable != null &&
  //               variant3.quantityAvailable! > 0) {
  //             option3HasAvailableQuantity = true;
  //             break;
  //           }
  //         }
  //         if (option3HasAvailableQuantity) {
  //           option3Values
  //               .add(variant.title.removeAllWhitespace.split("/").last);
  //         }
  //       }
  //     }
  //   }

  //   printOptionsList();
  //   debugPrint("3rd Update method done. setting state.");
  //   setState(() {});
  // }
  // This method updates the second option list based on the selected first option
  void updateOption2(String selectedOption1) {
    option2Values.clear();

    for (ProductVariant variant in widget.product.productVariants) {
      if (variant.title.removeAllWhitespace.split("/").first ==
              selectedOption1 &&
          variant.quantityAvailable != null &&
          variant.quantityAvailable! > 0) {
        if (!option2Values
            .contains(variant.title.removeAllWhitespace.split("/")[1])) {
          option2Values.add(variant.title.removeAllWhitespace.split("/")[1]);
        }
      }
    }

    printOptionsList();
    debugPrint("2nd Update method done. setting state.");
    setState(() {});
  }

// This method updates the third option list based on the selected first and second options
  void updateOption3(String selectedOption1, String selectedOption2) {
    option3Values.clear();

    for (ProductVariant variant in widget.product.productVariants) {
      if (variant.title.removeAllWhitespace.split("/").first ==
              selectedOption1 &&
          variant.title.removeAllWhitespace.split("/")[1] == selectedOption2 &&
          variant.quantityAvailable != null &&
          variant.quantityAvailable! > 0) {
        if (!option3Values
            .contains(variant.title.removeAllWhitespace.split("/").last)) {
          option3Values.add(variant.title.removeAllWhitespace.split("/").last);
        }
      }
    }

    printOptionsList();
    debugPrint("3rd Update method done. setting state.");
    setState(() {});
  }

  void checkProductOptions({required Product product}) {
    List<Option> options = product.option; // your list of options
    List<Option> colorOptions =
        options.where((option) => option.name == 'Color').toList();
    bool hasColorOption = options.any((option) => option.name == 'Color');
    debugPrint('Color Option Available : $hasColorOption :');

    for (var element in colorOptions) {
      debugPrint(element.values.first);
    }
  }

  void showSizeOnColor({required String color}) {
    List<ProductVariant> filteredVariants = [];

    for (ProductVariant variant in widget.product.productVariants) {
      if (variant.title.toLowerCase().contains(color.toLowerCase()) &&
          variant.quantityAvailable != null &&
          variant.quantityAvailable! > 0) {
        filteredVariants.add(variant);
      }
    }

    // Find the index of the "Size" option
    int sizeOptionIndex = widget.product.option
        .indexWhere((option) => option.name.toLowerCase() == "size");

    // Create a new list to store the sizes
    List<String> sizeOptionsNew = [];

    for (var element in filteredVariants) {
      String size =
          element.title.removeAllWhitespace.split("/")[sizeOptionIndex];
      if (element.quantityAvailable != null && element.quantityAvailable! > 0) {
        sizeOptionsNew.add(size);
      }
    }

    // Assign the new list to the original list variable
    setState(() {
      sizeOptions = [];
      sizeOptions = sizeOptionsNew;
    });
  }

  void checkAvailability(String selectedSize, String selectedColor) {
    for (ProductVariant variant in widget.product.productVariants) {
      if (variant.title.toLowerCase().contains(selectedColor.toLowerCase()) &&
          variant.title.toLowerCase().contains(selectedSize.toLowerCase())) {
        setState(() {
          _productVariant = variant;
        });
        break;
      }
    }
    debugPrint(
        "Product variant selected :Check Avail: ${_productVariant.title}");
  }

  namedColorToHex(String colorName) {
    // debugPrint("color received : $colorName");
    // First, create a map of named colors to their corresponding MaterialColor objects
    Map<String, Color> colorMap = {
      'black': Colors.black,
      'white': Colors.white,
      'red': Colors.red,
      'pink': Colors.pink,
      'purple': Colors.purple,
      'deepPurple': Colors.deepPurple,
      'indigo': Colors.indigo,
      'blue': Colors.blue,
      'lightBlue': Colors.lightBlue,
      'cyan': Colors.cyan,
      'teal': Colors.teal,
      'green': Colors.green,
      'lightGreen': Colors.lightGreen,
      'lime': Colors.lime,
      'yellow': Colors.yellow,
      'amber': Colors.amber,
      'orange': Colors.orange,
      'deepOrange': Colors.deepOrange,
      'brown': Colors.brown,
      'grey': Colors.grey,
      'blueGrey': Colors.blueGrey,
      'navy': const Color(0xFF000042),
      'graphite': const Color(0xFF4F4F4F),
      'silver': const Color(0xFFE4E2E3),
      'maroon': const Color(0xFF800000),
      'navyBlue': const Color(0xFF000080),
      'khaki': const Color(0xFFF0E68C),
      'olive': const Color(0xFF808000),
      'beige': const Color(0xFFF5F5DC),
      'tan': const Color(0xFFD2B48C),
      'camel': const Color(0xFFC19A6B),
      'taupe': const Color(0xFF483C32),
    };

    Object? colorVar;

    if (colorMap[colorName.toLowerCase()].runtimeType == MaterialColor) {
      colorVar = colorMap[colorName.toLowerCase()]
          .toString()
          .removeAllWhitespace
          .split(':')
          .last
          .replaceAll("))", ")");
      debugPrint("Material Color here :: $colorVar");
    } else {
      colorVar = colorMap[colorName.toLowerCase()];
      debugPrint("Color here :: $colorVar");
    }

    // Next, look up the MaterialColor object corresponding to the given color name
    Color color = colorMap[colorName.toLowerCase()] ?? Colors.transparent;

    // debugPrint("Color::$color::");

    // If the color is not found in the map, return null
    if (color == null) {
      debugPrint('No Color Found');
    }
    colorsInHex
        .add('#${color.value.toRadixString(16).toUpperCase().substring(2)}');

    // // Finally, convert the MaterialColor object to a hexadecimal string
    // String hex = '#${color.value.toRadixString(16).toUpperCase().substring(2)}';
    // debugPrint('hex = $hex');
    // return hex;
  }

  convertNamedColors(List<String> colorStrList) {
    for (var element in colorStrList) {
      // debugPrint("Color Received From Color List *: $element");
      namedColorToHex(element);
      // debugPrint("Color converted From Color to Hex :: $hex :: ");
      // colorsInHex.add(hex);
      // debugPrint("$element added... ${colorsInHex.toString()}");
    }
    debugPrint("Done converting...");
  }
}
