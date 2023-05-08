import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/models/cart_model.dart';
import 'package:shopify_store_app/new_ui_designs/home_screen/controller/home_screen_controller.dart';
import 'package:shopify_store_app/new_ui_designs/product_details/ui/product_details_ui_screen.dart';
import 'package:shopify_store_app/services/hex_color.dart';
import 'package:shopify_store_app/shopify_models/models/src/product/product.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/categories/collections_details_screen.dart';
import 'package:shopify_store_app/views/checkout/new_checkout_design_screen.dart';
import 'package:shopify_store_app/views/search/search_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenUI extends StatefulWidget {
  const HomeScreenUI({Key? key}) : super(key: key);

  @override
  State<HomeScreenUI> createState() => _HomeScreenUIState();
}

class _HomeScreenUIState extends State<HomeScreenUI> {
  final cartController = Get.find<CartController>();
  String? firstName;
  final homeScreenController = Get.find<HomeScreenController>();
  bool isUserLoggedIn = false;
  final loginController = Get.find<LoginController>();
  final wishlistController = Get.find<WishListController>();

  int _current = 0;
  late bool _favIconState;

  @override
  void initState() {
    super.initState();
    checkUserFromShopify();
  }

  Future<void> checkUserFromShopify() async {
    await loginController.checkUser().then((value) async {
      debugPrint("User ID ***:${loginController.currentUser.value?.id}");
      if (loginController.currentUser.value?.id == null) {
        debugPrint("User Not logged in ***");
        if (mounted) {
          setState(() {
            isUserLoggedIn = false;
          });
        }
      } else {
        debugPrint("User logged in ***");
        firstName = loginController.currentUser.value?.firstName ?? '';
        if (mounted) {
          setState(() {
            isUserLoggedIn = true;
          });
        }
      }
    });
  }

  void _navigateToProductDetailScreen(Product product) {
    debugPrint(
        "Product Price **: CP :${product.productVariants.first.compareAtPrice?.formattedPrice} :*: P : ${product.productVariants.first.price.formattedPrice}");
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    debugPrint(product.id);
    Get.to(() => ProductDetailsUI(product: product));
  }

  void _navigateToAllProductsScreen() {
    Fluttertoast.showToast(msg: 'Routing to All Products');
    Get.toNamed('/allProducts');
  }

  void _navigateToCollectionDetailScreen(
      String collectionId, String collectionTitle) {
    Get.to(() => CollectionDetailScreen(
        collectionId: collectionId, collectionTitle: collectionTitle));
  }

  void _navigateToSearchScreen() {
    Get.to(() => const SearchScreen());
  }

