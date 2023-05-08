import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/home_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/shopify_models/models/models.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/cart/add_to_cart/new_add_to_cart_screen.dart';
import 'package:shopify_store_app/views/categories/collections_details_screen.dart';
import 'package:shopify_store_app/views/products_details/new_product_details_screen.dart';
import 'package:shopify_store_app/widgets/exit_popup.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  // customiseSystemOverlay(){
  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       statusBarBrightness: Brightness.dark,
  //       statusBarIconBrightness: Brightness.light));
  // }

  final homeController = Get.find<HomeController>();

  final cartController = Get.find<CartController>();
  final wishlistController = Get.find<WishListController>();
  late bool _favIconState;

  int _currentIndex = 0;

  bool _shopDataAvailable = false;

  void _toggleSwitch(int? index) {
    setState(() {
      _currentIndex = index!;
    });
  }

  void _navigateToAddToCartScreen(Product product) {
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    debugPrint(product.id);
    Get.to(() => NewAddToCartScreen(product: product));
  }

  void _navigateToProductDetailScreen(Product product) {
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    debugPrint(product.id);
    Get.to(() => NewProductDetailsScreen(product: product));
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

  bool _shimmerUpperEnable = true;
  bool _shimmerLowerEnable = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitForShimmerEffect();
    // _shopDataAvailable = homeController.currentShop.value?.name != null;
  }

  Future<void> waitForShimmerEffect() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          _shimmerUpperEnable = false;
          _shimmerLowerEnable = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          // title: GetX<HomeController>(builder: (controller) {
          //   return Text(
          //     controller.currentShop.value?.name ?? '',
          //     style: AppStyle.gfPoppinsBoldBlack(fontSize: 26),
          //   );
          // }),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list,
                color: Colors.black,
                size: 28,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20,
                    child: Icon(CupertinoIcons.person),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _shimmerUpperEnable
                    ? SizedBox(
                        height: 320,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: 60,
                              left: 35,
                              child: Shimmer.fromColors(
                                enabled: _shimmerUpperEnable,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 150,
                                  height: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 7,
                              left: size.width / 10.5,
                              right: size.width / 10.5,
                              child: Shimmer.fromColors(
                                enabled: _shimmerUpperEnable,
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: size.width * 0.9,
                                  height: 180,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 320,
                        child: GetX<HomeController>(builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Collection",
                                style:
                                    AppStyle.gfPoppinsBoldBlack(fontSize: 24),
                              ),
                              SizedBox(
                                width: size.width * 0.9,
                                height: 180,
                                child: CachedNetworkImage(
                                  imageUrl: controller.collections.first.image
                                          ?.originalSrc ??
                                      '',
                                  placeholder: (context, url) => Image.asset(
                                      'assets/images/lime-light-logo.png',
                                      fit: BoxFit.cover),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.contain,
                                  height: 180,
                                  width: 270,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                const SizedBox(
                  height: 40,
                ),
                _shimmerLowerEnable
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Shimmer.fromColors(
                                  enabled: _shimmerLowerEnable,
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 120,
                                    height: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Shimmer.fromColors(
                                  enabled: _shimmerLowerEnable,
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
                              physics: const NeverScrollableScrollPhysics(),
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
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15)),
                                              child: Shimmer.fromColors(
                                                enabled: _shimmerLowerEnable,
                                                baseColor: Colors.grey.shade300,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                      vertical: 5),
                                              child: Shimmer.fromColors(
                                                enabled: _shimmerLowerEnable,
                                                baseColor: Colors.grey.shade300,
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
                                              enabled: _shimmerLowerEnable,
                                              baseColor: Colors.grey.shade300,
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Trending',
                                    style: AppStyle.gfPoppinsBoldBlack(
                                        fontSize: 25)),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    _navigateToAllProductsScreen();
                                  },
                                  child: Text(
                                    'See All',
                                    style: AppStyle.gfPoppinsMediumWhite(
                                        fontSize: 19),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // const Icon(Icons.grid_view_rounded),
                                // const SizedBox(width: 10,),
                                // GestureDetector(onTap: (){setState(() {
                                //   listOrGrid = !listOrGrid;
                                // });},child: const Icon(CupertinoIcons.list_bullet)),
                                ToggleSwitch(
                                  iconSize: 28,
                                  totalSwitches: 2,
                                  icons: const [
                                    Icons.grid_view_rounded,
                                    CupertinoIcons.list_bullet
                                  ],
                                  initialLabelIndex: _currentIndex,
                                  onToggle: _toggleSwitch,
                                  minWidth: 90,
                                  minHeight: 40,
                                  cornerRadius: 20,
                                  activeBgColor: const [Colors.black],
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: Colors.grey,
                                  inactiveFgColor: Colors.white,
                                )
                              ],
                            ),
                          ),
                          GetX<HomeController>(builder: (controller) {
                            return controller.productsCount == 0
                                ? const Center(
                                    child: CupertinoActivityIndicator(
                                      radius: 14,
                                    ),
                                  )
                                : _currentIndex == 0
                                    ? ListView(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                // childAspectRatio: 1,
                                                crossAxisSpacing: 11,
                                                mainAxisSpacing: 10,
                                                mainAxisExtent: 400,
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
                                                debugPrint(
                                                    "Fav Icon State (${controller.bestSellingProducts[gridViewIndex].title}): $_favIconState");
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
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      Container(
                                                        width: 150,
                                                        height: 400,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          // border: Border.all(width: 0.7, color: Colors.grey),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15)),
                                                              child: SizedBox(
                                                                height: 245,
                                                                width: 195,
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
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        7,
                                                                    vertical:
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      controller
                                                                          .bestSellingProducts[
                                                                              gridViewIndex]
                                                                          .productVariants[
                                                                              0]
                                                                          .price
                                                                          .formattedPrice,
                                                                      style: AppStyle.gfPoppinsBoldBlack(
                                                                          fontSize:
                                                                              22),
                                                                    ),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        _navigateToAddToCartScreen(
                                                                            controller.bestSellingProducts[gridViewIndex]);
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        CupertinoIcons
                                                                            .bag_badge_plus,
                                                                        color: Colors
                                                                            .black,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              child: Text(
                                                                controller
                                                                    .bestSellingProducts[
                                                                        gridViewIndex]
                                                                    .title,
                                                                style: AppStyle
                                                                    .gfPoppinsMediumBlack(
                                                                        fontSize:
                                                                            13),
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 4,
                                                        right: 4,
                                                        child: IconButton(
                                                          key: UniqueKey(),
                                                          onPressed: () {
                                                            setState(() {
                                                              wishlistController
                                                                  .toggleFavorites(
                                                                      controller
                                                                              .bestSellingProducts[
                                                                          gridViewIndex]);
                                                            });
                                                            debugPrint(
                                                                "Length of Fav List : ${wishlistController.favouritesList.length}");
                                                          },
                                                          icon: Icon(
                                                            _favIconState
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border_outlined,
                                                            color: _favIconState
                                                                ? Colors.red
                                                                : null,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ],
                                      )
                                    : ListView.builder(
                                        itemCount: controller.productsCount,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          _favIconState = wishlistController
                                              .favouritesList
                                              .contains(controller
                                                  .bestSellingProducts[index]);
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0, vertical: 10),
                                            child: SizedBox(
                                              width: size.width - 21,
                                              height: 200,
                                              child: Stack(
                                                fit: StackFit.loose,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: SizedBox(
                                                          width: 145,
                                                          height: 180,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: controller
                                                                  .bestSellingProducts[
                                                                      index]
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
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            flex: 2,
                                                            child: SizedBox(
                                                              width: 210,
                                                              child: Text(
                                                                controller
                                                                    .bestSellingProducts[
                                                                        index]
                                                                    .title,
                                                                style: AppStyle
                                                                    .gfPoppinsMediumBlack(
                                                                        fontSize:
                                                                            15),
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                          Text(
                                                            controller
                                                                .bestSellingProducts[
                                                                    index]
                                                                .productVariants
                                                                .first
                                                                .price
                                                                .formattedPrice,
                                                            style: AppStyle
                                                                .gfPoppinsBoldBlack(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Positioned(
                                                    top: 0,
                                                    right: 0,
                                                    child: /*InkWell(
                                                      key: UniqueKey(),
                                                      onTap: () {
                                                        setState(() {
                                                          wishlistController
                                                              .toggleFavorites(
                                                                  controller
                                                                          .bestSellingProducts[
                                                                      index]);
                                                        });
                                                        debugPrint(
                                                            "Length of Fav List : ${wishlistController.favouritesList.length}");
                                                      },
                                                      child: Icon(
                                                        _favIconState
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border_outlined,
                                                        color: _favIconState
                                                            ? Colors.red
                                                            : null,
                                                        size: 24,
                                                      ),
                                                    ),*/
                                                        IconButton(
                                                      key: UniqueKey(),
                                                      onPressed: () {
                                                        setState(() {
                                                          wishlistController
                                                              .toggleFavorites(
                                                                  controller
                                                                          .bestSellingProducts[
                                                                      index]);
                                                        });
                                                        debugPrint(
                                                            "Length of Fav List : ${wishlistController.favouritesList.length}");
                                                      },
                                                      icon: Icon(
                                                        _favIconState
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border_outlined,
                                                        color: _favIconState
                                                            ? Colors.red
                                                            : null,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _navigateToAddToCartScreen(
                                                            controller
                                                                    .bestSellingProducts[
                                                                index]);
                                                      },
                                                      icon: const Icon(
                                                        CupertinoIcons
                                                            .bag_badge_plus,
                                                        color: Colors.black,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                          })
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
