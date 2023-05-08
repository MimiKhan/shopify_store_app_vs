import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/controllers/product_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/cart/add_to_cart/new_add_to_cart_screen.dart';
import 'package:shopify_store_app/views/checkout/my_web_view_checkout.dart';
import 'package:shopify_store_app/views/main_ui/main_screen.dart';
import 'package:shopify_store_app/views/products_details/custom_image_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewProductDetailsScreen extends StatefulWidget {
  final Product product;

  const NewProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<NewProductDetailsScreen> createState() =>
      _NewProductDetailsScreenState();
}

class _NewProductDetailsScreenState extends State<NewProductDetailsScreen> {
  final productController = Get.find<ProductController>();
  final loginController = Get.find<LoginController>();

  late Product product;
  List<String> variantsTitle = [];
  List<String> collectionsTitle = [];
  String onlineStoreUrl = '';
  String collectionId = '';

  String selectedItem = '';

  final wishlistController = Get.find<WishListController>();
  final cartController = Get.find<CartController>();

  late bool _favIconState;

  String markdown = '';

  bool userLoggedIn = false;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    // getProductVariantsTitle(product);
    // getProductCollectionsDetails(product);
    String? html = product.descriptionHtml;
    markdown = html2md.convert(html!);
    // onlineStoreUrl = product.onlineStoreUrl!;
    _favIconState = wishlistController.favouritesList.contains(product);
  }

  void getProductVariantsTitle(Product product) {
    for (var element in product.productVariants) {
      variantsTitle.add(element.title);
    }
  }

  void getProductCollectionsDetails(Product product) {
    if (product.collectionList!.isNotEmpty) {
      for (var element in product.collectionList!.reversed) {
        collectionsTitle.add(element.title);
      }
    }
    collectionId = product.collectionList!.first.id;
    productController.getProductsByCollection(
        collectionId: collectionId, product: widget.product);
    debugPrint("Collection ID :: $collectionId :: ");
  }

  void _navigateToAddToCartScreen(Product product) {
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    Get.to(() => NewAddToCartScreen(product: product));
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
          product.collectionList?.first.title ?? "",
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: Colors.black,
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(
                color: _favIconState
                    ? Colors.red
                    : Colors.white, // set the desired color of the icon here
              ),
            ),
            child: IconButton(
              key: UniqueKey(),
              onPressed: () {
                setState(() {
                  wishlistController.toggleFavorites(product);
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
          IconButton(
            onPressed: () {
              Get.to(() => MainScreen(selectedIndex: 3));
            },
            icon: const Icon(
              CupertinoIcons.bag,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.share,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      bottomSheet: BottomAppBar(
        height: 60,
        elevation: 10,
        notchMargin: 15,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: FilledButton(
                onPressed: () {
                  _navigateToAddToCartScreen(product);
                },
                style: FilledButton.styleFrom(backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13))),
                child: Text(
                  "Add To Cart",
                  style: AppStyle.gfPoppinsRegularWhite(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(
              flex: 1,
              child: FilledButton(
                onPressed: () async {

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
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => CustomImageViewer(product: product));
              },
              child: SizedBox(
                width: size.width,
                height: 375,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.product.images.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: product.images[index].originalSrc,
                      placeholder: (context, url) => Image.asset(
                          'assets/images/lime-light-logo.png',
                          fit: BoxFit.cover),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.contain,
                      height: 375,
                      width: size.width,
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
            SmoothPageIndicator(
              controller: _pageController,
              count: widget.product.images.length,
              axisDirection: Axis.horizontal,
              onDotClicked: (index) {
                _pageController.jumpToPage(index);
              },
              effect: const WormEffect(
                dotWidth: 12.0,
                dotHeight: 12.0,
                activeDotColor: Colors.black,
                spacing: 10,
              ),
            ),
            const Divider(
              indent: 40,
              endIndent: 40,
              color: Colors.black,
              thickness: 2,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.product.productVariants.first.compareAtPrice != null
                        ? Row(
                            children: [
                              Text(
                                widget.product.productVariants.first.price
                                    .formattedPrice,
                                style:
                                    AppStyle.gfPoppinsMediumRed(fontSize: 24),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.product.productVariants.first
                                        .compareAtPrice?.formattedPrice ??
                                    '',
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 21),
                              ),
                            ],
                          )
                        : Text(
                            widget.product.productVariants.first.price
                                .formattedPrice,
                            style: AppStyle.gfPoppinsMediumBlack(fontSize: 24),
                          ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        _navigateToAddToCartScreen(product);
                      },
                      child: Text(
                        'Add To Cart',
                        style: AppStyle.gfPoppinsMediumWhite(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: EdgeInsets.all(10.0),
            //     child: Text(
            //       'Title',
            //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                product.title,
                style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: EdgeInsets.all(10.0),
            //     child: Text(
            //       'Product Details',
            //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MarkdownBody(
                data: markdown,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1.1,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'PEOPLE WHO LIKE THIS. ALSO LOVE...',
                  style: AppStyle.gfPoppinsMediumBlack(fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                height: 280,
                child: GetX<ProductController>(builder: (controller) {
                  return ListView.builder(
                      itemCount: controller.productsByCollectionCount,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 280,
                            width: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 190,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: controller
                                          .productsByCollection[index]
                                          .images
                                          .first
                                          .originalSrc,
                                      placeholder: (context, url) => Image.asset(
                                          'assets/images/lime-light-logo.png',
                                          fit: BoxFit.cover),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      controller
                                          .productsByCollection[index].title,
                                      style: AppStyle.gfPoppinsMediumBlack(
                                          fontSize: 15),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      controller
                                          .productsByCollection[index]
                                          .productVariants
                                          .first
                                          .price
                                          .formattedPrice,
                                      style: AppStyle.gfPoppinsBoldBlack(
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
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