  String _getGreetings() {
    var timeNow = DateTime.now();
    var hour = timeNow.hour;

    if (hour < 12) {
      return "Good morning!";
    } else if (hour < 18) {
      return "Good afternoon!";
    } else {
      return "Good evening!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    var isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      backgroundColor: HexColor("#F8F8F8"),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          isUserLoggedIn ? 'Hi, $firstName!' : _getGreetings(),
                          style: AppStyle.gfPoppinsRegularGrey(fontSize: 12),
                        ),
                        Text(
                          "Discover our new Collection",
                          style: AppStyle.gfPoppinsMediumBlack(fontSize: 17),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            _navigateToSearchScreen();
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 22,
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: GetX<HomeScreenController>(builder: (controller) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          controller.collectionsCount == 0
                              ? const Center(
                                  child: CupertinoActivityIndicator(
                                    radius: 14,
                                  ),
                                )
                              : Center(
                                  child: GetX<HomeScreenController>(
                                      builder: (controller) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: CarouselSlider(
                                            items: controller.collections.value
                                                .map((collection) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _navigateToCollectionDetailScreen(
                                                          collection.id,
                                                          collection.title);
                                                    },
                                                    child: SizedBox(
                                                      width: double.maxFinite,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: collection
                                                              .image!
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
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }).toList(),
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                autoPlayInterval:
                                                    const Duration(seconds: 5),
                                                enlargeCenterPage: false,
                                                viewportFraction: 1,
                                                onPageChanged: (index, _) {
                                                  setState(() {
                                                    _current = index;
                                                  });
                                                },
                                                initialPage: _current,
                                                autoPlayCurve:
                                                    Curves.easeInOut),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: controller.collections
                                              .map((entry) {
                                            int index = controller.collections
                                                .indexOf(entry);
                                            return GestureDetector(
                                              child: Container(
                                                width: 12.0,
                                                height: 12.0,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0,
                                                        horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black)
                                                        .withOpacity(
                                                            _current == index
                                                                ? 0.9
                                                                : 0),
                                                    border: Border.all(
                                                        width: _current == index
                                                            ? 0.2
                                                            : 0.7)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: AppStyle.gfPoppinsMediumBlack(fontSize: 17),
                        ),
                        TextButton(
                            onPressed: () {
                              _navigateToAllProductsScreen();
                            },
                            child: Text(
                              "See All",
                              style:
                                  AppStyle.gfPoppinsRegularGrey(fontSize: 12),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: SizedBox(
                      height: 50, // Set the height to 50 pixels
                      child: GetX<HomeScreenController>(builder: (controller) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          children: controller.chipsDataList
                              .asMap()
                              .map((index, choice) => MapEntry(
                                    index,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: SizedBox(
                                        // Set the width of the container to a fixed value
                                        child: ChoiceChip(
                                          labelStyle: controller.chipIndex ==
                                                  index
                                              ? AppStyle.gfPoppinsMediumWhite(
                                                  fontSize: 12)
                                              : AppStyle.gfPoppinsMediumGrey(
                                                  fontSize: 12),
                                          selectedColor: HexColor("#D35F5F"),
                                          backgroundColor: Colors.transparent,
                                          label: Text(choice),
                                          selected:
                                              controller.chipIndex == index,
                                          onSelected: (selected) {
                                            controller.setChipIndex(
                                                newIndex: index);
                                          },
                                        ),
                                      ),
                                    ),
                                  ))
                              .values
                              .toList(),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Obx(() {
                      return homeScreenController.isDataLoading.isTrue
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Shimmer.fromColors(
                                        enabled: homeScreenController
                                            .isDataLoading.value,
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 120,
                                          height: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Shimmer.fromColors(
                                        enabled: homeScreenController
                                            .isDataLoading.value,
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 80,
                                          height: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: [
                                      GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            // childAspectRatio: 1,
                                            crossAxisSpacing: 11,
                                            mainAxisSpacing: 10,
                                            mainAxisExtent: 400,
                                          ),
                                          itemCount: 4,
                                          itemBuilder: (BuildContext context,
                                              int gridViewIndex) {
                                            // var quantityAvailable = controller
                                            //     .bestSellingProducts[gridViewIndex]
                                            //     .productVariants[0]
                                            //     .quantityAvailable!;
                                            return Container(
                                              width: 150,
                                              height: 400,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                // border: Border.all(width: 0.7, color: Colors.grey),
                                                shape: BoxShape.rectangle,
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15)),
                                                    child: Shimmer.fromColors(
                                                      enabled:
                                                          homeScreenController
                                                              .isDataLoading
                                                              .value,
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(
                                                        width: 175,
                                                        height: 200,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 5),
                                                    child: Shimmer.fromColors(
                                                      enabled:
                                                          homeScreenController
                                                              .isDataLoading
                                                              .value,
                                                      baseColor:
                                                          Colors.grey.shade300,
                                                      highlightColor:
                                                          Colors.grey.shade100,
                                                      child: Container(
                                                        width: 180,
                                                        height: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Shimmer.fromColors(
                                                    enabled:
                                                        homeScreenController
                                                            .isDataLoading
                                                            .value,
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    child: Container(
                                                      width: 120,
                                                      height: 25,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                    ]),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GetX<HomeScreenController>(
                                    builder: (controller) {
                                  return controller.productsCount == 0
                                      ? const Center(
                                          child: CupertinoActivityIndicator(
                                            radius: 14,
                                          ),
                                        )
                                      : ListView(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          children: [
                                            GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                // padding:
                                                //     const EdgeInsets.symmetric(
                                                //         horizontal: 10),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  // childAspectRatio: 1,
                                                  crossAxisSpacing: 11,
                                                  mainAxisSpacing: 10,
                                                  mainAxisExtent: 260,
                                                ),
                                                itemCount: controller
                                                    .bestSellingProducts.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int gridViewIndex) {
                                                  _favIconState = wishlistController
                                                      .favouritesList
                                                      .contains(controller
                                                              .bestSellingProducts[
                                                          gridViewIndex]);
                                                  // debugPrint(
                                                  //     "Fav Icon State (${controller.bestSellingProducts[gridViewIndex].title}): $_favIconState");
                                                  return GestureDetector(
                                                    onTap: () {
                                                      debugPrint(
                                                          "GridView Index : $gridViewIndex");
                                                      debugPrint(
                                                          "Product ID : ${controller.bestSellingProducts[gridViewIndex].id}");
                                                      _navigateToProductDetailScreen(
                                                          controller
                                                                  .bestSellingProducts[
                                                              gridViewIndex]);
                                                    },
                                                    child: Container(
                                                      width: 175,
                                                      height: 260,
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        15),
                                                                topRight: Radius
                                                                    .circular(
                                                                        15)),
                                                        // border: Border.all(width: 0.7, color: Colors.grey),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color: Colors.white,
                                                        // boxShadow: [
                                                        //   BoxShadow(
                                                        //     color: Colors.grey.withOpacity(0.5),
                                                        //     spreadRadius: 5,
                                                        //     blurRadius: 7,
                                                        //     offset: const Offset(0, 3), // changes position of shadow
                                                        //   ),
                                                        // ],
                                                      ),
                                                      child: Padding(
                                                        padding: gridViewIndex %
                                                                    2 ==
                                                                0
                                                            ? const EdgeInsets
                                                                .only(right: 10)
                                                            : const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          7),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          7)),
                                                              child: SizedBox(
                                                                height: 187,
                                                                width: 165,
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: controller
                                                                      .bestSellingProducts[
                                                                          gridViewIndex]
                                                                      .images[0]
                                                                      .originalSrc,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Image.asset(
                                                                          'assets/images/lime-light-logo.png',
                                                                          fit: BoxFit
                                                                              .cover),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .error),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                            10.ph,
                                                            Text(
                                                              controller
                                                                  .bestSellingProducts[
                                                                      gridViewIndex]
                                                                  .title,
                                                              style: AppStyle
                                                                  .gfPoppinsMediumBlack(
                                                                      fontSize:
                                                                          11),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            5.ph,
                                                            Text(
                                                              "Price",
                                                              style: AppStyle
                                                                  .gfPoppinsRegularGrey(
                                                                      fontSize:
                                                                          10),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 45,
                                                                    child: Text(
                                                                      controller
                                                                          .bestSellingProducts[
                                                                              gridViewIndex]
                                                                          .productVariants[
                                                                              0]
                                                                          .price
                                                                          .formattedPrice,
                                                                      style: AppStyle.gfPoppinsMediumBlack(
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 100,
                                                                    child:
                                                                        ElevatedButton
                                                                            .icon(
                                                                      onPressed:
                                                                          () {
                                                                        debugPrint(
                                                                            "--*--HomeScreen--*Check Options*--> ${controller.bestSellingProducts[gridViewIndex].option.first.name}");
                                                                        if (controller.bestSellingProducts[gridViewIndex].option.first.name ==
                                                                            'Title') {
                                                                          cartController
                                                                              .addItem(
                                                                            CartModel(
                                                                                productVariant: controller.bestSellingProducts[gridViewIndex].productVariants.first,
                                                                                product: controller.bestSellingProducts[gridViewIndex],
                                                                                quantity: 1),
                                                                          );
                                                                          Fluttertoast.showToast(
                                                                              msg: '${controller.bestSellingProducts[gridViewIndex].title} added to cart. Cart : ${cartController.cartModelItemsCount}');
                                                                        } else {
                                                                          _navigateToProductDetailScreen(
                                                                              controller.bestSellingProducts[gridViewIndex]);
                                                                        }
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        isIOS
                                                                            ? CupertinoIcons.bag_badge_plus
                                                                            : CupertinoIcons.cart_badge_plus,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                      label:
                                                                          Text(
                                                                        "TO CART",
                                                                        style: AppStyle.gfPoppinsMediumBlack(
                                                                            fontSize:
                                                                                10),
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          elevation:
                                                                              0,
                                                                          alignment:
                                                                              Alignment.centerLeft),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ],
                                        );
                                })
                              ],
                            );
                    }),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
