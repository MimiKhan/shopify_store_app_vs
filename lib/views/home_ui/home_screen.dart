import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopify_store_app/controllers/cart_controller.dart';
import 'package:shopify_store_app/controllers/home_controller.dart';
import 'package:shopify_store_app/controllers/login_controller.dart';
import 'package:shopify_store_app/controllers/wish_list_controller.dart';
import 'package:shopify_store_app/models/cart_model.dart';
import 'package:shopify_store_app/shopify_models/models/models.dart';
import 'package:shopify_store_app/theme/app_style.dart';
import 'package:shopify_store_app/views/cart/add_to_cart/new_add_to_cart_screen.dart';
import 'package:shopify_store_app/views/categories/collections_details_screen.dart';
import 'package:shopify_store_app/views/products_details/new_product_details_screen.dart';
import 'package:shopify_store_app/widgets/exit_popup.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // customiseSystemOverlay(){
  //   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       statusBarBrightness: Brightness.dark,
  //       statusBarIconBrightness: Brightness.light));
  // }

  final homeController = Get.find<HomeController>();

  final cartController = Get.find<CartController>();
  final wishlistController = Get.find<WishListController>();
  final loginController = Get.find<LoginController>();
  bool isUserLoggedIn = false;
  late bool _favIconState;

  int _currentIndex = 0;

  // void _toggleSwitch(int? index) {
  //   setState(() {
  //     _currentIndex = index!;
  //   });
  // }

  void _navigateToAddToCartScreen(Product product) {
    Fluttertoast.showToast(msg: 'Routing to ${product.title}');
    debugPrint(product.id);
    Get.to(() => NewAddToCartScreen(product: product));
  }

  void _navigateToProductDetailScreen(Product product) {
    debugPrint(
        "Product Price **: CP :${product.productVariants.first.compareAtPrice?.formattedPrice} :*: P : ${product.productVariants.first.price.formattedPrice}");
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
    checkUserFromShopify();
    // waitForShimmerEffect();
  }

  Future<void> checkUserFromShopify() async {
    await loginController.checkUser().then((value) {
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
        if (mounted) {
          setState(() {
            isUserLoggedIn = true;
          });
        }
      }
    });
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
    var isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Explore",
            style: AppStyle.gfPoppinsMediumBlack(fontSize: 32),
          ),
          actions: [
            isUserLoggedIn
                ? GestureDetector(
                    onTap: () => Get.toNamed('/profileScreen'),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 24,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    width: 0,
                  ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Obx(() {
                  return homeController.isDataLoading.isTrue
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
                    height: 250,
                    child: GetX<HomeController>(builder: (controller) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          /*Positioned(
                                top: 60,
                                left: 35,
                                child: Text(
                                  "New Collection",
                                  style: AppStyle.gfRighteousBoldBlack(
                                      fontSize: 34),
                                ),
                              ),*/
                          controller.collectionsCount == 0
                              ? const Center(
                            child: CupertinoActivityIndicator(
                              radius: 14,
                            ),
                          )
                              : Center(
                            child: GetX<HomeController>(
                                builder: (controller) {
                                  return CarouselSlider(
                                    items: controller.collections.value
                                        .map((collection) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () {
                                              _navigateToCollectionDetailScreen(
                                                  collection.id,
                                                  collection.title);
                                            },
                                            child: Container(
                                              width: size.width,
                                              margin: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 5.0),
                                              decoration:
                                              BoxDecoration(
                                                color: Colors
                                                    .white,
                                                // borderRadius: BorderRadius.circular(15),
                                                // border: Border.all(
                                                //     color: Colors
                                                //         .black,
                                                //     width:
                                                //         1.2),
                                              ),
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
                                                fit: BoxFit.fill,
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
                                      enlargeCenterPage: true,
                                      // viewportFraction: 0.9,

                                      aspectRatio: 2.0,
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    }),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1.4,
                  color: Colors.grey.shade200,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  return homeController.isDataLoading.isTrue
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
                            Text('Popular Items',
                                style: AppStyle.gfPoppinsBoldBlack(
                                    fontSize: 25)),
                            isIOS
                                ? CupertinoButton.filled(
                                child: Text(
                                  'See All',
                                  style: AppStyle.gfPoppinsMediumWhite(
                                      fontSize: 19),
                                ),
                                onPressed: () {
                                  _navigateToAllProductsScreen();
                                })
                                : TextButton(
                              onPressed: () {
                                _navigateToAllProductsScreen();
                              },
                              child: Text(
                                'See All',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    decoration:
                                    TextDecoration.underline,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*Padding(
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
                    ),*/
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
                                                        .contain,
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
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
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
                                                          debugPrint(
                                                              "--*--HomeScreen--*Check Options*--> ${controller.bestSellingProducts[gridViewIndex].option.first.name}");
                                                          if (controller.bestSellingProducts[gridViewIndex].option.first.name ==
                                                              'Title') {
                                                            cartController.addItem(CartModel(
                                                                productVariant: controller.bestSellingProducts[gridViewIndex].productVariants.first,
                                                                product: controller.bestSellingProducts[gridViewIndex],
                                                                quantity: 1));
                                                            Fluttertoast.showToast(
                                                                msg: '${controller.bestSellingProducts[gridViewIndex].title} added to cart. Cart : ${cartController.cartModelItemsCount}');
                                                          } else {
                                                            _navigateToAddToCartScreen(
                                                                controller.bestSellingProducts[gridViewIndex]);
                                                          }
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
                              child: Container(
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
                                          debugPrint(
                                              "--*--HomeScreen--*Check Options*--> ${controller.bestSellingProducts[index].option.first.name}");
                                          if (controller
                                              .bestSellingProducts[
                                          index]
                                              .option
                                              .first
                                              .name ==
                                              'Title') {
                                            cartController.addItem(CartModel(
                                                productVariant: controller
                                                    .bestSellingProducts[
                                                index]
                                                    .productVariants
                                                    .first,
                                                product: controller
                                                    .bestSellingProducts[
                                                index],
                                                quantity: 1));
                                            Fluttertoast.showToast(
                                                msg:
                                                '${controller.bestSellingProducts[index].title} added to cart. Cart : ${cartController.cartModelItemsCount}');
                                          }
                                          // else {
                                          //   _navigateToAddToCartScreen(
                                          //       controller
                                          //               .bestSellingProducts[
                                          //           index]);
                                          // }
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
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
